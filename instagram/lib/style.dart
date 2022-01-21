import 'package:flutter/material.dart';

var theme = ThemeData(
  // textButtonTheme: TextButtonThemeData(
  //   style: TextButton.styleFrom(
  //     backgroundColor: Colors.grey,
  //   )
  // ),
  bottomNavigationBarTheme: BottomNavigationBarThemeData(
    backgroundColor: Colors.white,
    elevation: 2,
    selectedItemColor: Colors.black,
  ),
  iconTheme: IconThemeData(color: Colors.blue),
  appBarTheme: AppBarTheme(
    color: Colors.white,
    elevation: 1,
    titleTextStyle: TextStyle(color: Colors.black, fontSize: 25),
    actionsIconTheme: IconThemeData(color: Colors.black),
  ),
  textTheme: TextTheme(
    headline1: TextStyle(color: Colors.black) ,
    bodyText2: TextStyle(color: Colors.pinkAccent),
  )
);
