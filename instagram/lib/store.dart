import 'package:flutter/cupertino.dart'; //ios  스타일
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http; //REST API
import 'dart:convert'; //Json


class Store2 extends ChangeNotifier {
  var name = 'john';
}

class Store1 extends ChangeNotifier {
  var name = 'liam jeon';
  var follower = 0;
  var isfollower = false;
  var profileImage = [];

  getData() async {
    var result = await http.get(Uri.parse('https://codingapple1.github.io/app/profile.json'));
    profileImage = jsonDecode(result.body);
    print(profileImage);
    notifyListeners();
  }

  follow(){
    if(!isfollower){
      follower++;
      isfollower = true;
    }else{
      follower--;
      isfollower = false;
    }

    notifyListeners();
  }

  changeName(){
    name = 'liam jeon';
    notifyListeners(); // 재 렌더링 해라.
  }
}


