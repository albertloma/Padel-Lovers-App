import 'package:flutter/material.dart';
import 'package:padelloversapp/homepage.dart';
import 'package:padelloversapp/selectLeague.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: homePage(),
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        brightness: Brightness.light,
        primaryColor: Colors.lightGreen,
        primarySwatch: Colors.lightGreen,
        accentColor: Colors.lightGreen[800],

        // Define the default font family.
        fontFamily: 'Robotto',
        textTheme: TextTheme(
            headline1: TextStyle(fontSize: 36.0, fontWeight: FontWeight.bold),
            headline6: TextStyle(fontSize: 36.0, fontStyle: FontStyle.italic),
            headline5: TextStyle(fontSize: 24.0, fontWeight: FontWeight.bold),
            bodyText2: TextStyle(
                fontSize: 24.0,
                fontFamily: 'Robotto',
                color: Colors.white,
                fontWeight: FontWeight.bold)),
      ),
    );
  }
}