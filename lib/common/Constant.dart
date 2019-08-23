import 'package:flutter/material.dart';

class Constant {
  static final IMAGE_PATH = "assets/images/";

  static final OTHER_DATA = [
    {"class_icon_work2.png": "工作"},
    {"class_icon_learn2.png": "学习"},
    {"class_icon_default2.png": "私事"},
    {"class_icon_health2.png": "健康"},
    {"class_icon_anniversary2.png": "娱乐"}
  ];

  static final DB_VERSION = 1;
  static final DB_NAME = "flutter_sgx.db";


  static int getMonthOfDay(int year,int month){
    int day = 0;
    if(year%4==0&&year%100!=0||year%400==0){
      day = 29;
    }else{
      day = 28;
    }
    switch (month){
      case 1:
      case 3:
      case 5:
      case 7:
      case 8:
      case 10:
      case 12:
        return 31;
      case 4:
      case 6:
      case 9:
      case 11:
        return 30;
      case 2:
        return day;

    }

    return 0;
  }
  static bool isLogin(BuildContext buildContext) {}
}
