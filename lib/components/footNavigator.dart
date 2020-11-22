import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../model/footNavigatorModel.dart';

Widget footNavigator() {
  // BottomNavigationBar:
  return (Consumer<FootNavigatorModel>(
    builder: (context, model, child) {
      return BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.done_outline),
            label: 'Calender',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.receipt),
            label: 'Contents',
          ),
        ],
        type: BottomNavigationBarType.fixed,
        currentIndex: model.screenIndex,
        selectedItemColor: Colors.amber[800],
        onTap: (index) {
          model.setScreenIndex(index);
          Navigator.of(context).pushReplacementNamed('/${model.pageName}');
        },
      );
    },
  ));
}
