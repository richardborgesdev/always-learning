import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../models/transaction.dart';
import 'chart_bar.dart';

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
    }).reversed.toList();
  }

  double get _weekValue {
    return groupedTransactions.fold(
        0.0,
        (previousValue, element) =>
            previousValue + (element['value'] as double));
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 6,
      margin: EdgeInsets.all(20),
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: groupedTransactions.map((tr) {
            return Flexible(
              fit: FlexFit.tight,
              child: ChartBar(
                  label: tr['day'].toString(),
                  value: (tr['value'] as double),
                  percent: _weekValue == 0
                      ? 0
                      : (tr['value'] as double) / _weekValue),
            );
          }).toList(),
        ),
      ),
    );
  }
}
