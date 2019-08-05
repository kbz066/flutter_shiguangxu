import 'package:flutter/material.dart';
import 'package:flutter_shiguangxu/common/ColorUtils.dart';
import 'package:flutter_shiguangxu/common/Constant.dart';
import 'package:flutter_shiguangxu/widget/ConfigCommonItem.dart';

class UserInfoPage extends StatefulWidget {
  @override
  State createState() => new UserInfoPageState();
}

class UserInfoPageState extends State<UserInfoPage> {
  var _newValue = 0;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text("个人资料"),
          centerTitle: true,
          backgroundColor: ColorUtils.mainColor,
        ),
        body: SafeArea(
            child: Column(
          children: <Widget>[
            ConfigCommonItem(
              Text("头像"),
              EdgeInsets.only(top: 14, bottom: 14, left: 20, right: 20),
              showDivider: true,
              content: Image.asset(
                Constant.IMAGE_PATH + "data_avatar_boy.png",
                height: 60,
              ),
            ),
            ConfigCommonItem(
              Text("昵称"),
              EdgeInsets.only(top: 14, bottom: 14, left: 20, right: 10),
              showDivider: true,
              offstageIcon: true,
              content: Text("请填写昵称"),
            ),
            ConfigCommonItem(
              Text("手机号"),
              EdgeInsets.only(top: 14, bottom: 14, left: 20, right: 10),
              showDivider: true,
              offstageIcon: true,
              content: Text("123****7892"),
            ),
            ConfigCommonItem(
              Text("邮箱"),
              EdgeInsets.only(top: 14, bottom: 14, left: 20, right: 10),
              showDivider: true,
              content: Text(
                "立即绑定",
                style: TextStyle(color: ColorUtils.mainColor),
              ),
            ),
            ConfigCommonItem(
              Text("性别"),
              EdgeInsets.only(top: 14, bottom: 14, left: 20, right: 10),
              showDivider: true,
              content:
              Row(
                children: <Widget>[
                  SizedBox(
                    width: 70,
                    child: RadioListTile<int>(
                      value: 0,
                      title: Text('男'),
                      groupValue: _newValue,
                      onChanged: (value) {
                        setState(() {
                          _newValue = value;
                        });
                      },
                    ),
                  ),
                  SizedBox(
                    width: 70,
                    child: RadioListTile<int>(
                      value: 1,
                      title: Text('女'),
                      groupValue: _newValue,
                      onChanged: (value) {
                        setState(() {
                          _newValue = value;
                        });
                      },
                    ),
                  ),
                ],
              ),
            )
          ],
        )),
      ),
    );
  }
}
