import 'package:flutter/material.dart';

class NavigatorUtils {
  static push(context, widget) {
    Navigator.push(context, MaterialPageRoute(builder: (context) {
      return widget;
    }));
  }
}
