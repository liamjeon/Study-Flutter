import 'package:flutter/material.dart';
import './style.dart' as style;
import 'package:http/http.dart' as http;
import 'dart:convert';


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
  void initState() {
    // TODO: implement initState
    super.initState();
    getData();

  }

  var posts = [];
  getData() async {
    var result = await http.get(Uri.parse('https://codingapple1.github.io/app/data.json'));
    if(result.statusCode == 200){
      posts = jsonDecode(result.body);
      print(posts);
    } else{
      throw Exception('failed');
    }
  }

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
      body: [PostUI(posts: posts), Text('샵페이지')][tab],
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
  PostUI({Key? key, this.posts}) : super(key: key);

  var posts;
  var postImage = [Image.asset('assets/gobchang.jpg'), Image.asset('gobchang.jpg')];

  @override
  Widget build(BuildContext context) {
    return ListView.builder(itemCount: posts.length, itemBuilder: (c, i){
      return Column(
        children: [
          Image.network(posts[i]['image']),
          Container(
            constraints: BoxConstraints(maxWidth: 600),
            padding: EdgeInsets.all(20),
            width: double.infinity,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(posts[i]['likes'].toString()),
                Text(posts[i]['user']),
                Text(posts[i]['content'])
              ],
            ),
          )
        ],
      );
    });
  }
}

