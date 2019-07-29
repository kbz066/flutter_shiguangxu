import 'package:flutter/material.dart';
import 'package:flutter_shiguangxu/common/ColorUtils.dart';
import 'package:flutter_shiguangxu/common/NavigatorUtils.dart';
import 'package:flutter_shiguangxu/page/backup_pullout_page/data_backup_page.dart';
import 'package:flutter_shiguangxu/widget/ConfigCommonItem.dart';



class ReminderCustomPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("提醒定制"),
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

                },
                child: ConfigCommonItem(
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text("默认提醒"),
                      Text(
                        "开启后,将会按日程时间准时提醒您",
                        style: TextStyle(color: Colors.black26, fontSize: 14),
                      ),
                    ],
                  ),
                  EdgeInsets.only(top: 5, bottom: 5, left: 20,right: 20),
                  showDivider: true,
                  content: Text("已开启"),
                ),
              ),
              GestureDetector(
                onTapDown: (down) {

                },
                child: ConfigCommonItem(
                  Text("提醒方式"),
                  EdgeInsets.only(top: 14, bottom: 14, left: 20,right: 20),

                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
