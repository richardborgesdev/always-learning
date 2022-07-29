import 'package:flutter/material.dart';
import 'package:shop/providers/counter.dart';

class CounterPage extends StatelessWidget {
  const CounterPage({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Exemplo Contador',
        ),
      ),
      body: Column(
        children: [
          Text(
            '0',
          ),
          IconButton(
            onPressed: () {
              print(CounterProvider.of(context));
            },
            icon: Icon(Icons.add),
          ),
        ],
      ),
    );
  }
}
