import 'package:drawer/screens/customer_screen.dart';
import 'package:drawer/screens/home.dart';
import 'package:drawer/screens/product_screen.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Drawer Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Home(),
      routes: <String,WidgetBuilder>{
        CustomerScreen.routeName: (BuildContext context) => CustomerScreen(),
        ProductScreen.routeName: (BuildContext context) => CustomerScreen(),

      },
    );
  }
}
