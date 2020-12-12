import 'package:flutter/material.dart';

class SetDayAndScheduleModel extends ChangeNotifier {
  int days = 0;

  void incDays() {
    days++;
    // notifyListeners();
  }

  void resetDays() {
    days = 0;
    // notifyListeners();
  }

  //firestoreからスケジュール持ってくる
}
