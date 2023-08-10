import 'package:fitness/pages/cart.dart';
import 'package:fitness/pages/catalog.dart';
import 'package:fitness/pages/home.dart';
import 'package:flutter/material.dart';

import '../pages/tabs.dart';

//配置路由
final routes = {
  '/': (context) => const Tabs(),
  '/home': (context) => HomePage(),
  '/catalog': (context, state) => const MyCatalog(),
  '/cart': (context, state) => const MyCart()
};

//固定写法
var onGenerateRoute = (RouteSettings settings) {
// 统一处理
  final String? name = settings.name;
  final Function? pageContentBuilder = routes[name];
  if (pageContentBuilder != null) {
    if (settings.arguments != null) {
      final Route route = MaterialPageRoute(
          builder: (context) =>
              pageContentBuilder(context, arguments: settings.arguments));
      return route;
    } else {
      final Route route =
      MaterialPageRoute(builder: (context) => pageContentBuilder(context));
      return route;
    }
  }
};