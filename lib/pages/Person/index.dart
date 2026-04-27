import 'package:flutter/material.dart';

class PersonView extends StatefulWidget {
  PersonView({Key? key}) : super(key: key);

  @override
  _PersonViewStateState createState() => _PersonViewStateState();
}

class _PersonViewStateState extends State<PersonView> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          GestureDetector(
            onTap: () {
              Navigator.pushNamed(context, "/login");
            },
            child: Text("登入"),
          ),
        ],
      ),
    );
  }
}
