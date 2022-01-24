import 'package:flutter/cupertino.dart'; //ios  스타일
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http; //REST API
import 'dart:convert'; //Json
import 'package:flutter/rendering.dart'; //스크롤
import 'package:image_picker/image_picker.dart'; //이미지
import 'dart:io';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:provider/provider.dart';
//
import 'data/store.dart';
import 'widgets/profile.dart';
import 'widgets/style.dart' as style;
import 'widgets/notification.dart';
import 'widgets/post.dart';
import 'widgets/upload.dart';

void main() {
  runApp(
      MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (c) => Store1()),
          ChangeNotifierProvider(create: (c) => Store2()),
        ],
        child: MaterialApp(
          theme: style.theme,
          home: MyApp(),
         ),
      )
  );
}

//stless
class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  //state
  var tab = 0; // 0 or 1
  var userImage;
  var userContent;
  var posts = [];

  saveData() async {
    var storage = await SharedPreferences.getInstance();
    storage.setBool('a', true);
    storage.setString('name', 'john');
    var result = storage.get('name');
    print(result);
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    initNotification();
    getData();
    saveData();
  }

  addMyData(){
    var myData = {
      'id': posts.length,
      'image': userImage,
      'likes': 5,
      'date': 'July 25',
      'content': userContent,
      'liked': false,
      'user': 'John Kim'
    };
    setState(() {
      posts.insert(0, myData);
    });
  }

  setUserContent(content){
    setState(() {
      userContent = content;
    });
  }

  getData() async {
    var result = await http.get(Uri.parse('https://codingapple1.github.io/app/data.json'));
    if(result.statusCode == 200){
      setState(() {
        posts = jsonDecode(result.body);
        print(posts);
      });
    } else{
      throw Exception('failed');
    }
  }

  addData(result){
    setState(() {
      posts.add(result);
    });
  }

  @override
  Widget build(BuildContext context) {

    print(MediaQuery.of(context).size.width);

    return Scaffold(
      floatingActionButton: FloatingActionButton(
        child: Text('+'),
        onPressed: (){
          showNotification();
        },
      ),
      appBar: AppBar(
        title: Text('Instagram'),
        actions: [
          IconButton(
            onPressed: () async {
              var picker = ImagePicker();
              var image = await picker.pickImage(source: ImageSource.gallery); //카메라에서 이미지 받아옴
              if(image != null) {
                setState(() {
                  userImage = File(image.path); //이미지 경로
                });
              }
              Navigator.push(context,
                MaterialPageRoute(builder: (context){
                  return Upload(
                    userImage: userImage, setUserContent: setUserContent, addMyData: addMyData);
                })
              );
            },
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


