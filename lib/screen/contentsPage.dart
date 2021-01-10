import 'package:child_watchers/components/footNavigator.dart';
import 'package:child_watchers/model/contentsPageModl.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../components/timeTable.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_timetable_view/flutter_timetable_view.dart';

class ContentsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Consumer<ContentsPageModel>(
        builder: (context, model, child) {
          // model.laneEventsGet();

          return TimetableView(
            laneEventsList: model.laneEventsMdl,
            timetableStyle: TimetableStyle(
              timeItemWidth: 70,
              laneWidth: 50,
            ),
          );
        },
      ),
      floatingActionButton:
          Consumer<ContentsPageModel>(builder: (context, model, child) {
        return FloatingActionButton(
          onPressed: () {
            model.laneEventsRemove(0);
            //ボタンを押したときの処理
          },
          child: Text('ボタンに表示する文字'),
        );
      }),
      bottomNavigationBar: footNavigator(),
    );
  }
}

List<LaneEvents> _LaneEvents() {
  return [
    LaneEvents(
      lane: Lane(
        name: 'sun',
        width: 50,
      ),
      events: [
        TableEvent(
          title: 'An event 1',
          start: TableEventTime(hour: 8, minute: 0),
          end: TableEventTime(hour: 10, minute: 0),
        ),
        TableEvent(
          title: 'An event 2',
          start: TableEventTime(hour: 12, minute: 0),
          end: TableEventTime(hour: 13, minute: 20),
        ),
      ],
    ),
    LaneEvents(
      lane: Lane(
        name: 'mon',
        width: 50,
      ),
      events: [
        TableEvent(
          title: 'An event 1',
          start: TableEventTime(hour: 8, minute: 0),
          end: TableEventTime(hour: 10, minute: 0),
        ),
        TableEvent(
          title: 'An event 2',
          start: TableEventTime(hour: 12, minute: 0),
          end: TableEventTime(hour: 13, minute: 20),
        ),
      ],
    ),
    LaneEvents(
      lane: Lane(
        name: 'tue',
        width: 50,
      ),
      events: [
        TableEvent(
          title: 'An event 1',
          start: TableEventTime(hour: 8, minute: 0),
          end: TableEventTime(hour: 10, minute: 0),
        ),
        TableEvent(
          title: 'An event 2',
          start: TableEventTime(hour: 12, minute: 0),
          end: TableEventTime(hour: 13, minute: 20),
        ),
      ],
    ),
  ];
}
