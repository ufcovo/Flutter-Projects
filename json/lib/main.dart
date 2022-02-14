import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'apis/api.dart';
import 'models/todo.dart';

void main() => runApp(TodoApp());

class TodoApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: ToDoListApp(),
    );
  }
}

class ToDoListApp extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => ToDoListAppState();
}

class ToDoListAppState extends State {
  List<ToDo> list = <ToDo>[];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Todo list"),
      ),
      body: ListView.builder(
        itemCount: list.length,
        itemBuilder: (context, position) {
          return ListTile(
            title: Text(list[position].title!),
          );
        },
      ),
    );
  }

  getTodos() {
    Api.getTodos().then((response) {
      setState(() {
        Iterable list = json.decode(response.body);
        this.list = list.map((model) => ToDo.fromJson(model)).toList();
      });
    });
  }

  @override
  void initState() {
    super.initState();
    getTodos();
  }
}
