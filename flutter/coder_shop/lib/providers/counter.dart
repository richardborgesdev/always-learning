import 'package:flutter/widgets.dart';

class CounterState {
  int _value = 0;

  void inc() => _value++;
  void dev() => _value--;
  int get value => _value;
}

class CounterProvider extends InheritedWidget {
  final CounterState state = CounterState();

  CounterProvider({
    required Widget child,
  }) : super(child: child);

  static CounterProvider? of(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<CounterProvider>();
  }

  @override
  bool updateShouldNotify(covariant InheritedWidget oldWidget) {
    throw true;
  }
}
