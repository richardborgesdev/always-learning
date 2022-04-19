import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'dart:io';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:intl/intl.dart';

class AdaptativeDatePicker extends StatelessWidget {
  final DateTime selectedDate;
  final Function(DateTime) onDateChanged;

  AdaptativeDatePicker({
    required this.selectedDate,
    required this.onDateChanged,
  });

  bool isCupertino() {
    return !kIsWeb && Platform.isIOS;
  }

  _showDatePicker(BuildContext context) {
    showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2019),
      lastDate: DateTime.now(),
    ).then((pickedDate) {
      if (pickedDate == null) {
        return;
      }

      onDateChanged(pickedDate);
    });
  }

  @override
  Widget build(BuildContext context) {
    return isCupertino()
        ? Container(
            height: 180,
            child: CupertinoDatePicker(
              mode: CupertinoDatePickerMode.date,
              initialDateTime: DateTime.now(),
              minimumDate: DateTime(2019),
              maximumDate: DateTime.now(),
              onDateTimeChanged: onDateChanged,
            ),
          )
        : Container(
            height: 70,
            child: Row(
              children: [
                Expanded(
                  child: Text(selectedDate == null
                      ? 'Nenhuma data selecionada'
                      : 'Data Selecionada: ${DateFormat('dd/MM/yy').format(selectedDate)}'),
                ),
                TextButton(
                  onPressed: () => _showDatePicker(context),
                  child: Text('Selecionar Data'),
                  style: TextButton.styleFrom(
                    primary: Colors.purple,
                    textStyle: TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                )
              ],
            ),
          );
  }
}
