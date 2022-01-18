
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
          appBar: AppBar(title: Text('앱제목'), leading: Icon(Icons.star), actions:[Icon(Icons.star), Icon(Icons.star), Icon(Icons.star)]),
          body: Container(
            height: 150,
            alignment: Alignment.topCenter,
            margin: EdgeInsets.all(5),
            child: Row(
              children: [
                Container(
                  width: 150,
                  color: Colors.red,
                  child: Image.asset('1.jpg'),
                ),
                Container(
                  width: 340,
                  child: Container(
                    margin: EdgeInsets.fromLTRB(10, 0, 0, 0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('캐논 DSLR 100D (단렌즈, 충전기 16기가 SD포함)',
                          style: TextStyle(fontWeight: FontWeight.bold),
                          textAlign: TextAlign.left,
                        ),
                        Text('성동구 행당동 끌올 10 분전',
                            textAlign: TextAlign.left,
                        ),
                        Text('210,000원'),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Icon(Icons.favorite),
                            Text('4'),
                          ],
                        )
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        )
    );
  }
}
