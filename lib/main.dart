import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'model/dayAndScheduleModel.dart';
import 'screen/calenderPage.dart';
import 'screen/contentsPage.dart';
import 'model/footNavigatorModel.dart';
import 'package:firebase_core/firebase_core.dart';

void main() async => {
      WidgetsFlutterBinding.ensureInitialized(),
      await Firebase.initializeApp(),
      initializeDateFormatting().then(
        (_) => runApp(
          MultiProvider(
            providers: [
              ChangeNotifierProvider(create: (context) => FootNavigatorModel()),
              ChangeNotifierProvider(
                  create: (context) => SetDayAndScheduleModel()),

              //←←←ここに追加するProviderを記載する
            ],
            child: MyApp(),
          ),
        ),
      ),
    };

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return (Consumer<SetDayAndScheduleModel>(builder: (context, model, child) {
      DateTime now = DateTime.now();
      model.setCurrentMonth(now.month.toString());

      return MaterialApp(
        initialRoute: '/Calender',
        routes: {
          '/Calender': (context) => CalenderPage(),
          '/Contents': (context) => ContentsPage(),
          // '/InputTask': (context) => InputTaskPage(),
        },
      );
    }));
  }
}

// MultiProvider
// class MyApp extends StatelessWidget {
//   // This widget is the root of your application.
//   @override
//   Widget build(BuildContext context) {
//     return MultiProvider(
//       providers: [
//         // ChangeNotifierProvider(create: (context) => FootNavigatorModel()),
//         // ChangeNotifierProvider(create: (context) => TaskListViewModel()),
//       ],
//       child: MaterialApp(
//         initialRoute: '/Calender',
//         routes: {
//           '/Calender': (context) => CalenderPage(),
//           // '/Reminder': (context) => ReminderPage(),
//           // '/InputTask': (context) => InputTaskPage(),
//         },
//         // home: TodoPage(),
//       ),
//     );
//   }
// }
