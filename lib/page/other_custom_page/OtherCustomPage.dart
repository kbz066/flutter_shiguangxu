import 'package:flutter/material.dart';
import 'package:flutter_shiguangxu/common/ColorUtils.dart';
import 'package:flutter_shiguangxu/common/NavigatorUtils.dart';
import 'package:flutter_shiguangxu/dao/Other_DB.Dao.dart';
import 'package:flutter_shiguangxu/page/other_custom_page/presenter/OtherPresenter.dart';
import 'package:flutter_shiguangxu/widget/ConfigCommonItem.dart';
import 'package:provider/provider.dart';

import 'OtherAddPage.dart';
import 'OtherManagePage.dart';
import 'model/OtherModel.dart';

class OtherCustomPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("个性定制"),
        centerTitle: true,
        backgroundColor: ColorUtils.mainColor,
      ),
      body: SafeArea(
        child: Container(
          color: ColorUtils.mainBGColor,
          child: Column(
            children: <Widget>[
              SizedBox(
                height: 10,
              ),
              GestureDetector(
                onTapDown: (down) {},
                child: ConfigCommonItem(
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text("猜你想添加日程"),
                      Text(
                        "开启后，app自动检测粘贴板内容，快速添加日程",
                        style: TextStyle(color: Colors.black26, fontSize: 13),
                      ),
                    ],
                  ),
                  EdgeInsets.only(top: 5, bottom: 5, left: 20, right: 0),
                  showSwitchBut: true,
                ),
              ),
              SizedBox(height: 10),
              GestureDetector(
                onTapDown: (down) {},
                child: ConfigCommonItem(
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text("自定义分类管理"),
                      Text(
                        "自定义设置清单、日程分类",
                        style: TextStyle(color: Colors.black26, fontSize: 14),
                      ),
                    ],
                  ),
                  EdgeInsets.only(top: 10, bottom: 10, left: 20, right: 20),
                  onClick: () {
                    Other_DB_Dao.init().then((onValue) {
                      NavigatorUtils.push(
                          context,
                          OtherManagePage()
                      );
                    });
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
