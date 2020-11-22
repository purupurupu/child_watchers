import 'package:flutter/material.dart';

class FootNavigatorModel extends ChangeNotifier {
  int screenIndex = 0;
  String pageName = '';
  final List<String> pageList = [
    "Calender",
    "Contents",
  ];
  void setScreenIndex(int index) {
    screenIndex = index;
    pageName = pageList[index];
    notifyListeners();
  }
}
