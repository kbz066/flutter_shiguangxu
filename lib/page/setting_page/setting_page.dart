import 'package:flutter/material.dart';
import 'package:flutter_shiguangxu/common/ColorUtils.dart';
import 'package:flutter_shiguangxu/widget/ConfigCommonItem.dart';



class SettingPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("设置"),
        centerTitle: true,
        backgroundColor: ColorUtils.mainColor,
      ),
      body: SafeArea(
          child:Column(
            children: <Widget>[
              Container(
                child: Column(
                  children: <Widget>[
                    ConfigCommonItem(
                      Text("帮助中心"),
                      EdgeInsets.only(top: 14, bottom: 14, left: 20,right: 20),
                      showDivider: true,

                    ),
                    ConfigCommonItem(
                      Text("给个好评"),
                      EdgeInsets.only(top: 14, bottom: 14, left: 20,right: 20),
                      showDivider: true,

                    ),
                    ConfigCommonItem(
                      Text("清除缓存"),
                      EdgeInsets.only(top: 14, bottom: 14, left: 20,right: 20),
                      showDivider: true,
                      content: Text("44.25KB"),

                    ),
                    ConfigCommonItem(
                      Text("关于我们"),
                      EdgeInsets.only(top: 14, bottom: 14, left: 20,right: 20),


                    ),
                  ],
                ),
              ),

              SizedBox(height: 10),
              ConfigCommonItem(
                Text("退出登录"),
                EdgeInsets.only(top: 14, bottom: 14, left: 20,right: 20),
                showDivider: true,

              ),
            ],
          )
      ),
    );
  }
}
