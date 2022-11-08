import 'dart:convert';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
// import 'package:shop/data/dummy_data.dart';
import 'package:shop/models/product.dart';
import 'package:shop/exceptions/http_exception.dart';

class ProductList with ChangeNotifier {
  final _baseURL = 'https://addDBId-default-rtdb.firebaseio.com/products';

  // List<Product> _items = dummyProducts;
  List<Product> _items = [];
  List<Product> get items => [..._items];
  List<Product> get favoriteItems =>
      _items.where((item) => item.isFavorite).toList();

  Future<void> addProduct(Product product) async {
    final postAddProductResponse = await http.post(
      Uri.parse('$_baseURL.json'),
      body: jsonEncode({
        "name": product.name,
        "description": product.description,
        "price": product.price,
        "imageUrl": product.imageUrl,
        "isFavorite": product.isFavorite,
      }),
    );

    final id = jsonDecode(postAddProductResponse.body)['name'];
    _items.add(
      Product(
        id: id,
        name: product.name,
        description: product.description,
        price: product.price,
        imageUrl: product.imageUrl,
        isFavorite: product.isFavorite,
      ),
    );

    _items.add(product);
    notifyListeners();
  }

  Future<void> loadProducts() async {
    _items.clear();

    final response = await http.get(
      Uri.parse('$_baseURL.json'),
    );

    if (response.body == 'null') return;

    Map<String, dynamic> data = jsonDecode(response.body);

    data.forEach((productId, productData) {
      _items.add(
        Product(
          id: productId,
          name: productData['name'],
          description: productData['description'],
          price: productData['price'],
          imageUrl: productData['imageUrl'],
          isFavorite: productData['isFavorite'],
        ),
      );

      notifyListeners();
    });
  }

  Future<void> updateProduct(Product product) async {
    int index = _items.indexWhere(((p) => p.id == product.id));

    if (index >= 0) {
      await http.patch(
        Uri.parse('$_baseURL/${product.id}.json'),
        body: jsonEncode({
          "name": product.name,
          "description": product.description,
          "price": product.price,
          "imageUrl": product.imageUrl,
        }),
      );

      _items[index] = product;
      notifyListeners();
    }
  }

  Future<void> removeProduct(Product product) async {
    int index = _items.indexWhere(((p) => p.id == product.id));

    if (index >= 0) {
      final product = _items[index];
      _items.remove(product);
      notifyListeners();

      final response = await http.delete(
        Uri.parse('$_baseURL/${product.id}.json'),
      );

      if (response.statusCode >= 400) {
        _items.insert(
          index,
          product,
        );
        notifyListeners();

        throw HttpException(
          msg: 'Não foi possível excluir o produto',
          statusCode: response.statusCode,
        );
      }
    }
  }

  Future<void> saveProductFromData(Map<String, Object> data) {
    bool hasId = data['id'] != null;

    final newProduct = Product(
      id: hasId ? data['id'] as String : Random().nextDouble().toString(),
      name: data['name'] as String,
      description: data['description'] as String,
      price: data['price'] as double,
      imageUrl: data['imageUrl'] as String,
    );

    if (hasId) {
      return updateProduct(newProduct);
    } else {
      return addProduct(newProduct);
    }
  }

  int get itemsCount {
    return _items.length;
  }
}
