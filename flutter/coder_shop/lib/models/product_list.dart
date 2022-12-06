import 'dart:convert';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shop/models/product.dart';
import 'package:shop/exceptions/http_exception.dart';

import '../utils/constants.dart';

class ProductList with ChangeNotifier {
  String _token;
  String _userId;
  List<Product> _items = [];
  List<Product> get items => [..._items];
  List<Product> get favoriteItems =>
      _items.where((item) => item.isFavorite).toList();

  ProductList([
    this._token = '',
    this._userId = '',
    this._items = const [],
  ]);

  Future<void> addProduct(Product product) async {
    final postAddProductResponse = await http.post(
      Uri.parse('${Constants.PRODUCT_BASE_URL}.json?auth=$_token'),
      body: jsonEncode({
        "name": product.name,
        "description": product.description,
        "price": product.price,
        "imageUrl": product.imageUrl,
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
      ),
    );

    _items.add(product);
    notifyListeners();
  }

  Future<void> loadProducts() async {
    _items.clear();

    final response = await http.get(
      Uri.parse('${Constants.PRODUCT_BASE_URL}.json?auth=$_token'),
    );

    if (response.body == 'null') return;

    final favResponse = await http.get(
      Uri.parse('${Constants.USER_FAVORITES_URL}/$_userId.json?auth=$_token'),
    );

    Map<String, dynamic> favData =
        favResponse.body == 'null' ? {} : jsonDecode(favResponse.body);

    Map<String, dynamic> data = jsonDecode(response.body);

    data.forEach((productId, productData) {
      final isFavorite = favData[productId] ?? false;
      _items.add(
        Product(
          id: productId,
          name: productData['name'],
          description: productData['description'],
          price: productData['price'],
          imageUrl: productData['imageUrl'],
          isFavorite: isFavorite,
        ),
      );

      notifyListeners();
    });
  }

  Future<void> updateProduct(Product product) async {
    int index = _items.indexWhere(((p) => p.id == product.id));

    if (index >= 0) {
      await http.patch(
        Uri.parse(
            '${Constants.PRODUCT_BASE_URL}/${product.id}.json?auth=$_token'),
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
        Uri.parse(
            '${Constants.PRODUCT_BASE_URL}/${product.id}.json?auth=$_token'),
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
