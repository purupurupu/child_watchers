import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'model/calendarPageModel.dart';
import 'model/dayAndScheduleModel.dart';
import 'model/fsGetSchedule.dart';
import 'screen/calendarPage.dart';
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
              ChangeNotifierProvider(create: (context) => DatePickerModel()),

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
