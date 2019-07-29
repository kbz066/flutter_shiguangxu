import 'package:flutter/material.dart';
import 'package:flutter_shiguangxu/common/ColorUtils.dart';
import 'package:flutter_shiguangxu/common/Constant.dart';

class DataBackupPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("数据导出"),
        centerTitle: true,
        backgroundColor: ColorUtils.mainColor,
      ),
      body: SafeArea(
          child: Container(
        color: ColorUtils.mainBGColor,
        child: Column(
          children: <Widget>[
            Container(
              color: Colors.white,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  SizedBox(
                    height: 10,
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: 10),
                    child: Text(
                      "请选择导出类型",
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        _getCircularItem("日程"),
                        _getCircularItem("清单"),
                        _getCircularItem("日总结"),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Divider(height: 1.0),
                  Padding(
                    padding: EdgeInsets.only(left: 10, top: 10, bottom: 20),
                    child: Text(
                      "数据将导出到您已绑定的邮箱",
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: 10, right: 10, bottom: 20),
                    child: Row(
                      children: <Widget>[
                        Image.asset(
                            Constant.IMAGE_PATH + "export_icon_mailbox.png"),
                        RichText(
                          text: TextSpan(children: <TextSpan>[
                            TextSpan(
                                text: "   您还未绑定邮箱,点击立即绑定点击",
                                style: TextStyle(
                                    color: Color.fromARGB(100, 0, 0, 0))),
                            TextSpan(
                                text: "立即绑定",
                                style: TextStyle(
                                    color: Colors.blue,
                                    decoration: TextDecoration.underline))
                          ]),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
            Container(
              width: 250,
              height: 40,
              margin: EdgeInsets.only(top: 40),
              alignment: Alignment.center,
              decoration: BoxDecoration(
                  color: Colors.black12,
                  borderRadius: BorderRadius.all(Radius.circular(20))),
              child: Text(
                "立即导出",
                style: TextStyle(color: Colors.white70),
              ),
            ),
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: <Widget>[
                  Text(
                    "查看历史导出记录",
                    style: TextStyle(
                        fontSize: 13,
                        color: ColorUtils.mainColor,
                        decoration: TextDecoration.underline),
                  ),
                  Padding(
                    padding: EdgeInsets.only(bottom: 20),
                    child: Text(
                      "同一类型,1个月只能导出1次",
                      style: TextStyle(
                        fontSize: 14,
                      ),
                    ),
                  )
                ],
              ),
            )
          ],
        ),
      )),
    );
  }

  _getCircularItem(title) {
    return Container(
      height: 30,
      width: 90,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: Color(0xffE8E8E8),
        borderRadius: BorderRadius.all(Radius.circular(15)),
      ),
      child: Text(title),
    );
  }
}
