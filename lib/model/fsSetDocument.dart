import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

void fsSetDocument(String colletion, String date, String event) {
  FirebaseFirestore.instance.collection(colletion).doc(date).set({
    "schedule": event,
  });
}
