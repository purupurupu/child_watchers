import 'package:flutter/material.dart';

class SetDayAndScheduleModel extends ChangeNotifier {
  int days = 0;
  String currentYear = "";
  String currentMonth = "";
  String currentDay = "";

  void incDays() {
    days++;
    // notifyListeners();
  }

  void resetDays() {
    days = 0;
    // notifyListeners();
  }

  void setCurrentDate(DateTime date) {
    currentYear = date.year.toString();
    currentMonth = date.month.toString();
    currentDay = date.day.toString();
  }

  //init month decide
  void setCurrentMonth(String month) {
    currentMonth = month;
  }

  String getCurrentMonth() {
    return currentMonth;
  }

  void setLastMonth() {
    if (currentMonth == '1') {
      currentMonth = '12';
      currentYear = (int.parse(currentYear) - 1).toString();
    } else {
      currentMonth = (int.parse(currentMonth) - 1).toString();
    }
  }

  void setNextMonth() {
    if (currentMonth == '12') {
      currentMonth = '1';
      currentYear = (int.parse(currentYear) + 1).toString();
    } else {
      currentMonth = (int.parse(currentMonth) + 1).toString();
    }
  }

  //firestoreからスケジュール持ってくる
}
