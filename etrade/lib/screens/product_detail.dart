import 'package:etrade/db/db_helper.dart';
import 'package:etrade/models/product.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ProductDetail extends StatefulWidget {
  Product product;
  ProductDetail(this.product);
  @override
  State<StatefulWidget> createState() => ProductDetailState(product);
}

DbHelper dbHelper = DbHelper();
enum Choice { Delete, Update }

class ProductDetailState extends State {
  Product product;
  ProductDetailState(this.product);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Product Detail for ${product.name}"),
        actions: <Widget>[
          PopupMenuButton<Choice>(
            onSelected: select,
            itemBuilder: (BuildContext context) => <PopupMenuEntry<Choice>>[
              PopupMenuItem<Choice>(
                value: Choice.Delete,
                child: Text("Delete product"),
              ),
              PopupMenuItem<Choice>(
                value: Choice.Update,
                child: Text("Update product"),
              ),
            ],
          )
        ],
      ),
      body: Center(
        child: Card(
          child: Column(
            children: <Widget>[
              ListTile(
                leading: Icon(Icons.shop),
                title: Text(product.name),
                subtitle: Text(product.description),
              ),
              Text("${product.name} price is: ${product.price}"),
              ButtonTheme(
                child: ButtonBar(
                  children: <Widget>[
                    FlatButton(
                      child: const Text("add to card"),
                      onPressed: () {
                        AlertDialog alertDialog = AlertDialog(
                          title: const Text("Success"),
                          content: Text("${product.name} added to card."),
                        );
                        showDialog(
                            context: context, builder: (_) => alertDialog);
                      },
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  void select(Choice choice) async {
    int result;
    switch (choice) {
      case Choice.Delete:
        Navigator.pop(context, true);
        result = await dbHelper.delete(product.id);
        if (result != 0) {
          AlertDialog alertDialog = AlertDialog(
            title: const Text("Success"),
            content: Text("Deleted product: ${product.name}"),
          );
          showDialog(context: context, builder: (_) => alertDialog);
        }
        break;
      default:
    }
  }
}
