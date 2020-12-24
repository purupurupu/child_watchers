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
  @override
  Widget build(BuildContext context) {
    DateTime now = DateTime.now();

    return (Consumer<SetDayAndScheduleModel>(
      builder: (context, model, child) {
        //initial setting
        if (model.getCurrentMonth() == "") {
          model.setCurrentDate(now);
        }

        String tmpDate = model.currentYear +
            model.currentMonth +
            ((model.days + 1).toString());

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
              ),
            ],
          ),
          floatingActionButton: FloatingActionButton(
            child: Icon(Icons.add),
            onPressed: () {
              showDialog(
                context: context,
                builder: (context) {
                  return SimpleDialog(
                    title: Text("タイトル"),
                    children: <Widget>[
                      // コンテンツ領域
                      SimpleDialogOption(
                        onPressed: () => Navigator.pop(context),
                        child: Text("１項目目"),
                      ),
                    ],
                  );
                },
              );
            },
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
