import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'DemoHeader.dart';

class aaa extends StatelessWidget {
  final List<Color> colors = [
    Colors.red,
    Colors.green,
    Colors.blue,
    Colors.pink
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: ListView.builder(


            itemCount: 1,
            itemBuilder: (BuildContext context, int index) {
              return Text("$index");
            }));
  }
}
