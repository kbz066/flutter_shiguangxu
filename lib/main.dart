import 'package:common_utils/common_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_shiguangxu/page/home_page/home_page.dart';
import 'package:flutter_shiguangxu/page/login_page/LoginPage.dart';
import 'package:flutter_shiguangxu/page/welcome_page/welcome_page.dart';
import 'package:flutter_sqlite_orm/db_manager.dart';

import 'Test.dart';
import 'common/Constant.dart';

void main() async {
  await _initDataBase();
  runApp(MyApp());
}

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
            child: TestPage(),
          ),
        ));
  }
}

void _initDataBase() async {
  LogUtil.e("_initDataBase   开始");
  await DBManager.getInstance().init(Constant.DB_VERSION, Constant.DB_NAME);
  LogUtil.e("_initDataBase   结束");
}
