import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop/models/product_list.dart';
import '../models/product.dart';
import '../components/product_item.dart';

class ProductGrid extends StatelessWidget {
  final bool showFavoriteOnly;

  ProductGrid(
    this.showFavoriteOnly,
  );

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<ProductList>(context);
    final List<Product> loadedProducts =
        showFavoriteOnly ? provider.favoriteItems : provider.items;

    return GridView.builder(
      padding: const EdgeInsets.all(10.0),
      itemCount: loadedProducts.length,
      itemBuilder: (ctx, i) => ChangeNotifierProvider.value(
        value: loadedProducts[i],
        child: ProductItem(),
      ),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 3 / 2,
        crossAxisSpacing: 10,
        mainAxisSpacing: 10,
      ),
    );
  }
}
