import 'package:flutter/material.dart';
import 'package:shop/utils/app_routes.dart';

import '../models/product.dart';

class ProductItem extends StatelessWidget {
  final Product product;

  const ProductItem({
    Key? key,
    required this.product,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: CircleAvatar(
        backgroundImage: NetworkImage(
          product.imageUrl,
        ),
      ),
      title: Text(
        product.name,
      ),
      trailing: Container(
        width: 100,
        child: Row(children: [
          IconButton(
            onPressed: () {
              Navigator.of(
                context,
              ).pushNamed(
                AppRoutes.PRODUCTS_FORM,
                arguments: product,
              );
            },
            icon: Icon(
              Icons.edit,
            ),
            color: Theme.of(
              context,
            ).primaryColor,
          ),
          IconButton(
            onPressed: () {},
            icon: Icon(
              Icons.delete,
            ),
            color: Theme.of(
              context,
            ).errorColor,
          ),
        ]),
      ),
    );
  }
}
