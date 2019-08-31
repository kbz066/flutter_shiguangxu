import 'package:flutter/material.dart';
import 'package:flutter_shiguangxu/common/ColorUtils.dart';
import 'package:flutter_shiguangxu/common/Constant.dart';
import 'package:flutter_shiguangxu/common/NavigatorUtils.dart';
import 'package:flutter_shiguangxu/widget/InkWellImageWidget.dart';

class UserAutographPage extends StatelessWidget {


  String autographTxt;

  UserAutographPage(this.autographTxt);

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Scaffold(
        backgroundColor: ColorUtils.mainBGColor,
        appBar: AppBar(
          title: Text("个人资料"),
          centerTitle: true,
          backgroundColor: ColorUtils.mainColor,
          actions: <Widget>[
            GestureDetector(
              onTapDown: (_) {
                NavigatorUtils.pop(context,autographTxt);
              },
              child: Image.asset(
                Constant.IMAGE_PATH + "icon_close_nav_white.png",
                width: 50,
              ),
            )
          ],
        ),
        body: Container(
          color: Colors.white,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text("签名:",style: TextStyle(fontSize: 16),),
              Expanded(
                child: TextField(

                  maxLength: 28,
                  controller: TextEditingController(text: autographTxt),
                  decoration: InputDecoration(
                    hintText: "请输入签名",
                    border:InputBorder.none,
                    contentPadding: EdgeInsets.only(bottom: 50)
                  ),
                  onChanged: (val) {
                    this.autographTxt = val;
                  },
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
