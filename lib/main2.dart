
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
          appBar: AppBar(title: Text('앱제목')),
          body: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Icon(Icons.star),
                Icon(Icons.star),
              ]
          ),
          bottomNavigationBar: BottomAppBar(
            child: Container(
              height: 50,
              color: Colors.blue,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Icon(Icons.phone),
                  Icon(Icons.message),
                  Icon(Icons.contact_page ),
                ],
              ),
            ),
          ),
        )
    );
  }
}
