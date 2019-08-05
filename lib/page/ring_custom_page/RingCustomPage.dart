import 'package:flutter/material.dart';
import 'package:flutter_shiguangxu/common/ColorUtils.dart';
import 'package:flutter_shiguangxu/widget/ConfigCommonItem.dart';

class RingCustomPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("铃声定制"),
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
                  Text("通知音效"),
                  EdgeInsets.only(top: 14, bottom: 14, left: 20,right: 20),
                  showDivider: true,
                  content: Text("默认"),
                ),
              ),
              GestureDetector(
                onTapDown: (down) {

                },
                child: ConfigCommonItem(
                  Text("完成音效"),
                  EdgeInsets.only(top: 14, bottom: 14, left: 20,right: 20),
                  content: Text("默认"),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}