import 'package:flutter/material.dart';

class NavigatorUtils {
  static Future  push(context, widget) {
    return Navigator.push(context, MaterialPageRoute(builder: (context) {
      return widget;
    }));

  }

  static pushReplacement(context, widget) {

    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) {
      return widget;
    }));
  }
  static pop(context,[  result ]) {

    Navigator.pop(context,result);
  }
}
