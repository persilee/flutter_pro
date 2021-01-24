import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

//使用 riverpod 只需要在全局定义一个 provider
final counterProvider = StateProvider((ref) => 0);

//使用provider需要定义一个 ChangeNotifier 类
class CounterModel with ChangeNotifier {
  int _count = 0;
  int get value => _count;

  void increment() {
    _count ++;
    notifyListeners();
  }
}