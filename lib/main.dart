

import 'package:flutter/material.dart';
import 'package:flutter_shiguangxu/page/home_page/home_page.dart';
import 'package:flutter_shiguangxu/page/home_page/widget/Test.dart';




void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(


          primarySwatch: Colors.blue,
        ),
        home: Scaffold(

          body: SafeArea(
            child: HomePage(),
          ),
        ));
  }
}
