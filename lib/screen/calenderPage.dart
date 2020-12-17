import 'package:child_watchers/components/dayAndSchedule.dart';
import 'package:child_watchers/components/dayOfTHeWeek.dart';
import 'package:child_watchers/model/dayAndScheduleModel.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:provider/provider.dart';
import '../model/footNavigatorModel.dart';
import '../components/footNavigator.dart';
import "package:intl/intl.dart";
import 'package:intl/date_symbol_data_local.dart';

// // Example holidays
// final Map<DateTime, String> _holidays = {
//   DateTime(2020, 12, 15): 'dummy',
//   DateTime(2021, 1, 1): 'dummy',
//   DateTime(2021, 1, 11): 'dummy',
//   DateTime(2021, 2, 11): 'dummy',
//   DateTime(2021, 2, 23): 'dummy',
//   DateTime(2021, 3, 20): 'dummy',
//   DateTime(2021, 4, 29): 'dummy',
//   DateTime(2021, 5, 3): 'dummy',
//   DateTime(2021, 5, 4): 'dummy',
//   DateTime(2021, 5, 5): 'dummy',
//   DateTime(2021, 7, 22): 'dummy',
//   DateTime(2021, 7, 23): 'dummy',
// };

class CalenderPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    DateTime now = DateTime.now();
    String tmpTime = 'Today  ' +
        now.year.toString() +
        '/' +
        now.month.toString() +
        '/' +
        now.day.toString();

    return (Consumer<SetDayAndScheduleModel>(
      builder: (context, model, child) {
        return Scaffold(
          appBar: AppBar(
            leading: IconButton(
              color: Colors.white,
              icon: Icon(Icons.arrow_back),
              onPressed: () {
                ;
              },
            ),
            backgroundColor: Colors.red,
            centerTitle: true,
            title: Text('$tmpTime'),
            actions: <Widget>[
              IconButton(
                color: Colors.white,
                icon: Icon(
                  Icons.arrow_forward,
                ),
                onPressed: () {},
              ),
            ],
          ),
          body: Column(
            children: [
              Container(
                height: 40,
                child: Container(
                  color: Colors.red,
                  child: GridView.count(
                    crossAxisCount: 7,
                    childAspectRatio: 1.5,
                    children: List.generate(
                      7,
                      (index) {
                        return Center(
                          child: Container(
                            decoration: BoxDecoration(
                                // 枠線
                                // border: Border.all(color: Colors.black87),
                                // 角丸
                                // borderRadius: BorderRadius.circular(8),
                                ),
                            child: dayOfTheWeek(index),
                          ),
                        );
                      },
                    ),
                  ),
                ),
              ),
              Container(
                child: Expanded(
                  child: GridView.count(
                    crossAxisCount: 7,
                    crossAxisSpacing: 0.0, // 縦
                    mainAxisSpacing: 0.0, // 横
                    childAspectRatio: 0.7, // 高さ

                    children: List.generate(42, (index) {
                      return Container(
                        child: selectBoxDecoration(index), //枠線設定　日付設定
                      );
                    }),
                  ),
                ),
              )
            ],
          ),
          bottomNavigationBar: footNavigator(),
        );
      },
    ));
  }
}

Widget selectBoxDecoration(index) {
  //indexは次回層の関数へ渡す
  return (Container(
    //レスポンシブなため大きいサイズで宣言
    width: 100,
    height: 100,
    child: dayAndSchedule(index),

    decoration: BoxDecoration(
      // 枠線
      border: Border.all(color: Colors.black26),
      // 角丸
      // borderRadius: BorderRadius.circular(8),
    ),
  ));
}
