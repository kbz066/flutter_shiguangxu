import 'package:common_utils/common_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_shiguangxu/common/NavigatorUtils.dart';
import 'package:flutter_shiguangxu/page/backup_pullout_page/backup_pullout_Page.dart';
import 'package:flutter_shiguangxu/page/config_page/system_sync_page.dart';
import 'package:flutter_shiguangxu/page/exhibition_custom_page/ExhibitionCustomPage.dart';
import 'package:flutter_shiguangxu/page/other_custom_page/OtherCustomPage.dart';
import 'package:flutter_shiguangxu/page/reminder_custom_page/ReminderCustomPage.dart';
import 'package:flutter_shiguangxu/page/ring_custom_page/RingCustomPage.dart';
import 'package:flutter_shiguangxu/page/security_page/security_page.dart';



class ConfigPage extends StatefulWidget {
  @override
  ConfigPageState createState() => new ConfigPageState();
}

class ConfigPageState extends State<ConfigPage>
    with AutomaticKeepAliveClientMixin {
  @override
  Widget build(BuildContext context) {
    return

      Container(
      child: Stack(
        children: <Widget>[
          Container(
            width: double.infinity,
            height: double.infinity,
          ),
          Image.asset(
            "assets/images/my_bg.png",
            fit: BoxFit.cover,
            width: double.infinity,
            height: 150,
          ),
          Container(
            padding: EdgeInsets.only(left: 20, right: 20, top: 30),
            child: Column(
              children: <Widget>[
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Row(
                      children: <Widget>[
                        Image.asset("assets/images/my_avatar_def.png",
                            fit: BoxFit.cover),
                        SizedBox(
                          width: 10,
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text(
                              "昵称",
                              style: TextStyle(color: Colors.white),
                            ),
                            Text(
                              "编辑个性签名",
                              style: TextStyle(color: Colors.white),
                            ),
                          ],
                        )
                      ],
                    ),
                    Image.asset("assets/images/my_icon_set.png",
                        fit: BoxFit.cover),
                  ],
                ),
                SizedBox(
                  height: 10,
                ),
                Card(
                  child: Padding(
                    padding: EdgeInsets.only(
                        left: 10, right: 10, top: 15, bottom: 15),
                    child: Column(
                      children: <Widget>[
                        Row(
                          children: <Widget>[
                            Image.asset("assets/images/icon_data_me.png",
                                fit: BoxFit.cover),
                            SizedBox(
                              width: 10,
                            ),
                            Text(
                              "数据中心",
                              style: TextStyle(fontWeight: FontWeight.bold),
                            )
                          ],
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            ConfigItemWidget("系统同步", "icon_tongbu_data_me",()=>_onTapDown("系统同步")),
                            ConfigItemWidget("导出备份", "icon_daochu_data_me",()=>_onTapDown("导出备份")),
                            ConfigItemWidget("安全中心", "icon_safe_data_me",()=>_onTapDown("安全中心")),
                            ConfigItemWidget("回收站", "icon_hsz_data_me",()=>_onTapDown("回收站")),
                          ],
                        )
                      ],
                    ),
                  ),
                ),
                Card(
                  child: Padding(
                    padding: EdgeInsets.only(
                        left: 10, right: 10, top: 15, bottom: 15),
                    child: Column(
                      children: <Widget>[
                        Row(
                          children: <Widget>[
                            Image.asset("assets/images/icon_dingzhi_me.png",
                                fit: BoxFit.cover),
                            SizedBox(
                              width: 10,
                            ),
                            Text(
                              "定制服务",
                              style: TextStyle(fontWeight: FontWeight.bold),
                            )
                          ],
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            ConfigItemWidget("提醒定制", "icon_tixing_dingzhi_me",()=>_onTapDown("提醒定制")),
                            ConfigItemWidget("铃声定制", "icon_bell_dingzhi_me",()=>_onTapDown("铃声定制")),
                            ConfigItemWidget("展示定制", "icon_zhanshi_dingzhi_me",()=>_onTapDown("展示定制")),
                            ConfigItemWidget("个性定制", "icon_other_dingzhi_me",()=>_onTapDown("个性定制")),
                          ],
                        )
                      ],
                    ),
                  ),
                ),
                Card(
                  child: Padding(
                    padding: EdgeInsets.only(
                        left: 10, right: 10, top: 15, bottom: 15),
                    child: Column(
                      children: <Widget>[
                        Row(
                          children: <Widget>[
                            Expanded(
                              child: Row(
                                children: <Widget>[
                                  Image.asset(
                                      "assets/images/my_icon_applets.png",
                                      fit: BoxFit.cover),
                                  SizedBox(
                                    width: 10,
                                  ),
                                  Text(
                                    "实用功能",
                                    style:
                                        TextStyle(fontWeight: FontWeight.bold),
                                  )
                                ],
                              ),
                            ),
                            Image.asset(
                                "assets/images/icon_rightarrow_gray.png",
                                fit: BoxFit.cover),
                          ],
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(vertical: 15),
                          child: Column(
                            children: <Widget>[
                              Divider(
                                height: 1,
                              ),
                              SizedBox(
                                height: 15,
                              ),
                              Row(
                                children: <Widget>[
                                  Expanded(
                                    child: Row(
                                      children: <Widget>[
                                        Image.asset(
                                            "assets/images/my_icon_share.png",
                                            fit: BoxFit.cover),
                                        SizedBox(
                                          width: 10,
                                        ),
                                        Text(
                                          "邀请好友",
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold),
                                        )
                                      ],
                                    ),
                                  ),
                                  Image.asset(
                                      "assets/images/icon_rightarrow_gray.png",
                                      fit: BoxFit.cover),
                                ],
                              ),
                              SizedBox(
                                height: 15,
                              ),
                              Divider(
                                height: 1,
                              )
                            ],
                          ),
                        ),
                        Row(
                          children: <Widget>[
                            Expanded(
                              child: Row(
                                children: <Widget>[
                                  Image.asset(
                                      "assets/images/my_icon_feedback.png",
                                      fit: BoxFit.cover),
                                  SizedBox(
                                    width: 10,
                                  ),
                                  Text(
                                    "意见反馈",
                                    style:
                                        TextStyle(fontWeight: FontWeight.bold),
                                  )
                                ],
                              ),
                            ),
                            Image.asset(
                                "assets/images/icon_rightarrow_gray.png",
                                fit: BoxFit.cover),
                          ],
                        )
                      ],
                    ),
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;


  _onTapDown(String type){

    LogUtil.e("执行了  _onTapDown   $type");
    switch(type){
      case "系统同步":
        NavigatorUtils.push(context, SystemSyncPage());
        break;

      case "导出备份":
        NavigatorUtils.push(context, DataBackupOrPulloutPage());
        break;

      case "安全中心":
        NavigatorUtils.push(context, SecurityPage());
        break;
      case "提醒定制":
        NavigatorUtils.push(context, ReminderCustomPage());
        break;
      case "铃声定制":
        NavigatorUtils.push(context, RingCustomPage());
        break;
      case "展示定制":
        NavigatorUtils.push(context, ExhibitionCustomPage());
        break;
      case "个性定制":
        NavigatorUtils.push(context, OtherCustomPage());
        break;

    }
  }
}

class ConfigItemWidget extends StatelessWidget {
  String title;
  String imageName;
  VoidCallback callback;


  ConfigItemWidget(this.title, this.imageName, this.callback);

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return GestureDetector(
      onTapDown: (down){
        LogUtil.e("我被点击了");
        callback();
      },
      child: Container(
        color: Colors.transparent,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Image.asset("assets/images/$imageName.png", fit: BoxFit.cover),

            SizedBox(height: 10,),
            Text("$title"),
          ],
        ),
      ),
    );
  }
}
