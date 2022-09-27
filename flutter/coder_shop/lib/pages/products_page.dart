import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop/components/app_drawer.dart';
import 'package:shop/models/product_list.dart';

import '../components/product_item.dart';
import '../utils/app_routes.dart';

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
        actions: [
          IconButton(
            onPressed: () {
              Navigator.of(
                context,
              ).pushNamed(
                AppRoutes.PRODUCTS_FORM,
              );
            },
            icon: Icon(
              Icons.add,
            ),
          ),
        ],
      ),
      drawer: AppDrawer(),
      body: Padding(
        padding: const EdgeInsets.all(
          8,
        ),
        child: ListView.builder(
          itemCount: products.itemsCount,
          itemBuilder: (context, index) => Column(
            children: [
              ProductItem(
                product: products.items[index],
              ),
              Divider(),
            ],
          ),
        ),
      ),
    );
  }
}
