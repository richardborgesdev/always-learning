import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop/components/app_drawer.dart';
import 'package:shop/components/order.dart';
// import 'package:shop/models/order.dart';
import 'package:shop/models/order_list.dart';

class OrdersPage extends StatelessWidget {
//   @override
//   State<OrdersPage> createState() => _OrdersPageState();
// }

// class _OrdersPageState extends State<OrdersPage> {
  // bool _isLoading = true;

  // @override
  // void initState() {
  //   // TODO: implement initState
  //   super.initState();
  //   Provider.of<OrderList>(
  //     context,
  //     listen: false,
  //   ).loadOrders().then((_) => {
  //         setState(() {
  //           _isLoading = false;
  //         })
  //       });
  // }

  @override
  Widget build(BuildContext context) {
    // final OrderList orders = Provider.of(context);

    return Scaffold(
        appBar: AppBar(
          title: Text(
            'Meus Pedidos',
          ),
        ),
        drawer: AppDrawer(),
        body: FutureBuilder(
          future: Provider.of<OrderList>(
            context,
            listen: false,
          ).loadOrders(),
          builder: ((context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(
                child: CircularProgressIndicator(),
              );
            } else if (snapshot.error != null) {
              return Center(
                child: Text(
                  'ocorreu um erro!',
                ),
              );
            } else {
              return Consumer<OrderList>(
                builder: (context, orders, child) => ListView.builder(
                  itemCount: orders.items.length,
                  itemBuilder: (context, index) => OrderWidget(
                    order: orders.items[index],
                  ),
                ),
              );
            }
          }),
        )
        // body: _isLoading
        //     ? Center(
        //         child: CircularProgressIndicator(),
        //       )
        //     : ListView.builder(
        //         itemCount: orders.items.length,
        //         itemBuilder: (context, index) => OrderWidget(
        //           order: orders.items[index],
        //         ),
        //       ),
        );
  }
}
