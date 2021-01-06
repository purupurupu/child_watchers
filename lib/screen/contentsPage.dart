import 'package:child_watchers/components/footNavigator.dart';
import 'package:flutter/material.dart';
import '../components/timeTable.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_timetable_view/flutter_timetable_view.dart';

class ContentsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: TimetableView(
        laneEventsList: _LaneEvents(),
        timetableStyle: TimetableStyle(
          timeItemWidth: 70,
          laneWidth: 50,
        ),
      ),
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
