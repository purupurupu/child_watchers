// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:flutter/material.dart';

// class FSGetScheduleModel extends ChangeNotifier {
//   String text = "";

//   Future fsGetSchedule(date) async {
//     try {
//       final snapshot = await FirebaseFirestore.instance
//           .collection('baby')
//           .doc('yuto')
//           .collection('20201225')
//           .doc('schedule')
//           .get();

//       debugPrint(snapshot['text']);
//       text = snapshot['text'];
//       notifyListeners();
//     } catch (e) {
//       debugPrint("not exists data in firestore ");
//     }
//   }
// }
