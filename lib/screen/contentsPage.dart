import 'package:child_watchers/components/footNavigator.dart';
import 'package:flutter/material.dart';
import '../components/timeTable.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ContentsPage extends StatelessWidget {
  List<DocumentSnapshot> documentList = [];
  String orderDocumentInfo = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Contents Page'),
      ),
      body: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Container(
                child: Text(
                  '日付',
                  style: TextStyle(
                    fontSize: 20,
                    fontFamily: 'Futura',
                    color: Colors.blue,
                  ),
                ),
              ),
              Container(
                child: Text(
                  '曜日',
                  style: TextStyle(
                    fontSize: 20,
                    fontFamily: 'Futura',
                    color: Colors.blue,
                  ),
                ),
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Container(
                child: Text(
                  '生後●●日',
                  style: TextStyle(
                    fontSize: 20,
                    fontFamily: 'Futura',
                    color: Colors.blue,
                  ),
                ),
              ),
              Container(
                child: Text(
                  '体重',
                  style: TextStyle(
                    fontSize: 20,
                    fontFamily: 'Futura',
                    color: Colors.blue,
                  ),
                ),
              ),
              Container(
                child: Text(
                  '体温',
                  style: TextStyle(
                    fontSize: 20,
                    fontFamily: 'Futura',
                    color: Colors.blue,
                  ),
                ),
              ),
            ],
          ),
          // Text('top text'),
          //Flexibleでラップ
          timeTable(),
          RaisedButton(
            child: Text('store'),
            onPressed: () async {
              final snapshot = await FirebaseFirestore.instance
                  .collection('baby')
                  .doc('users')
                  .get();
              debugPrint(snapshot['name']);
            },
          ),
          Text('end text'),
        ],
      ),
      bottomNavigationBar: footNavigator(),
    );
  }
}

// const List<Widget> listTiles = const <Widget>[
//   ListTile(
//     leading: Icon(Icons.map),
//     title: Text('Map'),
//   ),
//   ListTile(
//     leading: Icon(Icons.photo_album),
//     title: Text('Album'),
//   ),
//   ListTile(
//     leading: Icon(Icons.phone),
//     title: Text('Phone'),
//   ),
// ];

// class ContentsPage extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Contents Page'),
//       ),
//       // body: Center(child: Text('aaaaa')),
//       body: Container(
//         child: Row(
//           children: [
//             Text(
//               '日付',
//               style: TextStyle(
//                 fontSize: 20,
//                 fontFamily: 'Futura',
//                 color: Colors.blue,
//               ),
//             ),
//             Text(
//               '曜日',
//               style: TextStyle(
//                 fontSize: 20,
//                 fontFamily: 'Futura',
//                 color: Colors.blue,
//               ),
//             ),
//           ],
//         ),
//       ),
//       bottomNavigationBar: footNavigator(),
//     );
//   }
// }
