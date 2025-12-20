



import 'package:flutter/material.dart';

class PageHistoryProvider with ChangeNotifier {
  List<String> _history = [];

  List<String> get history => _history;

  void addPage(String pageName) {
    _history.add(pageName);
    notifyListeners();
  }
}
