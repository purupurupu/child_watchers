// import 'dart:developer';

import 'package:child_watchers/components/dayAndSchedule.dart';
import 'package:child_watchers/components/dayOfTHeWeek.dart';
import 'package:child_watchers/model/dayAndScheduleModel.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
// import 'package:table_calendar/table_calendar.dart';
import 'package:provider/provider.dart';
// import '../model/footNavigatorModel.dart';
import '../components/footNavigator.dart';
// import "package:intl/intl.dart";
// import 'package:intl/date_symbol_data_local.dart';

class CalenderPage extends StatelessWidget {
  Future<Map<String, dynamic>> fsGetSchedule(String date) async {
    try {
      DocumentSnapshot docSnapshot = await FirebaseFirestore.instance
          .collection('yuto')
          .doc('$date')
          .get();

      // debugPrint(docSnapshot['schedule']);
      return docSnapshot.data();
    } catch (e) {
      // docSnapshot = "aaaa" as DocumentSnapshot;
      debugPrint("not exists data in firestore ");
    }
  }

  @override
  Widget build(BuildContext context) {
    DateTime now = DateTime.now();
    // String tmpTime = 'Today  ' +
    //     now.year.toString() +
    //     '/' +
    //     now.month.toString() +
    //     '/' +
    //     now.day.toString();

    return (Consumer<SetDayAndScheduleModel>(
      builder: (context, model, child) {
        //initial setting
        if (model.getCurrentMonth() == "") {
          model.setCurrentDate(now);
        }

        // String tmpDate = model.currentYear +
        //     model.currentMonth +
        //     ((model.days + 1).toString());

        // return FutureBuilder(
        //   future: fsGetSchedule('20201225'),
        //   builder: (context, snapshot) {
        //     // 取得が完了していないときに表示するWidget
        //     if (snapshot.connectionState != ConnectionState.done) {
        //       // インジケーターを回しておきます
        //       // return const CircularProgressIndicator();
        //     }

        //     // エラー時に表示するWidget
        //     if (snapshot.hasError) {
        //       print(snapshot.error);
        //       // return Text('エラー');
        //     }

        //     // データが取得できなかったときに表示するWidget
        //     if (!snapshot.hasData) {
        //       // return Text('データがない');
        //     }
        //     debugPrint('${snapshot.data}');

        //     // 取得したデータを表示するWidget
        //     // return Text('${snapshot.data}');
        //   },
        // );

        return Scaffold(
          appBar: AppBar(
            leading: IconButton(
              color: Colors.white,
              icon: Icon(Icons.arrow_back),
              onPressed: () {
                model.setLastMonth();
                model.resetDays();
                Navigator.of(context).pushNamed("/Calender");
              },
            ),
            backgroundColor: Colors.red,
            centerTitle: true,
            title: Text(model.currentYear + '/' + model.currentMonth),
            actions: <Widget>[
              IconButton(
                color: Colors.white,
                icon: Icon(
                  Icons.arrow_forward,
                ),
                onPressed: () {
                  model.setNextMonth();
                  model.resetDays();
                  Navigator.of(context).pushNamed("/Calender");
                },
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

                    //グリッド作成ループ
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
