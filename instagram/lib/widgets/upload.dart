import 'package:flutter/cupertino.dart'; //ios  스타일
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart'; //스크롤

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

