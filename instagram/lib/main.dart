import 'package:flutter/cupertino.dart'; //ios  스타일
import 'package:flutter/material.dart';
import './style.dart' as style;
import 'package:http/http.dart' as http; //REST API
import 'dart:convert'; //Json
import 'package:flutter/rendering.dart'; //스크롤
import 'package:image_picker/image_picker.dart'; //이미지
import 'dart:io';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  runApp(
      MaterialApp(
        theme: style.theme,
        home: MyApp(),
  ));
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
    return Scaffold(
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

class Upload extends StatelessWidget {
  const Upload({Key? key, this.userImage, this.setUserContent, this.addMyData}) : super(key: key);
  final userImage;
  final setUserContent;
  final addMyData;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(onPressed: (){
            addMyData();
            Navigator.pop(context);
          }, icon: Icon(Icons.check)),
        ],
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Image.file(userImage), //파일경로 이미지 띄우기
          Text('이미지 업로드 화면'),
          TextField(onChanged: (text){
            setUserContent(text);
          },),
        ],
      )
    );
  }
}


class PostUI extends StatefulWidget {
  PostUI({Key? key, this.posts}) : super(key: key);
  final posts;
  @override
  State<PostUI> createState() => _PostUIState();
}
class _PostUIState extends State<PostUI> {

  var scroll = ScrollController();
  var cnt = 1;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    scroll.addListener(() {
      if (scroll.position.pixels == scroll.position.maxScrollExtent) {
        print('스크롤바 끝 도착');
        addPosts();
      }
    });
  }

  void addPosts() async {
    var result = await http.get(Uri.parse('https://codingapple1.github.io/app/more1.json'));
    if(result.statusCode == 200){
      setState(() {
        widget.posts.add(jsonDecode(result.body));
        print(jsonDecode(result.body));
      });
    }else{
      throw Exception('failed');
    }
  }
  @override
  Widget build(BuildContext context) {
    if(widget.posts.isNotEmpty) {
      return ListView.builder(
          itemCount: widget.posts.length,
          controller: scroll,
          itemBuilder: (c, i) {
        return Column(
          children: [
            widget.posts[i]['image'].runtimeType == String
                ? Image.network(widget.posts[i]['image'])
                : Image.file(widget.posts[i]['image']),
            Container(
              constraints: BoxConstraints(maxWidth: 600),
              padding: EdgeInsets.all(20),
              width: double.infinity,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  GestureDetector(
                    child: Text(widget.posts[i]['user']),
                    onTap: (){
                      Navigator.push(context,
                        CupertinoPageRoute(builder: (c)=> Profile()),
                        // PageRouteBuilder(
                        //   pageBuilder: (c, a1, a2)=> Profile(),
                        //   transitionsBuilder: (c, a1, a2, child) => FadeTransition(opacity: a1, child: child),
                        // )
                      );
                    },
                  ),
                  Text('좋아요 ${widget.posts[i]['likes'].toString()}'),
                  Text(widget.posts[i]['date']),
                  Text(widget.posts[i]['content'])
                ],
              ),
            )
          ],
        );
      });
    }else{
      return Text('Loading...');
    }
  }
}


class Profile extends StatelessWidget {
  const Profile({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Text('프로필페이지'),
    );
  }
}

