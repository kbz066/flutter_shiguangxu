import 'package:flutter/material.dart';
import 'package:flutter_shiguangxun/page/home_page/home_page.dart';
import 'package:flutter_shiguangxun/page/login_page/LoginPage.dart';
import 'package:flutter_shiguangxun/page/register_page/register_page.dart';
import 'package:flutter_shiguangxun/page/welcome_page/welcome_page.dart';

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
