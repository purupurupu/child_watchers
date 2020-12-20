import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class SetDayAndScheduleModel extends ChangeNotifier {
  int days = 0;
  String currentYear = "";
  String currentMonth = "";
  String currentDay = "";
  String text = "";
  // DocumentSnapshot docSnapshot;

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

  Future<Map<String, dynamic>> fsGetSchedule(String date) async {
    try {
      DocumentSnapshot docSnapshot = await FirebaseFirestore.instance
          .collection('yuto')
          .doc('$date')
          .get();

      debugPrint(docSnapshot['schedule']);
      return docSnapshot.data();
    } catch (e) {
      // docSnapshot = "aaaa" as DocumentSnapshot;
      debugPrint("not exists data in firestore ");
    }
  }

  // firestoreからスケジュール持ってくる
  // Future fsGetSchedule(String date) async {
  //   try {
  //     final snapshot = await FirebaseFirestore.instance
  //         .collection('baby')
  //         .doc('yuto')
  //         .collection('$date')
  //         .doc('schedule')
  //         .get();

  //     // debugPrint(snapshot['text']);
  //     text = snapshot['text'];
  //     // notifyListeners();
  //   } catch (e) {
  //     text = "";
  //     debugPrint("not exists data in firestore ");
  //   }
  // }
}
