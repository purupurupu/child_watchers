import 'package:flutter/material.dart';

Widget dayOfTheWeek(int index) {
  String text;
  String tmp = index.toString();

  switch (tmp) {
    case '0':
      text = "Sun";
      break;
    case '1':
      text = "Mon";
      break;
    case '2':
      text = "Tue";
      break;
    case '3':
      text = "Wed";
      break;
    case '4':
      text = "Thu";
      break;
    case '5':
      text = "Fri";
      break;
    case '6':
      text = "Sat";
      break;
    default:
      text = "day";
  }

  if (index == 0) {
    return Text(
      text,
      style: TextStyle(color: Colors.white),
    );
  } else if (index == 6) {
    return Text(
      text,
      style: TextStyle(color: Colors.white),
    );
  } else {
    return Text(
      text,
      style: TextStyle(color: Colors.white),
    );
  }
}
