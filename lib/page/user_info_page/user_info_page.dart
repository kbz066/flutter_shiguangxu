import 'dart:io';

import 'package:flustars/flustars.dart';
import 'package:flutter/material.dart';
import 'package:flutter_shiguangxu/common/ColorUtils.dart';
import 'package:flutter_shiguangxu/common/Constant.dart';
import 'package:flutter_shiguangxu/widget/ConfigCommonItem.dart';
import 'package:image_picker/image_picker.dart';

class UserInfoPage extends StatefulWidget {
  @override
  State createState() => new UserInfoPageState();
}

class UserInfoPageState extends State<UserInfoPage> {
  var _newValue = 0;
  File _image;

  Future getImage() async {
    var image = await ImagePicker.pickImage(source: ImageSource.gallery);

    LogUtil.e("加载 图片  ${image}");
    setState(() {
      _image = image;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("个人资料"),
        centerTitle: true,
        backgroundColor: ColorUtils.mainColor,
      ),
      body: SafeArea(
          child: Column(
        children: <Widget>[
          Column(
            children: <Widget>[
              ConfigCommonItem(
                Text("头像"),
                EdgeInsets.only(top: 10, bottom: 10, left: 20, right: 20),
                showDivider: true,
                content: _image == null
                    ? Image.asset(
                        Constant.IMAGE_PATH + "data_avatar_boy.png",
                        height: 60,
                      )
                    : SizedBox(
                        height: 60,
                        child: Image.file(_image),
                      ),
                onClick: getImage,
              ),
              ConfigCommonItem(
                Text("昵称"),
                EdgeInsets.only(top: 12, bottom: 12, left: 20, right: 10),
                showDivider: true,
                offstageIcon: true,
                content: Text("请填写昵称"),
              ),
              ConfigCommonItem(
                Text("手机号"),
                EdgeInsets.only(top: 12, bottom: 12, left: 20, right: 10),
                showDivider: true,
                offstageIcon: true,
                content: Text("123****7892"),
              ),
              ConfigCommonItem(
                Text("邮箱"),
                EdgeInsets.only(top: 12, bottom: 12, left: 20, right: 10),
                showDivider: true,
                content: Text(
                  "立即绑定",
                  style: TextStyle(color: ColorUtils.mainColor),
                ),
              ),
              ConfigCommonItem(
                Text("性别"),
                EdgeInsets.only(top: 0, bottom: 0, left: 20, right: 10),
                showDivider: true,
                content: Row(
                  children: <Widget>[
                    Radio<int>(
                      materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                      value: 0,
                      groupValue: _newValue,
                      onChanged: (value) {
                        setState(() {
                          _newValue = value;
                        });
                      },
                    ),
                    Text("男"),
                    Radio<int>(
                      materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                      value: 1,
                      groupValue: _newValue,
                      onChanged: (value) {
                        setState(() {
                          _newValue = value;
                        });
                      },
                    ),
                    Text("女"),
                  ],
                ),
              ),
              ConfigCommonItem(
                Text("个性签名"),
                EdgeInsets.only(top: 12, bottom: 12, left: 20, right: 10),
                showDivider: true,
                content: Text("请编辑签名"),
              ),
              ConfigCommonItem(
                Text("生日"),
                EdgeInsets.only(top: 12, bottom: 12, left: 20, right: 10),
                showDivider: true,
                content: Text("未设置"),
              ),
              ConfigCommonItem(
                Text("职业"),
                EdgeInsets.only(top: 12, bottom: 12, left: 20, right: 10),
                showDivider: true,
                content: Text("未设置"),
              ),
            ],
          ),
          Container(
            width: double.infinity,
            height: 50,
            margin: EdgeInsets.only(top: 40, left: 40, right: 40),
            child: RaisedButton(
              child: Text("保存"),
              onPressed: () {
                Navigator.pop(context);
              },
              color: Colors.blue,
              textColor: Colors.white,
              shape: new RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(25)),
            ),
          ),
        ],
      )),
    );
  }
}
