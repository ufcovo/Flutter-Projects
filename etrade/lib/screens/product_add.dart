import 'package:etrade/db/db_helper.dart';
import 'package:etrade/models/product.dart';
import 'package:etrade/screens/product_detail.dart';
import 'package:flutter/material.dart';

class ProductAdd extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => ProductAddState();
}

class ProductAddState extends State {
  DbHelper dbHelper = DbHelper();
  TextEditingController txtName = TextEditingController();
  TextEditingController txtDescription = TextEditingController();
  TextEditingController txtPrice = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Add a new product"),
      ),
      body: Padding(
        padding: EdgeInsets.only(top: 30.0, left: 10.0, right: 10.0),
        child: Column(
          children: <Widget>[
            TextField(
              controller: txtName,
              decoration: InputDecoration(labelText: "Name"),
            ),
            TextField(
              controller: txtDescription,
              decoration: InputDecoration(labelText: "Description"),
            ),
            TextField(
              controller: txtPrice,
              decoration: InputDecoration(labelText: "Price"),
            ),
            FlatButton(
              child: Text("Save"),
              onPressed: () {
                save();
              },
            )
          ],
        ),
      ),
    );
  }

  void save() async {
    int result = await dbHelper.insert(Product(
        txtName.text, txtDescription.text, double.tryParse(txtPrice.text)));
    if (result != 0) {
      Navigator.pop(context, true);
    }
  }
}
