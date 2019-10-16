import 'package:flutter/material.dart';
import 'package:flutter_shiguangxu/common/ColorUtils.dart';
import 'package:flutter_shiguangxu/common/Constant.dart';
import 'package:flutter_shiguangxu/widget/ConfigCommonItem.dart';

class SecurityPage extends StatefulWidget {
  @override
  State createState() => new SecurityPageState();
}

class SecurityPageState extends State<SecurityPage> {
  bool check;

  @override
  void initState() {
    check = false;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("安全中心"),
        centerTitle: true,
        backgroundColor: ColorUtils.mainColor,
      ),
      body: SafeArea(
          child: Column(
        children: <Widget>[
          ConfigCommonItem(
            Text("修改登录密码"),
            EdgeInsets.only(top: 10, bottom: 10, left: 10, right: 15),
            showDivider: true,
          ),
          ConfigCommonItem(
            Text("手机号"),
            EdgeInsets.only(top: 10, bottom: 10, left: 10, right: 15),
            content: Text("182****1509"),
            showDivider: true,
          ),
          ConfigCommonItem(
            Text("邮箱号"),
            EdgeInsets.only(top: 10, bottom: 10, left: 10, right: 15),
            content: Text("立即绑定"),
            showDivider: true,
          ),
          ConfigCommonItem(
            Text("微信号"),
            EdgeInsets.only(top: 10, bottom: 10, left: 10, right: 15),
            content: Text("立即绑定"),
            showDivider: true,
          ),
          ConfigCommonItem(Text("qq号"),
              EdgeInsets.only(top: 10, bottom: 10, left: 10, right: 15),
              content: Text("立即绑定")),
          SizedBox(
            height: 10,
          ),
          ConfigCommonItem(
            Text("手势密码"),
            EdgeInsets.only(left: 10, right: 10),
            showSwitchBut: true,
          ),
        ],
      )),
    );
  }

  _getItem(title, {content}) {
    return Container(
      color: Colors.white,
      child: Column(
        children: <Widget>[
          Padding(
            padding: EdgeInsets.only(top: 10, bottom: 10, left: 10, right: 15),
            child: Row(
              children: <Widget>[
                Expanded(
                  child: title,
                ),
                Padding(
                  padding: EdgeInsets.only(right: 10),
                  child: content == null ? Container() : content,
                ),
                Image.asset(Constant.IMAGE_PATH + "icon_rightarrow_gray.png")
              ],
            ),
          ),
          Divider(
            height: 1,
            color: Colors.black26,
          )
        ],
      ),
    );
  }
}
