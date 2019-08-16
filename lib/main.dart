
import 'package:flustars/flustars.dart';
import 'package:flutter/material.dart';
import 'package:flutter_shiguangxu/page/home_page/home_page.dart';
import 'package:flutter_shiguangxu/page/login_page/LoginPage.dart';
import 'package:flutter_shiguangxu/page/other_custom_page/presenter/OtherPresenter.dart';
import 'package:flutter_shiguangxu/page/schedule_page/presenter/WeekPresenter.dart';


import 'package:flutter_sqlite_orm/db_manager.dart';
import 'package:provider/provider.dart';
import 'common/Constant.dart';
import 'page/schedule_page/presenter/SchedulePresenter.dart';
import 'utils/HttpUtils.dart';

void main() async {

  await _initDataBase();

  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider.value(
        value: OtherPresenter(),
      ),
      ChangeNotifierProvider.value(
        value: SchedulePresenter(),
      ),     ChangeNotifierProvider.value(
        value: WeekPresenter(),
      ),
    ],
    child: MyApp(),
  ));
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
            child: HomePage(),
          ),
        ));
  }
}

void _initDataBase() async {

  await DBManager.getInstance().init(Constant.DB_VERSION, Constant.DB_NAME);

}


