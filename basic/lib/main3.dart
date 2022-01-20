import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp()); //앱 시작
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {

    return MaterialApp(
        home: Scaffold(
            appBar: AppBar(title: Text('앱이다')),
            body: Align(
              alignment: Alignment.topCenter,
              child: Container(
                width: 50, height: 50,
                margin: EdgeInsets.all(20),
                padding: EdgeInsets.fromLTRB(5, 5, 5, 5),
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.black)
                ),
              ),
            )
        )
    );
  }
}
