import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:shop/models/order.dart';

import '../utils/constants.dart';
import 'cart.dart';

class OrderList with ChangeNotifier {
  List<Order> _items = [];

  List<Order> get items {
    return [..._items];
  }

  int get itemsCount {
    return _items.length;
  }

  Future<void> addOrder(Cart cart) async {
    final date = DateTime.now();
    final postAddOrderResponse = await http.post(
      Uri.parse('${Constants.ORDERS_BASE_URL}.json'),
      body: jsonEncode({
        "total": cart.totalAmount,
        "date": date.toIso8601String(),
        "products": cart.items.values
            .map((cartItem) => {
                  "id": cartItem.id,
                  "productId": cartItem.productId,
                  "name": cartItem.name,
                  "quantity": cartItem.quantity,
                  "price": cartItem.price,
                })
            .toList(),
      }),
    );

    final id = jsonDecode(postAddOrderResponse.body)['name'];
    _items.insert(
      0,
      Order(
        id: id,
        total: cart.totalAmount,
        products: cart.items.values.toList(),
        date: date,
      ),
    );

    notifyListeners();
  }
}
