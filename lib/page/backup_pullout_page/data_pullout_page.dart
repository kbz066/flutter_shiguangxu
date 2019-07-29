import 'package:flustars/flustars.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_shiguangxu/common/ColorUtils.dart';
import 'package:flutter_shiguangxu/common/Constant.dart';
import 'package:flutter_shiguangxu/widget/ConfigCommonItem.dart';

class DataPulloutPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("数据导出及备份"),
        centerTitle: true,
        backgroundColor: ColorUtils.mainColor,
      ),
      body: SafeArea(
          child: Container(
        color: ColorUtils.mainBGColor,
        child: Column(
          children: <Widget>[
            ConfigCommonItem(
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text('最近备份时间',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 16,
                      )),
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                      DateUtil.formatDate(DateTime.now(),
                          format: "yyyy/MM/dd HH:mm"),
                      style: TextStyle(
                        color: Color.fromARGB(100, 0, 0, 0),
                        fontSize: 13,
                      ))
                ],
              ),
              EdgeInsets.only(left: 10, right: 20, top: 12, bottom: 12),
              content: Text("立即备份",
                  style: TextStyle(

                    color: Color.fromARGB(100, 0, 0, 0),
                    fontSize: 16,
                  )),
            ),

            SizedBox(
              height: 20,
            ),
            Expanded(
              child: Container(
                width: double.infinity,
                padding: EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      "数据备份功能介绍 :",
                      style: TextStyle(fontSize: 16),
                    ),
                    SizedBox(
                      height: 30,
                    ),
                    Text(
                      "1、实时数据备份\n在网络畅通下，我们会实时同步您的数据到云端服务器，从此不必担心丢失。",
                      style: TextStyle(color: Color.fromARGB(150, 0, 0, 0)),
                    ),
                    SizedBox(
                      height: 30,
                    ),
                    Text(
                      "2、超强多端同步\napp版与微信版？安卓版与苹果版？2个设备同时登陆？任意一端操作修改，其他端数据实时同步！",
                      style: TextStyle(color: Color.fromARGB(150, 0, 0, 0)),
                    ),
                    SizedBox(
                      height: 30,
                    ),
                    Text(
                      "3、数据跟随手机号\n所有数据绑定在您的手机号上，即使更换新手机，登录后，所有日程轻松恢复！",
                      style: TextStyle(color: Color.fromARGB(150, 0, 0, 0)),
                    ),
                    SizedBox(
                      height: 30,
                    ),
                    Text(
                      "4、数据迁移\n在绑定了邮箱后，可更换手机号。可将数据迁移至新手机号，再也不担心换号码！",
                      style: TextStyle(color: Color.fromARGB(150, 0, 0, 0)),
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      )),
    );
  }
}
