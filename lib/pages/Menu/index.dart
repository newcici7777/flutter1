import 'package:flutter/material.dart';

class MenuView extends StatefulWidget {
  MenuView({Key? key}) : super(key: key);

  @override
  _MenuViewStateState createState() => _MenuViewStateState();
}

class _MenuViewStateState extends State<MenuView> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text("菜单"),
    );
  }
}
