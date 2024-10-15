import 'package:flutter/material.dart';

class AppData with ChangeNotifier {
  List<String> _actions = [];
  int _counter = 0;

  List<String> get actions => _actions;
  int get counter => _counter;

  void addItem(String action) {
    _actions.add(action);
    notifyListeners(); 
  }

  void incrementCounter() {
    _counter++;
    addItem('Incremented counter used');
    notifyListeners();
  }

}