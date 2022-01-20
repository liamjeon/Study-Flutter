
import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:contacts_service/contacts_service.dart';

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
  var a = 1;
  var total = 3;
  var name = ['전익현', '홍길동', '라연경'];
  var like = [0,0,0];


  getPermission() async {
    var status = await Permission.contacts.status;
    if(status.isGranted){
      print('허락됨');
      List<Contact> contacts = await ContactsService.getContacts();
      // print(contacts);
    }else if(status.isDenied){
      print('거절됨');
      Permission.contacts.request(); //허락해달라고 팝업창 띄움
    }else if (status.isPermanentlyDenied) { //유저가 앱설정에서 꺼놓은 경우
      openAppSettings();
    }
  }

//  C:/"Program Files"/Android/"Android Studio"/bin/keytool -genkey -v -keystore C:/Users/ikhyu/Desktop/WebDev/upload-keystore.jks -storetype JKS -keyalg RSA -keysize 2048 -validity 10000 -alias upload


  @override
  void initState(){
    super.initState();
    // getPermission();
  }

  addOne(){
    setState(() {
      total++;
    });
  }
  addMember(name){
    setState(() {
      print(name);
      this.name.add(name);
    });
  }

  @override
  Widget build(BuildContext context) { // context: 부모위젯의 정보를 담고있는 변수 Scaffold의 부모들 즉 MaterialApp ..

    return Scaffold(
      floatingActionButton: Builder( //Builder: 역할 중간에 족보를 만들어줌
          builder: (context) { //이 context(족보)에는 위 조상들인 Scaffold, MaterialApp 들이 들어있다.
            return FloatingActionButton(
              onPressed: (){
                showDialog(context: context, builder: (context){
                  print(context);
                  return DialogUI(state: a, name: name, addOne: addOne, addMember: addMember);
                });
              },
            );
          }
      ),
      appBar: AppBar(title: Text(total.toString()), leading: Icon(Icons.star), actions:[
        IconButton(onPressed: (){ getPermission(); }, icon: Icon(Icons.contacts)),
      ],
      ),
      body: ListView.builder(
        itemCount: name.length,
        itemBuilder: (context, i){
          print(i);
          return ListTile(
            leading: Image.asset('assets/1.jpg'),
            title: Text(name[i]),
          );
        }
      ),
      bottomNavigationBar: BottomApp(),
    );
  }
}

class DialogUI extends StatelessWidget {
  DialogUI({Key? key, this.state, this.name, this.addOne, this.addMember}) : super(key: key);
  var state;
  var name;
  var addOne;
  var addMember;
  var inputData = TextEditingController();
  var inputMember = '';

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('Contact'),
      content: TextField(
        onChanged: (text){
          inputMember = text;
          },
        decoration: InputDecoration(hintText: state.toString()),
      ),
      actions: [
        ElevatedButton(onPressed: (){
          print(context);
          Navigator.pop(context, true);
        }, child: Text("NO")),
        ElevatedButton(onPressed: (){
          addMember(inputMember);
        }, child: Text("YES")),
      ],
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


