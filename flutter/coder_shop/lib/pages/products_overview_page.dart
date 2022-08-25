import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop/models/product_list.dart';
import '../components/product_grid.dart';

enum FilterOptions {
  Favorite,
  All,
}

class ProductsOverviewPage extends StatefulWidget {
  @override
  State<ProductsOverviewPage> createState() => _ProductsOverviewPageState();
}

class _ProductsOverviewPageState extends State<ProductsOverviewPage> {
  bool _showFavoriteOnly = false;

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<ProductList>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text('Minha loja'),
        actions: [
          PopupMenuButton(
            icon: Icon(
              Icons.more_vert,
            ),
            itemBuilder: (_) => [
              PopupMenuItem(
                child: Text(
                  'Somente favoritos',
                ),
                value: FilterOptions.Favorite,
              ),
              PopupMenuItem(
                child: Text(
                  'Todos',
                ),
                value: FilterOptions.All,
              ),
            ],
            onSelected: (FilterOptions selectedValue) {
              setState(() {
                if (selectedValue == FilterOptions.Favorite) {
                  // provider.showFavoriteOnly();
                  _showFavoriteOnly = true;
                } else {
                  // provider.showAll();
                  _showFavoriteOnly = false;
                }
              });
            },
          ),
          IconButton(
            onPressed: () {},
            icon: Icon(
              Icons.shopping_cart,
            ),
          ),
        ],
      ),
      body: ProductGrid(_showFavoriteOnly),
    );
  }
}
