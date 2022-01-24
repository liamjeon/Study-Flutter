import 'package:flutter/cupertino.dart'; //ios  스타일
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http; //REST API
import 'dart:convert'; //Json
import 'package:flutter/rendering.dart'; //스크롤
//
import './profile.dart';

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
