//import 'dart:html';

import 'package:flutter/material.dart';

void main() { 
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => StudentDialogBoxState();
}

class StudentDialogBoxState extends State<MyHomePage> {
  String studentName = "";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Student App"),
      ),
      body: Column(
        children: <Widget>[
          TextField(
            onChanged: (String nameToChange) {
              setState(() {
                studentName = nameToChange;
              });
            },
          ),
          Text("Hello: " + studentName)
        ],
      ),
    );
  }
}
