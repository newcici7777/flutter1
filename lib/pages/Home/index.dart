import 'package:flutter/material.dart';

class HomeView extends StatefulWidget {
  HomeView({Key? key}) : super(key: key);

  @override
  _HomeViewStateState createState() => _HomeViewStateState();
}

class _HomeViewStateState extends State<HomeView> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text("首页"),
    );
  }
}
