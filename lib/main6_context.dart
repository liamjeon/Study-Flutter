
import 'package:flutter/material.dart';

void main() {
  runApp(
      MaterialApp(
          home: MyApp() //앱 시작
      )
  );
}

class MyApp extends StatefulWidget {
  MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  var a = 0;
  var name = ['전익현', '홍길동', '라연경'];
  var like = [0,0,0];

  @override
  Widget build(BuildContext context) { // context: 부모위젯의 정보를 담고있는 변수 Scaffold의 부모들 즉 MaterialApp ..

    return Scaffold(
      floatingActionButton: Builder( //Builder: 역할 중간에 족보를 만들어줌
        builder: (context) { //이 context(족보)에는 위 조상들인 Scaffold, MaterialApp 들이 들어있다.
          return FloatingActionButton(
            onPressed: (){
              showDialog(context: context, builder: (context){
                print(context);
                return Dialog(child: Text('안녕'));
              });
            },
          );
        }
      ),
      appBar: AppBar(title: Text('앱제목'), leading: Icon(Icons.star), actions:[Icon(Icons.star)]),
      body: ListView.builder(
        itemCount: 3,
        itemBuilder: (context, i){
          print(i);
          return ListTile(
            leading: Image.asset('1.jpg'),
            title: Text(name[i]),
          );
        }
      ),
      bottomNavigationBar: BottomApp(),
    );
  }
}

class ShotItem extends StatelessWidget {
  const ShotItem({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: Text('안녕'),
    );
  }
}

class BottomApp extends StatelessWidget {
  const BottomApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BottomAppBar(
        child: Container(
            height: 50,
            color: Colors.blue,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Icon(Icons.phone),
                Icon(Icons.message),
                Icon(Icons.contact_page),
              ],
            )
        )
    );
  }
}


