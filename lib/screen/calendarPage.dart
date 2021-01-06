// import 'dart:developer';

import 'package:child_watchers/components/dayAndSchedule.dart';
import 'package:child_watchers/components/dayOfTHeWeek.dart';
import 'package:child_watchers/model/calendarPageModel.dart';
import 'package:child_watchers/model/dayAndScheduleModel.dart';
import 'package:child_watchers/model/fsSetDocument.dart';
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

    List<CalendarEvent> _testEvents;

    return Scaffold(
      appBar: AppBar(
        title: Text('title'),
      ),
      body: StreamBuilder(
        stream: FirebaseFirestore.instance.collection('yuto').snapshots(),
        builder: (context, snapshot) {
          if (snapshot.data == null) return CircularProgressIndicator();

          //fsロード後に実行しなければ不定になる
          _testEvents = List(snapshot.data.docs.length - 1);

          //　firestoreからデータを取得して配列へ格納
          for (var i = 0; i < snapshot.data.docs.length; i++) {
            if (snapshot.data.docs[i].id.length == 8) {
              String tmpDate = snapshot.data.docs[i].id.toString();

              int tmpYear = int.parse(tmpDate.substring(0, 4));
              int tmpMonth = int.parse(tmpDate.substring(4, 6));
              int tmpDay = int.parse(tmpDate.substring(6, 8));

              DateTime a = DateTime(tmpYear, tmpMonth, tmpDay, 0, 0);
              DateTime b = DateTime(today.year, today.month, today.day, 0, 0);
              // print(a.difference(b).inDays);
              //登録されている日付と、現時点の日付を比較
              int diffDays = a.difference(b).inDays;

              // _testEvents.add(
              //   CalendarEvent(
              //       eventName: snapshot.data.docs[i]['schedule'],
              //       eventDate: today.add(Duration(days: diffDays)),
              //       eventBackgroundColor: Colors.green),
              // );

              _testEvents[i] = CalendarEvent(
                  eventName: snapshot.data.docs[i]['schedule'],
                  eventDate: today.add(Duration(days: diffDays)),
                  eventBackgroundColor: Colors.green);
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
              return Consumer<DatePickerModel>(
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
                              // model.fsSetDoucument('yuto',);
                              fsSetDocument('yuto', model.getSelectedDate(),
                                  _eventController.text);
                              // debugPrint(model.getSelectedDate());

                              //_eventController.text;

                              // Navigator.pop(context);
                              Navigator.pushAndRemoveUntil(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => CalenderPage()),
                                  (_) => false);
                              model.initSelectedDate();
                            },
                          ),
                        ],
                      ),
                    ],
                  );
                },
              );
            },
          );
        },
      ),
      bottomNavigationBar: footNavigator(),
      // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
