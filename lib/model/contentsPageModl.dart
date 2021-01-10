import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_timetable_view/flutter_timetable_view.dart';

class ContentsPageModel extends ChangeNotifier {
  List<LaneEvents> laneEventsMdl = [
    LaneEvents(
      lane: Lane(
        name: 'sun',
        width: 50,
      ),
      events: [
        TableEvent(
          title: '○',
          start: TableEventTime(hour: 8, minute: 0),
          end: TableEventTime(hour: 10, minute: 0),
        ),
        TableEvent(
          title: '◎',
          start: TableEventTime(hour: 8, minute: 0),
          end: TableEventTime(hour: 10, minute: 0),
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

  // List<LaneEvents> LaneEventsGet() {
  //   LaneEventsMdl = [
  //     LaneEvents(
  //       lane: Lane(
  //         name: 'sun',
  //         width: 50,
  //       ),
  //       events: [
  //         TableEvent(
  //           title: 'An event 1',
  //           start: TableEventTime(hour: 8, minute: 0),
  //           end: TableEventTime(hour: 10, minute: 0),
  //         ),
  //         TableEvent(
  //           title: 'An event 2',
  //           start: TableEventTime(hour: 12, minute: 0),
  //           end: TableEventTime(hour: 13, minute: 20),
  //         ),
  //       ],
  //     ),
  //     LaneEvents(
  //       lane: Lane(
  //         name: 'mon',
  //         width: 50,
  //       ),
  //       events: [
  //         TableEvent(
  //           title: 'An event 1',
  //           start: TableEventTime(hour: 8, minute: 0),
  //           end: TableEventTime(hour: 10, minute: 0),
  //         ),
  //         TableEvent(
  //           title: 'An event 2',
  //           start: TableEventTime(hour: 12, minute: 0),
  //           end: TableEventTime(hour: 13, minute: 20),
  //         ),
  //       ],
  //     ),
  //     LaneEvents(
  //       lane: Lane(
  //         name: 'tue',
  //         width: 50,
  //       ),
  //       events: [
  //         TableEvent(
  //           title: 'An event 1',
  //           start: TableEventTime(hour: 8, minute: 0),
  //           end: TableEventTime(hour: 10, minute: 0),
  //         ),
  //         TableEvent(
  //           title: 'An event 2',
  //           start: TableEventTime(hour: 12, minute: 0),
  //           end: TableEventTime(hour: 13, minute: 20),
  //         ),
  //       ],
  //     ),
  //   ];
  //   return LaneEventsMdl;
  // }
  //           start: TableEventTime(hour: 8, minute: 0),
  //           end: TableEventTime(hour: 10, minute: 0),
  //         ),
  //         TableEvent(
  //           title: 'An event 2',
  //           start: TableEventTime(hour: 12, minute: 0),
  //           end: TableEventTime(hour: 13, minute: 20),
  //         ),
  //       ],
  //     ),
  //   ];
  //   return LaneEventsMdl;
  // }

  void laneEventsRemove(int index) {
    laneEventsMdl.removeAt(index);
    notifyListeners();
  }
}
