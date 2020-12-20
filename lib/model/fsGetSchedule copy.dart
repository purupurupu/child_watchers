import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

Future<String> aaaaFSGetSchedule() async {
  try {
    final snapshot = await FirebaseFirestore.instance
        .collection('baby')
        .doc('yuto')
        .collection('20201225')
        .doc('schedule')
        .get();

    debugPrint(snapshot['text']);

    // Map<String, dynamic> result = {
    //   'text': snapshot['text'],
    // };

    String result = snapshot['text'];

    return result;
  } catch (e) {
    debugPrint("not exists data in firestore ");
  }
}
