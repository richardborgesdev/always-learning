import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop/components/app_drawer.dart';
import 'package:shop/components/order.dart';
import 'package:shop/models/order_list.dart';

class OrdersPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final OrderList orders = Provider.of(context);

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Meus Pedidos',
        ),
      ),
      drawer: AppDrawer(),
      body: ListView.builder(
        itemCount: orders.items.length,
        itemBuilder: (context, index) => OrderWidget(
          order: orders.items[index],
        ),
      ),
    );
  }
}
