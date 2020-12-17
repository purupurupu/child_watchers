import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import '../model/dayAndScheduleModel.dart';

int _dayCount = 0;

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
      var tmpThisMonth = calcThisMonth();

      var startDay = int.parse(tmpThisMonth['weekday']);
      var lastDay = int.parse(tmpThisMonth['lastday']);

      if (index < startDay) {
        _dayCount = 1;
        return Text("");
      }

      //日付表示　1日目
      if (index.toString() == tmpThisMonth['weekday']) {
        model.incDays();
        _dayCount = model.days;

        if (tmpThisMonth['holiday'] == '0') {
          return Row(
            children: [
              Text(
                model.days.toString(),
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),
              Text("testtest"),
            ],
          );
        } else if (tmpThisMonth['holiday'] == '1') {
          return Text(
            model.days.toString(),
            style: TextStyle(
              color: Colors.red,
              fontWeight: FontWeight.bold,
              fontSize: 16,
            ),
          );
        }
      }

      //日付表示　2日目～最終日
      if (index > startDay && lastDay - index >= 0) {
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
                Text("test testaaaaaa"),
              ],
            );
          } else if (tmpThisMonth['thisweekday'] == '5') {
            return Text(
              model.days.toString(),
              style: TextStyle(
                color: Colors.blue,
                fontWeight: FontWeight.bold,
                fontSize: 16,
              ),
            );
          } else {
            return Text(
              model.days.toString(),
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 16,
              ),
            );
          }
        } else if (tmpThisMonth['holiday'] == '1') {
          return Text(
            model.days.toString(),
            style: TextStyle(
              color: Colors.red,
              fontWeight: FontWeight.bold,
              fontSize: 16,
            ),
          );
        }
      }

      if (index > lastDay) {
        model.resetDays();
        _dayCount = model.days;
        return Text("");
      }
    },
  ));
}

Map<String, String> calcThisMonth() {
  DateTime now = DateTime.now();
  String thisYear = now.year.toString();
  String thisMonth = now.month.toString();
  String thisDay = now.month.toString();

  String firstWeekday = DateTime(now.year, now.month, 1).weekday.toString();
  String thisWeekday =
      DateTime(now.year, now.month, _dayCount).weekday.toString();

  String lastDay = DateTime(now.year, now.month + 1, 1)
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

  debugPrint(setDay['holiday']);

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
