import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class CalendarPageModel extends ChangeNotifier {
  String selectedDate = '日付未選択';
  DateTime selectedDateTime;

  void setSelectedDate(DateTime date) {
    selectedDateTime = date;
    selectedDate = date.year.toString() +
        '年' +
        date.month.toString() +
        '月' +
        date.day.toString() +
        '日';
    notifyListeners();
  }

  String getSelectedDate() {
    String year = '';
    String month = '';
    String day = '';

    if (selectedDate == '日付未選択') {}

    year = selectedDateTime.year.toString();

    if (selectedDateTime.month.toString().length == 1) {
      month = '0' + selectedDateTime.month.toString();
    } else if (selectedDateTime.month.toString().length == 2) {
      month = selectedDateTime.month.toString();
    }
    if (selectedDateTime.day.toString().length == 1) {
      day = '0' + selectedDateTime.day.toString();
    } else if (selectedDateTime.day.toString().length == 2) {
      day = selectedDateTime.day.toString();
    }

    return (year + month + day);
  }

  void initSelectedDate() {
    selectedDate = '日付未選択';
    notifyListeners();
  }
}
