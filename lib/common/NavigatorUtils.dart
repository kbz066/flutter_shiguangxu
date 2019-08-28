import 'package:flutter/material.dart';

class NavigatorUtils {
  static push(context, widget) {
    Navigator.push(context, MaterialPageRoute(builder: (context) {
      return widget;
    }));

  }

  static pushReplacement(context, widget) {

    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) {
      return widget;
    }));
  }
  static pop(context) {

    Navigator.pop(context);
  }
}
