// import 'package:child_watchers/model/fsGetSchedule.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
// import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import '../model/dayAndScheduleModel.dart';

int _dayCount = 0;
int i = 0;
String text = "";

final Map<String, String> _holidays = {
  '2020/12/1': 'dummy',
  '2020/12/28': 'dummy',
  '2021/1/1': 'dummy',
  '2021/1/2': 'dummy',
  '2021/1/3': 'dummy',
  '2021/1/15': 'dummy',
};

Widget dayAndSchedule(int index) {
  return (Consumer<SetDayAndScheduleModel>(
    builder: (context, model, child) {
      var tmpThisMonth = calcThisMonth(model.currentYear, model.currentMonth);

      var startDay = int.parse(tmpThisMonth['weekday']);
      var lastDay = int.parse(tmpThisMonth['lastday']);

      if (index < startDay) {
        _dayCount = 1;
        return Text("");
      }

      //FSからデータを取得
      String tmpDate = model.currentYear +
          model.currentMonth +
          ((model.days + 1).toString());

      //日付表示　1日目
      if (index.toString() == tmpThisMonth['weekday']) {
        model.incDays();
        _dayCount = model.days;

        if (tmpThisMonth['holiday'] == '0') {
          //1日目のレンダリングは7にしないとNG
          if (tmpThisMonth['thisweekday'] == '7') {
            return Column(
              // mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Container(
                  width: double.infinity,
                  child: Text(
                    model.days.toString(),
                    style: TextStyle(
                      color: Colors.red,
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                ),
                Container(
                  child: FutureBuilder(
                    future: model.fsGetSchedule(tmpDate),
                    builder: (context, snapshot) {
                      // 取得したデータを表示するWidget
                      if (snapshot.data == null) {
                        return Text("");
                      } else {
                        return Text(snapshot.data['schedule']);
                      }
                    },
                  ),
                ),
                // Text(model.text),
              ],
            );
            //1日目のレンダリングは6にしないとNG
          } else if (tmpThisMonth['thisweekday'] == '6') {
            return Column(
              children: [
                Container(
                  width: double.infinity,
                  child: Text(
                    model.days.toString(),
                    style: TextStyle(
                      color: Colors.blue,
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                ),
                Container(
                  child: FutureBuilder(
                    future: model.fsGetSchedule(tmpDate),
                    builder: (context, snapshot) {
                      // 取得したデータを表示するWidget
                      if (snapshot.data == null) {
                        return Text("");
                      } else {
                        return Text(snapshot.data['schedule']);
                      }
                    },
                  ),
                ),
              ],
            );
          } else {
            return Column(
              children: [
                Container(
                  width: double.infinity,
                  child: Text(
                    model.days.toString(),
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                ),
                Container(
                  child: FutureBuilder(
                    future: model.fsGetSchedule(tmpDate),
                    builder: (context, snapshot) {
                      // 取得したデータを表示するWidget
                      if (snapshot.data == null) {
                        return Text("");
                      } else {
                        return Text(snapshot.data['schedule']);
                      }
                    },
                  ),
                ),
              ],
            );
          }
        } else if (tmpThisMonth['holiday'] == '1') {
          return Column(
            children: [
              Container(
                width: double.infinity,
                child: Text(
                  model.days.toString(),
                  style: TextStyle(
                    color: Colors.red,
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
              ),
              Container(
                child: FutureBuilder(
                  future: model.fsGetSchedule(tmpDate),
                  builder: (context, snapshot) {
                    // 取得したデータを表示するWidget
                    if (snapshot.data == null) {
                      return Text("");
                    } else {
                      return Text(snapshot.data['schedule']);
                    }
                  },
                ),
              ),
            ],
          );
        }
      }
      //日付表示　2日目～最終日
      if (index > startDay && lastDay + startDay - index > 0) {
        model.incDays();
        _dayCount = model.days;

        if (tmpThisMonth['holiday'] == '0') {
          if (tmpThisMonth['thisweekday'] == '6') {
            return Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Container(
                  width: double.infinity,
                  child: Text(
                    model.days.toString(),
                    style: TextStyle(
                      color: Colors.red,
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                ),
                Container(
                  child: FutureBuilder(
                    future: model.fsGetSchedule(tmpDate),
                    builder: (context, snapshot) {
                      // 取得したデータを表示するWidget
                      if (snapshot.data == null) {
                        return Text("");
                      } else {
                        return Text(snapshot.data['schedule']);
                      }
                    },
                  ),
                ),
              ],
            );
          } else if (tmpThisMonth['thisweekday'] == '5') {
            return Column(
              children: [
                Container(
                  width: double.infinity,
                  child: Text(
                    model.days.toString(),
                    style: TextStyle(
                      color: Colors.blue,
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                ),
                Container(
                  child: FutureBuilder(
                    future: model.fsGetSchedule(tmpDate),
                    builder: (context, snapshot) {
                      // 取得したデータを表示するWidget
                      if (snapshot.data == null) {
                        return Text("");
                      } else {
                        return Text(snapshot.data['schedule']);
                      }
                    },
                  ),
                ),
              ],
            );
          } else {
            return InkWell(
              onTap: () {
                showDialog(
                  context: context,
                  builder: (context) {
                    return Column(
                      children: <Widget>[
                        AlertDialog(
                          title: Text("予定"),
                          content: SingleChildScrollView(
                            child: ListBody(
                              children: <Widget>[
                                Column(
                                    // コンテンツ
                                    ),
                              ],
                            ),
                          ),
                          actions: <Widget>[
                            // ボタン
                          ],
                        ),
                      ],
                    );
                  },
                );
              },
              child: Column(
                children: [
                  Container(
                    width: double.infinity,
                    child: Text(
                      model.days.toString(),
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                  ),
                  Container(
                    child: FutureBuilder(
                      future: model.fsGetSchedule(tmpDate),
                      builder: (context, snapshot) {
                        // 取得したデータを表示するWidget
                        if (snapshot.data == null) {
                          return Text("");
                        } else {
                          // return Text(snapshot.data['schedule']);
                          return Text(
                            snapshot.data['schedule'],
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 10,
                            ),
                            maxLines: 3,
                          );
                        }
                      },
                    ),
                  ),
                ],
              ),
            );
          }
        } else if (tmpThisMonth['holiday'] == '1') {
          return Column(
            children: [
              Container(
                width: double.infinity,
                child: Text(
                  model.days.toString(),
                  style: TextStyle(
                    color: Colors.red,
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
              ),
              Container(
                child: FutureBuilder(
                  future: model.fsGetSchedule(tmpDate),
                  builder: (context, snapshot) {
                    // 取得したデータを表示するWidget
                    if (snapshot.data == null) {
                      return Text("");
                    } else {
                      return Text(snapshot.data['schedule']);
                    }
                  },
                ),
              ),
            ],
          );
        }
      }

      if (index > lastDay + startDay - 1) {
        model.resetDays();
        _dayCount = model.days;
        return Text("");
      }
    },
  ));
}

Map<String, String> calcThisMonth(String thisYear, String thisMonth) {
  DateTime now = DateTime.now();
  String thisDay = now.day.toString();

  String firstWeekday =
      DateTime(int.parse(thisYear), int.parse(thisMonth), 1).weekday.toString();
  String thisWeekday =
      DateTime(int.parse(thisYear), int.parse(thisMonth), _dayCount)
          .weekday
          .toString();

  String lastDay = DateTime(int.parse(thisYear), int.parse(thisMonth) + 1, 1)
      .add(Duration(days: -1))
      .day
      .toString();

  Map<String, String> setDay = {
    'year': '$thisYear',
    'month': '$thisMonth',
    'day': '$thisDay',
    'weekday': '$firstWeekday',
    'thisweekday': '$thisWeekday',
    'lastday': '$lastDay'
  };

  String holidayFlag =
      checkHoliday(setDay['year'], setDay['month'], setDay['day']);

  setDay['holiday'] = holidayFlag;
  // debugPrint(setDay['holiday']);

  return setDay;
}

String checkHoliday(String year, String month, String day) {
  String holidayFlag = '0';
  for (String key in _holidays.keys) {
    List tmp = key.split('/');
    if (tmp[0] == year && tmp[1] == month && tmp[2] == _dayCount.toString()) {
      holidayFlag = '1';
    }
    return holidayFlag;
  }
}
