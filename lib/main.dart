
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
  Widget build(BuildContext context) {

    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: (){
          showDialog(context: context, builder: (context){
            return Dialog(child: Text('안녕'));
          });
        },
      ),
      appBar: AppBar(title: Text('앱제목'), leading: Icon(Icons.star), actions:[Icon(Icons.star), Icon(Icons.star), Icon(Icons.star)]),
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


