import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop/pages/orders_page.dart';
import 'package:shop/utils/app_routes.dart';
import 'package:shop/utils/custom_route.dart';

import '../models/auth.dart';

class AppDrawer extends StatelessWidget {
  const AppDrawer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: [
          AppBar(
            title: Text(
              'Bem vindo Usuário',
            ),
            automaticallyImplyLeading: false,
          ),
          Divider(),
          ListTile(
            leading: Icon(
              Icons.shop,
            ),
            title: Text(
              'Loja',
            ),
            onTap: () {
              Navigator.of(context).pushReplacementNamed(
                AppRoutes.AUTH_OR_HOME,
              );
            },
          ),
          Divider(),
          ListTile(
            leading: Icon(
              Icons.payment,
            ),
            title: Text(
              'Pedidos',
            ),
            onTap: () {
              // Navigator.of(context).pushReplacementNamed(
              //   AppRoutes.ORDERS,
              // );
              Navigator.of(context).pushReplacement(
                CustomRoute(
                  builder: (ctx) => OrdersPage(),
                ),
              );
            },
          ),
          Divider(),
          ListTile(
            leading: Icon(
              Icons.edit,
            ),
            title: Text(
              'Gerencia Produtos',
            ),
            onTap: () {
              Navigator.of(context).pushReplacementNamed(
                AppRoutes.PRODUCTS,
              );
            },
          ),
          Divider(),
          ListTile(
            leading: Icon(
              Icons.exit_to_app,
            ),
            title: Text(
              'Sair',
            ),
            onTap: () {
              Provider.of<Auth>(
                context,
                listen: false,
              ).logout();

              Navigator.of(context).pushReplacementNamed(
                AppRoutes.AUTH_OR_HOME,
              );
            },
          ),
        ],
      ),
    );
  }
}
