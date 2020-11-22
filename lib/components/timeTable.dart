import 'package:flutter/material.dart';

Widget timeTable() {
  return Flexible(
    child: ListView.builder(
      itemCount: 24,
      itemBuilder: (BuildContext context, int index) {
        return Card(
          child: ListTile(
            leading: Icon(Icons.list),
            title: Row(
              children: [
                Text(index.toString() + ":00"),
                Text("  "),
                Text("〇" + " "),
                Text("◎"),
              ],
            ),
            // subtitle: Text('sub_' + index.toString()),
            trailing: Icon(Icons.edit),
            onTap: () {},
          ),
        );
      },
    ),
  );
}
