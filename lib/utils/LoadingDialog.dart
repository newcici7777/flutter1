import 'package:flutter/cupertino.dart';

import 'package:flutter/material.dart';

class LoadingDialog {
  static show(BuildContext context, {String msg = "加载中"}) {
    showDialog(
        context: context,
        builder: (context) {
          return Dialog(
              backgroundColor: Colors.transparent,
              child: Center(
                  child: Container(
                padding: EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    CircularProgressIndicator(),
                    SizedBox(height: 10),
                    Text(msg),
                  ],
                ),
              )));
        });
  }

  static hide(BuildContext context) {
    Navigator.pop(context);
  }
}
