// import 'dart:developer';

import 'package:child_watchers/components/dayAndSchedule.dart';
import 'package:child_watchers/components/dayOfTHeWeek.dart';
import 'package:child_watchers/model/calendarPageModel.dart';
import 'package:child_watchers/model/dayAndScheduleModel.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cell_calendar/cell_calendar.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../components/footNavigator.dart';

class CalenderPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final today = DateTime.now();
    var _eventController = TextEditingController();
    var _selectedDate = '';

    // final _sampleEvents = sampleEvents();

    List<CalendarEvent> _testEvents = [];

    return Scaffold(
      appBar: AppBar(
        title: Text('title'),
      ),
      body: StreamBuilder(
        stream: FirebaseFirestore.instance.collection('yuto').snapshots(),
        builder: (context, snapshot) {
          if (snapshot.data == null) return CircularProgressIndicator();

          //　firestoreからデータを取得して配列へ格納
          for (var i = 0; i < snapshot.data.docs.length; i++) {
            if (snapshot.data.docs[i].id.length == 8) {
              String tmpDays = snapshot.data.docs[i].id.toString();

              int tmpYear = int.parse(tmpDays.substring(0, 4));
              int tmpMonth = int.parse(tmpDays.substring(4, 6));
              int tmpDay = int.parse(tmpDays.substring(6, 8));

              DateTime a = DateTime(tmpYear, tmpMonth, tmpDay, 0, 0);
              DateTime b = DateTime(today.year, today.month, today.day, 0, 0);
              // print(a.difference(b).inDays);
              //登録されている日付と、現時点の日付を比較
              int diffDays = a.difference(b).inDays;

              _testEvents.add(
                CalendarEvent(
                    eventName: snapshot.data.docs[i]['schedule'],
                    eventDate: today.add(Duration(days: diffDays)),
                    eventBackgroundColor: Colors.black),
              );
            } else {
              continue;
            }
          }

          return CellCalendar(
            events: _testEvents,
            onCellTapped: (date) {
              final eventsOnTheDate = _testEvents.where((event) {
                final eventDate = event.eventDate;
                return eventDate.year == date.year &&
                    eventDate.month == date.month &&
                    eventDate.day == date.day;
              }).toList();
              showDialog(
                  context: context,
                  builder: (_) => AlertDialog(
                        title: Text(
                            date.month.monthName + " " + date.day.toString()),
                        content: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: eventsOnTheDate
                              .map(
                                (event) => Container(
                                  width: double.infinity,
                                  padding: EdgeInsets.all(4),
                                  margin: EdgeInsets.only(bottom: 12),
                                  color: event.eventBackgroundColor,
                                  child: Text(
                                    event.eventName,
                                    // snapshot.data.docs[0]['schedule'],

                                    style:
                                        TextStyle(color: event.eventTextColor),
                                  ),
                                ),
                              )
                              .toList(),
                        ),
                      ));
            },
            onPageChanged: (firstDate, lastDate) {
              /// Called when the page was changed
              /// Fetch additional events by using the range between [firstDate] and [lastDate] if you want
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {
          showDialog(
            context: context,
            builder: (context) {
              return (Consumer<DatePickerModel>(
                builder: (context, model, child) {
                  return Column(
                    children: <Widget>[
                      AlertDialog(
                        title: Text("イベント入力"),
                        content: SingleChildScrollView(
                          child: Column(
                            // コンテンツ
                            children: [
                              Text(''),
                              IconButton(
                                icon: Icon(Icons.calendar_today),
                                onPressed: () async {
                                  final selectedDate = await showDatePicker(
                                    context: context,
                                    initialDate: DateTime.now(),
                                    firstDate: DateTime(DateTime.now().year),
                                    lastDate: DateTime(DateTime.now().year + 1),
                                  );

                                  if (selectedDate != null) {
                                    // do something
                                    debugPrint(selectedDate.toString());
                                    model.setSelectedDate(selectedDate);
                                    // model.selectedDate =
                                    //     selectedDate.toString();
                                  }
                                },
                              ),
                              Text(model.selectedDate),
                              TextField(
                                decoration: InputDecoration(
                                  labelText: 'イベント名',
                                  hintText: 'イベント名を入力してください',
                                  icon: Icon(Icons.event),
                                ),
                                controller: _eventController,
                                autocorrect: false,
                                autofocus: true,
                                keyboardType: TextInputType.text,
                                // onChanged: _userNameChanged,
                                // onSubmitted: _eventController,
                              ),
                              // Text(_eventController.text),
                            ],
                          ),
                        ),
                        actions: <Widget>[
                          // ボタン
                          RaisedButton(
                            child: const Text('Cancel'),
                            color: Colors.blue,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                            onPressed: () {
                              //ダイアログクローズ
                              Navigator.pop(context);
                            },
                          ),
                          RaisedButton(
                            child: const Text('OK'),
                            color: Colors.blue,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                            //fsへ登録後、選択日付をクリア
                            onPressed: () {
                              //fs登録処理

                              debugPrint(model.getSelectedDate());
                              //_eventController.text;

                              Navigator.pop(context);
                              model.initSelectedDate();
                            },
                          ),
                        ],
                      ),
                    ],
                  );
                },
              ));
            },
          );
        },
      ),
      bottomNavigationBar: footNavigator(),
      // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}

// List<CalendarEvent> sampleEvents() {
//   final today = DateTime.now();

//   final sampleEvents = [
//     CalendarEvent(
//         eventName: "New iPhone",
//         eventDate: today.add(Duration(days: -42)),
//         eventBackgroundColor: Colors.black),
//     CalendarEvent(
//         eventName: "Writing test",
//         eventDate: today.add(Duration(days: -30)),
//         eventBackgroundColor: Colors.deepOrange),
//     CalendarEvent(
//         eventName: "Play soccer",
//         eventDate: today.add(Duration(days: -7)),
//         eventBackgroundColor: Colors.greenAccent),
//     CalendarEvent(
//         eventName: "Learn about history",
//         eventDate: today.add(Duration(days: -7))),
//     CalendarEvent(
//         eventName: "Buy new keyboard",
//         eventDate: today.add(Duration(days: -7))),
//     CalendarEvent(
//         eventName: "Walk around the park",
//         eventDate: today.add(Duration(days: -7)),
//         eventBackgroundColor: Colors.deepOrange),
//     CalendarEvent(
//         eventName: "Buy a present for Rebecca",
//         eventDate: today.add(Duration(days: -7)),
//         eventBackgroundColor: Colors.pink),
//     CalendarEvent(
//         eventName: "Firebase", eventDate: today.add(Duration(days: -7))),
//     CalendarEvent(eventName: "Task Deadline", eventDate: today),
//     CalendarEvent(
//         eventName: "Jon's Birthday",
//         eventDate: today.add(Duration(days: 3)),
//         eventBackgroundColor: Colors.green),
//     CalendarEvent(
//         eventName: "Date with Rebecca",
//         eventDate: today.add(Duration(days: 7)),
//         eventBackgroundColor: Colors.pink),
//     CalendarEvent(
//         eventName: "Start to study Spanish",
//         eventDate: today.add(Duration(days: 13))),
//     CalendarEvent(
//         eventName: "Have lunch with Mike",
//         eventDate: today.add(Duration(days: 13)),
//         eventBackgroundColor: Colors.green),
//     CalendarEvent(
//         eventName: "Buy new Play Station software",
//         eventDate: today.add(Duration(days: 13)),
//         eventBackgroundColor: Colors.indigoAccent),
//     CalendarEvent(
//         eventName: "Update my flutter package",
//         eventDate: today.add(Duration(days: 13))),
//     CalendarEvent(
//         eventName: "Watch movies in my house",
//         eventDate: today.add(Duration(days: 21))),
//     CalendarEvent(
//         eventName: "Medical Checkup",
//         eventDate: today.add(Duration(days: 30)),
//         eventBackgroundColor: Colors.red),
//     CalendarEvent(
//         eventName: "Gym",
//         eventDate: today.add(Duration(days: 42)),
//         eventBackgroundColor: Colors.indigoAccent),
//   ];
//   return sampleEvents;
// }

// Future<List<CalendarEvent>> fsGetDocuments() async {
//   var tmp = [];
//   try {
//     final snapshot = await FirebaseFirestore.instance.collection('yuto').get();
//     snapshot.docs.map((doc) => {tmp.add(doc)});
//     // debugPrint(snapshot.docs[0]['schedule']);
//     // notifyListeners();
//   } catch (e) {
//     debugPrint("not exists data in firestore ");
//   }
// }
