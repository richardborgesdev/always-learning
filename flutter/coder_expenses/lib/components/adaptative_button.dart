import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'dart:io';
import 'package:flutter/foundation.dart' show kIsWeb;

class AdaptativeButton extends StatelessWidget {
  final String label;
  final Function() onPressed;

  AdaptativeButton({
    this.label = '',
    required this.onPressed,
  });

  bool isCupertino() {
    return !kIsWeb && Platform.isIOS;
  }

  @override
  Widget build(BuildContext context) {
    return isCupertino()
        ? CupertinoButton(
            child: Text(label),
            onPressed: onPressed,
            color: Theme.of(context).textTheme.button?.color,
            padding: EdgeInsets.symmetric(
              horizontal: 20,
            ),
          )
        : TextButton(
            onPressed: onPressed,
            child: Text(label),
            style: TextButton.styleFrom(
              primary: Theme.of(context).textTheme.button?.color,
              backgroundColor: Theme.of(context).colorScheme.primary,
            ),
          );
  }
}
