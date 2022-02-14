import 'package:flutter/material.dart';

class Home extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
        child: Container(
            alignment: Alignment.topLeft,
            padding: EdgeInsets.only(top: 50.0),
            color: Colors.red,
            child: Column(
              children: <Widget>[
                Row(textDirection: TextDirection.ltr, children: const <Widget>[
                  Text(
                    "Asus Laptop",
                    textDirection: TextDirection.ltr,
                    style: TextStyle(color: Colors.white, fontSize: 22.0, decoration: TextDecoration.none ),
                  ),
                  Expanded(
                    child: Text(
                      "16 Gb Ram, 128 Gb SSD, Intel I7",
                      textDirection: TextDirection.ltr,
                      style: TextStyle(color: Colors.white,fontSize: 22.0, decoration: TextDecoration.none),
                    ),
                  )
                ]),
                Row(textDirection: TextDirection.ltr, children: const <Widget>[
                  Text(
                    "Hp Laptop",
                    textDirection: TextDirection.ltr,
                    style: TextStyle(color: Colors.white,fontSize: 22.0, decoration: TextDecoration.none),
                  ),
                  Expanded(
                    child: Text(
                      "32 Gb Ram, 512 Gb SSD, Intel I7",
                      textDirection: TextDirection.ltr,
                      style: TextStyle(color: Colors.white,fontSize: 22.0, decoration: TextDecoration.none),
                    ),
                  )
                ]),
                Directionality(
                  child: OrderButton(),
                  textDirection: TextDirection.ltr,
                )
               
              ],
            )));
  }
}

class OrderButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var button = Container(
      margin: EdgeInsets.only(top: 50.0),
      child: RaisedButton(
        child: Text("Go to checkout"),
        elevation: 5.0,
        onPressed: () {order(context);},
        ),
    );
    return button;
  }
  
  order(BuildContext context) {
    var alert = const AlertDialog(
      title: Text("Go to checkout."),
      content: Text("I will go to checkout."),
    );

    showDialog(
      context: context,
      builder: (BuildContext context) => alert
    );
  }

}