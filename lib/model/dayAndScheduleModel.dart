import 'package:flutter/material.dart';

class SetDayAndScheduleModel extends ChangeNotifier {
  int days = 0;
  String currentMonth = "";

  void incDays() {
    days++;
    // notifyListeners();
  }

  void resetDays() {
    days = 0;
    // notifyListeners();
  }

  //init month decide
  void setCurrentMonth(String month) {
    currentMonth = month;
  }

  String getCurrentMonth() {
    return currentMonth;
  }

  void setPrevMonth(String month) {
    currentMonth = (int.parse(month) - 1).toString();
  }

  void setNextMonth(String month) {
    currentMonth = (int.parse(month) - 1).toString();
  }

  //firestoreからスケジュール持ってくる
}
