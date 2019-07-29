import 'package:flutter/material.dart';
import 'package:flutter_shiguangxu/common/ColorUtils.dart';
import 'package:flutter_shiguangxu/widget/ConfigCommonItem.dart';



class ExhibitionCustomPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("展示定制"),
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
                      Text("闹钟展示"),
                      Text(
                        "请选择闹钟显示的日期范围",
                        style: TextStyle(color: Colors.black26, fontSize: 14),
                      ),
                    ],
                  ),
                  EdgeInsets.only(top: 5, bottom: 5, left: 20,right: 20),

                  content: Text("7天"),
                ),
              ),
              SizedBox(height: 10),
              GestureDetector(
                onTapDown: (down) {

                },
                child: ConfigCommonItem(
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text("节日展示"),
                      Text(
                        "开启后,节日将作为日程展示",
                        style: TextStyle(color: Colors.black26, fontSize: 14),
                      ),
                    ],
                  ),
                  EdgeInsets.only(top: 10, bottom: 10, left: 20,right: 20),
                  showSwitchBut: true,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
