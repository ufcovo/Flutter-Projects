import 'package:ecommerce/screens/product_detail.dart';
import 'package:ecommerce/utilities/constants.dart';
import 'package:flutter/material.dart';

class Routes {
  static final routes = <String,WidgetBuilder>{
    Contants.ROUTE_PRODUCT_DETAIL: (BuildContext context) => ProductDetail()
  };
}