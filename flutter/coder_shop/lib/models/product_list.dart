import 'dart:convert';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shop/data/dummy_data.dart';
import 'package:shop/models/product.dart';

class ProductList with ChangeNotifier {
  final _baseURL = 'https://addDBId-default-rtdb.firebaseio.com';

  List<Product> _items = dummyProducts;
  List<Product> get items => [..._items];
  List<Product> get favoriteItems =>
      _items.where((item) => item.isFavorite).toList();

  Future<void> addProduct(Product product) async {
    final postAddProductResponse = await http.post(
      Uri.parse('$_baseURL/products.json'),
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

  Future<void> updateProduct(Product product) {
    int index = _items.indexWhere(((p) => p.id == product.id));

    if (index >= 0) {
      _items[index] = product;
      notifyListeners();
    }

    return Future.value();
  }

  void removeProduct(Product product) {
    int index = _items.indexWhere(((p) => p.id == product.id));

    if (index >= 0) {
      _items.removeWhere(((p) => p.id == product.id));
      notifyListeners();
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
