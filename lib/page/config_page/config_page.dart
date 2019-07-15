import 'package:flutter/material.dart';

class ConfigPage extends StatefulWidget {
  @override
  ConfigPageState createState() => new ConfigPageState();
}

class ConfigPageState extends State<ConfigPage>
    with AutomaticKeepAliveClientMixin {
  @override
  Widget build(BuildContext context) {
    return Container(
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
                            ConfigItemWidget("系统同步", "icon_tongbu_data_me"),
                            ConfigItemWidget("导出备份", "icon_daochu_data_me"),
                            ConfigItemWidget("安全中心", "icon_safe_data_me"),
                            ConfigItemWidget("回收站", "icon_hsz_data_me"),
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
                            ConfigItemWidget("提醒定制", "icon_tixing_dingzhi_me"),
                            ConfigItemWidget("铃声定制", "icon_bell_dingzhi_me"),
                            ConfigItemWidget("展示定制", "icon_zhanshi_dingzhi_me"),
                            ConfigItemWidget("个性定制", "icon_other_dingzhi_me"),
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
}

class ConfigItemWidget extends StatelessWidget {
  String title;
  String imageName;

  ConfigItemWidget(this.title, this.imageName);

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        Image.asset("assets/images/$imageName.png", fit: BoxFit.cover),
        SizedBox(
          height: 10,
        ),
        Text("$title"),
      ],
    );
  }
}
