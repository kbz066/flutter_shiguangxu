import 'package:flutter/material.dart';
import 'package:flutter_shiguangxu/common/ColorUtils.dart';
import 'package:flutter_shiguangxu/common/Constant.dart';
import 'package:flutter_shiguangxu/common/NavigatorUtils.dart';
import 'package:flutter_shiguangxu/widget/ConfigCommonItem.dart';

import 'data_backup_page.dart';
import 'data_pullout_page.dart';

class DataBackupOrPulloutPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("数据备份"),
        centerTitle: true,
        backgroundColor: ColorUtils.mainColor,
      ),
      body: SafeArea(
        child: Container(
          color: ColorUtils.mainBGColor,
          child: Column(
            children: <Widget>[
              SizedBox(height: 10,),
              GestureDetector(
                onTapDown: (down) {
                  NavigatorUtils.push(context, DataBackupPage());
                },
                child: ConfigCommonItem(
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text("数据导出"),
                      Text(
                        "导出数据到邮箱",
                        style: TextStyle(color: Colors.black26, fontSize: 14),
                      ),
                    ],
                  ),
                  EdgeInsets.only(top: 5, bottom: 5, left: 20,right: 20),
                  showDivider: true,
                ),
              ),
              GestureDetector(
                onTapDown: (down) {
                  NavigatorUtils.push(context, DataPulloutPage());
                },
                child: ConfigCommonItem(
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text("数据备份"),
                      Text(
                        "保障您数据的安全与完整性",
                        style: TextStyle(color: Colors.black26, fontSize: 14),
                      ),
                    ],
                  ),
                  EdgeInsets.only(top: 5, bottom: 5, left: 20,right: 20),

                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
