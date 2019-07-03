import 'package:flutter/material.dart';
import 'package:flutter_shiguangxun/welcome_page/welcome_page.dart';

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
            child: WelcomePage(),
          ),
        ));
  }
}
