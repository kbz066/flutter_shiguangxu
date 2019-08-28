import 'package:flustars/flustars.dart';
import 'package:flutter/material.dart' hide Action;
import 'package:flutter/rendering.dart';
import 'package:flutter_shiguangxu/common/NavigatorUtils.dart';
import 'package:flutter_shiguangxu/page/home_page/home_page.dart';
import 'package:flutter_shiguangxu/page/login_page/presenter/LoginPresenter.dart';
import 'package:flutter_shiguangxu/page/register_page/presenter/RegisterPresenter.dart';
import 'package:flutter_shiguangxu/page/register_page/register_page.dart';
import 'package:provider/provider.dart';
import 'package:toast/toast.dart';

class LoginPage extends StatelessWidget {

  String _name;
  int _password;
  @override
  Widget build(BuildContext context) {
    return Material(
      child: Scaffold(
        resizeToAvoidBottomPadding:false ,
        body: SafeArea(
          child: Stack(
            children: <Widget>[
              Align(
                alignment: Alignment.topCenter,
                child: Image.asset(
                  "assets/images/login_bg.png",
                  fit: BoxFit.cover,
                ),
              ),
              Stack(
                overflow: Overflow.visible,
                children: <Widget>[
                  Align(
                    alignment: Alignment(0, -0.2),
                    child: Container(
                      width: 320,
                      height: 300,
                      child: Card(
                        elevation: 5,
                        child: Padding(
                          padding: EdgeInsets.symmetric(horizontal: 20),
                          child:  Column(
                            children: <Widget>[
                              _buildUserWidget(),
                              Divider(
                                height: 1,
                              ),
                              _buildPasswordWidget(),
                              Divider(
                                height: 1,
                              ),
                              Container(
                                width: 250,
                                height: 50,
                                margin: EdgeInsets.only(top: 20),
                                child: RaisedButton(
                                  child: Text("登录"),
                                  onPressed: () =>_onSubmit(context),
                                  color: Colors.blue,
                                  textColor: Colors.white,
                                  shape: new RoundedRectangleBorder(
                                      borderRadius:
                                      BorderRadius.circular(25)),
                                ),
                              ),
                              Row(
                                mainAxisAlignment:
                                MainAxisAlignment.spaceBetween,
                                children: <Widget>[
                                  Padding(
                                    padding:
                                    EdgeInsets.only(left: 20, top: 20),
                                    child: Text(
                                      "使用手机号",
                                      style: TextStyle(color: Colors.black26),
                                    ),
                                  ),
                                  Padding(
                                    padding:
                                    EdgeInsets.only(right: 20, top: 20),
                                    child: Text(
                                      "忘记密码?",
                                      style: TextStyle(color: Colors.black26),
                                    ),
                                  ),
                                ],
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                  Align(
                    alignment: Alignment(0, -0.7),
                    child: Image.asset("assets/images/longmao_openeye.png"),
                  ),
                  SizedBox(
                    width: 20,
                  ),
                  Align(
                    alignment: Alignment(0, 0.6),
                    child: Row(
                      children: <Widget>[
                        Expanded(
                          child: Container(
                            color: Colors.black12,
                            height: 0.5,
                            margin: EdgeInsets.only(left: 30),
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.symmetric(horizontal: 15),
                          child: Text(
                            "第三方登录",
                            style: TextStyle(color: Colors.black26),
                          ),
                        ),
                        Expanded(
                          child: Container(
                            color: Colors.black12,
                            height: 0.5,
                            margin: EdgeInsets.only(right: 30),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Align(
                    alignment: Alignment(0, 0.8),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        ClipOval(
                          child: Image.asset("assets/images/qq.png"),
                        ),
                        SizedBox(
                          width: 30,
                        ),
                        ClipOval(
                          child: Image.asset("assets/images/wechat.png"),
                        )
                      ],
                    ),
                  ),
                  Positioned(
                    child: Container(
                      padding:
                          EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Icon(
                            Icons.close,
                            color: Colors.white70,
                            size: 20,
                          ),Text(
                            "登录",
                            style:
                            TextStyle(color: Colors.white70, fontSize: 18),
                          ),

                          GestureDetector(
                            onTapDown: (_) {
                              LogUtil.e("点击 注册了");
                              NavigatorUtils.push(
                                  context,
                                  ChangeNotifierProvider.value(
                                    value: RegisterPresenter(),
                                    child: RegisterPage(),
                                  ));
                            },
                            child: Text(
                              "注册",
                              style: TextStyle(
                                  color: Colors.white70, fontSize: 18),
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
  void _onSubmit(context) {
    LogUtil.e("_onSubmit     $_name      $_password");
    if (_name == null || _password == null) {
      Toast.show("账号或密码不能为空!", context,
          duration: Toast.LENGTH_SHORT, gravity: Toast.BOTTOM);
    }else{
      Provider.of<LoginPresenter>(context).login(context, _name, _password);
    }
  }
  _textChange(type, value) {
    LogUtil.e("_textChange     $type      $value");
    switch (type) {
      case "账号":

        _name=value;
        break;
      case "密码":
        _password=int.parse(value);
        break;
    }
  }
  _buildUserWidget() {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 20),
      child: Row(
        children: <Widget>[
          Text(
            '账号',
            style: TextStyle(fontSize: 16),
          ),
          SizedBox(
            width: 200,
            child: TextField(
              onChanged: (val)=>_textChange("账号", val),
              decoration: InputDecoration(
                  contentPadding: EdgeInsets.only(left: 20),
                  border: InputBorder.none,
                  hintText: "请输入您的手机号/邮箱",
                  hintStyle: TextStyle(color: Colors.black26),
                  prefixStyle: TextStyle(color: Colors.black)),
            ),
          ),
        ],
      ),
    );
  }

  _buildPasswordWidget() {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 20),
      child: Row(
        children: <Widget>[
          Text(
            '密码',
            style: TextStyle(fontSize: 16),
          ),
          SizedBox(
            width: 200,
            child: TextField(
              onChanged: (val)=>_textChange("密码", val),
              decoration: InputDecoration(
                  contentPadding: EdgeInsets.only(left: 20),
                  border: InputBorder.none,
                  hintText: "请输入您的密码",
                  hintStyle: TextStyle(color: Colors.black26),
                  prefixStyle: TextStyle(color: Colors.black)),
            ),
          ),
        ],
      ),
    );
  }
}
