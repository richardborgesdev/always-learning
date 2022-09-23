import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop/components/app_drawer.dart';
import 'package:shop/models/product_list.dart';

class ProductsPage extends StatelessWidget {
  const ProductsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final ProductList products = Provider.of(context);

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Gerenciar produtos',
        ),
      ),
      drawer: AppDrawer(),
      body: Padding(
        padding: const EdgeInsets.all(
          8,
        ),
        child: ListView.builder(
          itemCount: products.itemsCount,
          itemBuilder: (context, index) => Text(
            products.items[index].name,
          ),
        ),
      ),
    );
  }
}
