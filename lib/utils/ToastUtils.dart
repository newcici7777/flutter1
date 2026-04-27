import 'package:flutter/material.dart';

class ToastUtils {
  static bool showLoading = false;
  static void show(BuildContext context, String msg) {
    if (showLoading) {
      return;
    }
    showLoading = true;
    Future.delayed(Duration(seconds: 3), () {
      showLoading = false;
    });
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
          width: 200,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          behavior: SnackBarBehavior.floating,
          duration: Duration(seconds: 3),
          content: Text(msg)),
    );
  }
}
