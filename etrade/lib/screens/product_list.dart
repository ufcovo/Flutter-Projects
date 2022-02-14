import 'package:etrade/db/db_helper.dart';
import 'package:etrade/models/product.dart';
import 'package:etrade/screens/product_add.dart';
import 'package:etrade/screens/product_detail.dart';
import 'package:flutter/material.dart';

class ProductList extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => ProductListState();
}

class ProductListState extends State {
  DbHelper dbHelper = DbHelper();
  List<Product>? products;
  int count = 0;
  @override
  Widget build(BuildContext context) {
    if (products == null) {
      products = <Product>[];
      getData();
    }
    return Scaffold(
      body: productListItems(),
      floatingActionButton: FloatingActionButton(
        onPressed: () {goToProductAdd();},
        tooltip: "add new product",
        child: Icon(Icons.add),
      ),
    );
  }

  ListView productListItems() {
    return ListView.builder(
      itemCount: count,
      itemBuilder: (BuildContext context, int position) {
        return Card(
          color: Colors.amberAccent,
          elevation: 5.0,
          child: ListTile(
            leading: const CircleAvatar(
              backgroundColor: Colors.green,
              child: Text("A"),
            ),
            title: Text(products![position].name),
            subtitle: Text(products![position].description),
            onTap: () {
              goToDetail(products![position]);
            },
          ),
        );
      },
    );
  }

  void getData() {
    var dbFuture = dbHelper.initializeDb();
    dbFuture.then((value) {
      var productsFuture = dbHelper.getProducts();
      productsFuture.then((data) {
        List<Product> productsData = <Product>[];
        count = data.length;
        for (var i = 0; i < count; i++) {
          productsData.add(Product.fromObject(data[i]));
        }
        setState(() {
          products = productsData;
          count = count;
        });
      });
    });
  }

  void goToDetail(Product product) async {
    bool? result = await Navigator.push(context,
        MaterialPageRoute(builder: (context) => ProductDetail(product)));
    if (result != null) {
      if (result) {
        getData();
      }
    }
  }

  void goToProductAdd() async {
    bool? result = await Navigator.push(
        context, MaterialPageRoute(builder: (context) => ProductAdd()));
    if (result != null) {
      if (result) {
        getData();
      }
    }
  }
}
