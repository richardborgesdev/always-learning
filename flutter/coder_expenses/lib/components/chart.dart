import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../models/transaction.dart';
import './char_bar.dart';

class Chart extends StatelessWidget {
  final List<Transaction> recentTransaction;
  Chart(this.recentTransaction);

  List<Map<String, Object>> get groupedTransactions {
    return List.generate(7, (index) {
      final weekDay = DateTime.now().subtract(Duration(days: index));

      double totalSum = 0.0;
      for (var i = 0; i < recentTransaction.length; i++) {
        bool isSameDay = recentTransaction[i].date.day == weekDay.day;
        bool isSameMonth = recentTransaction[i].date.month == weekDay.month;
        bool isSameYear = recentTransaction[i].date.year == weekDay.year;

        if (isSameDay && isSameMonth && isSameYear) {
          totalSum = recentTransaction[i].value;
        }
      }

      Map<String, Object> chartValues = {
        'day': DateFormat.E().format(weekDay)[0],
        'value': totalSum
      };
      print(chartValues);

      return chartValues;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 6,
      margin: EdgeInsets.all(20),
      child: Row(
        children: groupedTransactions.map((tr) {
          return ChartBar(
              label: tr['day'].toString(),
              value: double.parse(tr['value'].toString()),
              percent: 0);
        }).toList(),
      ),
    );
  }
}
