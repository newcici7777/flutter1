import 'package:flutter/material.dart';
import 'package:shop/pages/Login/index.dart';
import 'package:shop/pages/Main/index.dart';

Widget getRootWidget() {
  return MaterialApp(
    routes: getRootRoutes(),
  );
}

Map<String, Widget Function(BuildContext)> getRootRoutes() {
  return {
    '/': (context) => MainPage(),
    '/login': (context) => LoginPage(),
  };
}
