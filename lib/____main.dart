import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';

void main() async => {
      WidgetsFlutterBinding.ensureInitialized(),
      await Firebase.initializeApp(),
      runApp(MyApp()),
    };

class MyApp extends StatelessWidget {
  @override
  // final Future<FirebaseApp> _initialization = Firebase.initializeApp();

  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Baby Names',
      home: GetUserName(),
    );
  }
}

class GetUserName extends StatelessWidget {
  // final Future<FirebaseApp> _initialization = Firebase.initializeApp();

  // 作成したドキュメント一覧
  List<DocumentSnapshot> documentList = [];
  String orderDocumentInfo = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          children: <Widget>[
            RaisedButton(/* --- 省略 --- */),
            RaisedButton(/* --- 省略 --- */),
            RaisedButton(/* --- 省略 --- */),
            RaisedButton(
              child: Text('ドキュメント一覧取得'),
              onPressed: () async {
                // コレクション内のドキュメント一覧を取得
                final snapshot = await FirebaseFirestore.instance
                    .collection('baby')
                    .doc('users')
                    .get();
                // 取得したドキュメント一覧をUIに反映
                // setState(() {
                // documentList = snapshot;
                // });
                debugPrint(snapshot['name']);
              },
            ),
            // コレクション内のドキュメント一覧を表示
            Column(
              children: documentList.map((document) {
                return ListTile(
                  title: Text('${document['name']}'),
                  subtitle: Text('${document['test']}'),
                );
              }).toList(),
            ),
          ],
        ),
      ),
    );
  }
}
