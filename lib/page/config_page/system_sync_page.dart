import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_shiguangxu/common/ColorUtils.dart';
import 'package:flutter_shiguangxu/widget/ConfigCommonItem.dart';

class SystemSyncPage extends StatefulWidget {
  @override
  State createState() => new SystemSyncPageState();
}

class SystemSyncPageState extends State<SystemSyncPage> {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
        appBar: AppBar(
          title: Text("系统同步"),
          centerTitle: true,
          backgroundColor: ColorUtils.mainColor,
        ),
        body: SafeArea(
          child: Container(
            color: ColorUtils.mainBGColor,

            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                SizedBox(height: 10,),
                ConfigCommonItem(
                  Text("同步系统日历"),
                  EdgeInsets.only(top: 3,bottom: 3,left: 20),
                  showSwitchBut: true,
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20),
                  child: Text(
                    "开启后，时光序会显示本地系统日程",
                    style: TextStyle(color: Colors.black26),
                  ),
                )
              ],
            ),
          ),
        ));
  }
}
