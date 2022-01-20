import 'package:flutter/material.dart';
import './style.dart' as style;

void main() {
  runApp(
      MaterialApp(
        theme: style.theme,
        home: MyApp(),
  ));
}

// var text1 = TextStyle(color : Colors.red);
// Text('글자', style : text1)

//stless
class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  //state
  var tab = 0; // 0 or 1

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Instagram'),
        actions: [
          IconButton(
            onPressed: (){},
            icon: Icon(Icons.add_box_outlined),
            iconSize: 40,
        ),
        ],
      ),
      body: [PostUI(), Text('샵페이지')][tab],
      bottomNavigationBar: BottomNavigationBar(
        showUnselectedLabels: false,
        showSelectedLabels: false,
        onTap: (i){
          setState(() {
            tab = i;
          });
        },
        items: [
          BottomNavigationBarItem(
            label : '홈',
            icon: Icon(Icons.home_outlined),
          ),
          BottomNavigationBarItem(
            label : '샵',
            icon: Icon(Icons.shopping_bag_outlined),
          )
        ],
      ),
    );
  }
}

class PostUI extends StatelessWidget {
  PostUI({Key? key}) : super(key: key);

  var postImage = [Image.asset('assets/gobchang.jpg'), Image.asset('gobchang.jpg')];

  @override
  Widget build(BuildContext context) {
    return ListView.builder(itemCount: 3, itemBuilder: (BuildContext context, int index){
      return Column(
        children: [
          Image.network('https://codingapple1.github.io/kona.jpg'),
          Container(
            constraints: BoxConstraints(maxWidth: 600),
            padding: EdgeInsets.all(20),
            width: double.infinity,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('좋아요100'),
                Text('글쓴이'),
                Text('글내용')
              ],
            ),
          )
        ],
      );
    });
  }
}

