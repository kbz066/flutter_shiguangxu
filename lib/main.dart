import 'package:flustars/flustars.dart';
import 'package:flutter/material.dart';
import 'package:flutter_shiguangxu/page/home_page/home_page.dart';
import 'package:flutter_shiguangxu/page/login_page/login_page.dart';
import 'package:flutter_shiguangxu/page/other_custom_page/presenter/OtherPresenter.dart';
import 'package:flutter_shiguangxu/page/schedule_page/presenter/ScheduleDatePresenter.dart';
import 'package:flutter_shiguangxu/page/schedule_page/presenter/ScheduleWeekPresenter.dart';
import 'package:flutter_shiguangxu/page/welcome_page/welcome_page.dart';

import 'package:flutter_sqlite_orm/db_manager.dart';
import 'package:provider/provider.dart';
import 'common/Constant.dart';
import 'page/quadrant_page/presenter/QuadrantPresenter.dart';
import 'page/schedule_page/presenter/SchedulePresenter.dart';
import 'utils/HttpUtils.dart';

void main() async {

  WidgetsFlutterBinding.ensureInitialized();
  await _initDataBase();
  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider.value(
        value: OtherPresenter(),
      ),
      ChangeNotifierProvider.value(
        value: SchedulePresenter(),
      ),
      ChangeNotifierProvider.value(
        value: ScheduleDatePresenter(),
      ),
      ChangeNotifierProvider.value(
        value: ScheduleWeekPresenter(),
      ),
      ChangeNotifierProvider.value(
        value: QuadrantPresenter(),
      ),

    ],
    child: MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    return MaterialApp(

        title: '时光序 ',
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
