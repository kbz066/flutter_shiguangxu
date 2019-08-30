import 'dart:io';
import 'dart:ui';

import 'package:dio/dio.dart';
import 'package:flustars/flustars.dart';

import 'package:flutter/material.dart';

import 'package:flutter_shiguangxu/common/ColorUtils.dart';
import 'package:flutter_shiguangxu/common/Constant.dart';
import 'package:flutter_shiguangxu/entity/user_info_entity.dart';
import 'package:flutter_shiguangxu/widget/ConfigCommonItem.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

import 'presenter/UserInfoPresenter.dart';

class UserInfoPage extends StatefulWidget {
  @override
  State createState() => new UserInfoPageState();
}

class UserInfoPageState extends State<UserInfoPage> {
  var _newValue = 1;

  File _image;

  UserInfoData _infoData;

  @override
  void initState() {
    this._infoData = Provider.of<UserInfoPresenter>(context, listen: false)
        .infoData ??= UserInfoData();

    LogUtil.e("打印                          ${_infoData.toJson()}");
    super.initState();
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
          child: SingleChildScrollView(
              child: Column(
        children: <Widget>[
          Column(
            children: <Widget>[
              ConfigCommonItem(
                Text("头像"),
                EdgeInsets.only(top: 10, bottom: 10, left: 20, right: 20),
                showDivider: true,
                content: _infoData.headImage == null
                    ? Container(
                  child: Image.asset(
                    Constant.IMAGE_PATH + (_infoData.sex==1?"my_avatar_boy.png":"my_avatar_girl.png"),
                    height: 60,
                    fit: BoxFit.cover,
                  ),
                )
                    : ClipOval(
                        child: Image.file(
                          _image,
                          height: 50,
                        ),
                      ),
                onClick: getImage,
              ),
              ConfigCommonItem(
                Text("昵称"),
                EdgeInsets.only(top: 12, bottom: 12, left: 20, right: 10),
                showDivider: true,
                offstageIcon: true,
                content: Container(
                  width: 100,
                  alignment: Alignment.center,
                  child: TextField(


                    onChanged: (val){
                      _infoData.userName=val;
                    },
                    controller: TextEditingController(text: null),
                    textAlign: TextAlign.end,
                    decoration: InputDecoration(
                      hintText: "请填写昵称",
                      border: InputBorder.none,
                        contentPadding: EdgeInsets.zero
                    ),
                    style: TextStyle(),
                  ),
                ),
              ),
              ConfigCommonItem(
                Text("手机号"),
                EdgeInsets.only(top: 12, bottom: 12, left: 20, right: 10),
                showDivider: true,
                offstageIcon: true,
                content: Text(_infoData.mobile),
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
                      value: 1,
                      groupValue: _infoData.sex,
                      onChanged: (value) {
                        setState(() {
                          _infoData.sex = value;
                        });
                      },
                    ),
                    Text("男"),
                    Radio<int>(
                      materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                      value: 0,
                      groupValue: _infoData.sex,
                      onChanged: (value) {
                        setState(() {
                          _infoData.sex = value;
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
                content: Text(_infoData.autograph ?? "请编辑签名"),
              ),
              ConfigCommonItem(
                Text("生日"),
                EdgeInsets.only(top: 12, bottom: 12, left: 20, right: 10),
                showDivider: true,
                content: Text(_infoData.birthday ?? "未设置"),
              ),
              ConfigCommonItem(
                Text("职业"),
                EdgeInsets.only(top: 12, bottom: 12, left: 20, right: 10),
                showDivider: true,
                content: Text(_infoData.occupation ?? "未设置"),
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
                LogUtil.e("json                ${this._infoData.toJson()}");
                Provider.of<UserInfoPresenter>(context, listen: false).updateInfo(this._infoData, context);
//                Navigator.pop(context);
              },
              color: Colors.blue,
              textColor: Colors.white,
              shape: new RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(25)),
            ),
          ),
        ],
      ))),
    );
  }

  Future getImage() async {
    var image =
        await ImagePicker.pickImage(source: ImageSource.gallery, maxHeight: 50);
    _infoData.headImage = image.readAsBytesSync();
    LogUtil.e("加载 图片  ${image}       ${image.readAsBytesSync().length}");
    setState(() {
      _image = image;
    });
  }
}
