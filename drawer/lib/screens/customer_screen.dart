import 'package:flutter/material.dart';


class CustomerScreen extends StatelessWidget {
  
  static const String routeName = "/customer";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Customer list"),
      ),
      body: Container(
        child: Center(
          child: Text("Customers"),
        ),
      ),
    );
  }
}
