import 'package:flustars/flustars.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart' hide Action;
import 'package:flutter_shiguangxu/page/register_page/presenter/RegisterPresenter.dart';
import 'package:provider/provider.dart';
import 'package:toast/toast.dart';

class RegisterPage extends StatefulWidget {
  @override
  State createState() => RegisterPageState();
}

class RegisterPageState extends State<RegisterPage> {
  bool _isSHowPassWord;

  bool _isChekAgreement;
  String _name;
  int _password;

  _setPassWordEyeState() {
    print("_setPassWordEyeState----------------------------》");

    setState(() {
      _isSHowPassWord = !_isSHowPassWord;
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _isSHowPassWord = false;
    _isChekAgreement = true;
  }


  Widget build(BuildContext context) {
    return Material(
      child:  SafeArea(
        child: Stack(
          overflow: Overflow.visible,
          children: <Widget>[
            Align(
              alignment: Alignment.topCenter,
              child: Container(
                child: Image.asset(
                  "assets/images/login_bg.png",
                  fit: BoxFit.cover,
                ),
              ),
            ),
            Align(
              child: Card(
                margin: EdgeInsets.only(left: 20, right: 20),
                child: Container(
                  height: 410,
                  padding: EdgeInsets.symmetric(horizontal: 20),
                  child: Stack(
                    fit: StackFit.passthrough,
                    overflow: Overflow.visible,
                    children: <Widget>[
                      Column(
                        mainAxisSize: MainAxisSize.min,
                        children: <Widget>[
                          _buildUserWidget(),
                          Divider(
                            height: 1,
                          ),
                          _buildVerificationCode(),
                          Divider(
                            height: 1,
                          ),
                          _buildPassWord(
                              _isSHowPassWord, this._setPassWordEyeState),
                          Divider(
                            height: 1,
                          ),
                          _buildInvitationCode(),
                          Divider(
                            height: 1,
                          ),
                          Row(
                            children: <Widget>[
                              Checkbox(
                                value: _isChekAgreement,
                                checkColor: Colors.white,
                                activeColor: Colors.green,
                                onChanged: (val) {
                                  setState(() {
                                    _isChekAgreement = val;
                                  });
                                },
                              ),
                              RichText(
                                text: TextSpan(children: <TextSpan>[
                                  TextSpan(
                                      text: "已阅读并同意",
                                      style: TextStyle(color: Colors.black)),
                                  TextSpan(
                                      text: "《注册协议》",
                                      style: TextStyle(color: Colors.blue))
                                ]),
                              ),
                            ],
                          ),
                          Container(
                            width: 250,
                            height: 50,
                            margin: EdgeInsets.symmetric(vertical: 20),
                            child: RaisedButton(
                              child: Text("注册"),
                              onPressed: _onSubmit,
                              color: Colors.blue,
                              textColor: Colors.white,
                              shape: new RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(25)),
                            ),
                          ),
                        ],
                      ),
                      Align(
                        alignment: Alignment(0, -1.22),
                        child: Image.asset("assets/images/longmao_openeye.png"),
                      )
                    ],
                  ),
                ),
              ),
            ),
            Container(
              padding: EdgeInsets.only(left: 20, top: 10),
              child: Row(
                children: <Widget>[
                  Icon(
                    Icons.arrow_back_ios,
                    color: Colors.white70,
                    size: 20,
                  ),
                  SizedBox(width: 120),
                  Text(
                    "注册",
                    style: TextStyle(color: Colors.white70, fontSize: 18),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _onSubmit() {
    LogUtil.e("_onSubmit     $_name      $_password");
    if (_name == null || _password == null) {
      Toast.show("账号或密码不能为空!", context,
          duration: Toast.LENGTH_SHORT, gravity: Toast.BOTTOM);
    }else{
      Provider.of<RegisterPresenter>(context).register(context, _name, _password);
    }
  }
  _buildUserWidget() {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 20),
      child: Row(
        children: <Widget>[
          Text(
            '+86',
            style: TextStyle(fontSize: 16),
          ),
          Container(
            width: 1,
            height: 30,
            color: Colors.black12,
            margin: EdgeInsets.symmetric(horizontal: 20),
          ),
          SizedBox(
            width: 200,
            child: TextField(
              keyboardType:TextInputType.emailAddress,
              onChanged: (value) => _textChange("账号", value),
              decoration: InputDecoration(
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

  _buildVerificationCode() {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 5),
      child: Row(
        children: <Widget>[
          SizedBox(
            width: 170,
            child: TextFormField(
              decoration: InputDecoration(
                  border: InputBorder.none,
                  hintText: "请输入验证码(随便填)",
                  hintStyle: TextStyle(color: Colors.black26),
                  prefixStyle: TextStyle(color: Colors.black)),
            ),
          ),
          FlatButton(
            onPressed: () {},
            child: Text(
              "获取验证码",
              style: TextStyle(color: Colors.lightBlue),
            ),
            color: Colors.white,
            shape: StadiumBorder(
                side: new BorderSide(
                  style: BorderStyle.solid,
                  color: Colors.lightBlue,
                )),
          ),
        ],
      ),
    );
  }

  _buildPassWord(isSHowPassWord, _onPressed) {
    return Container(
        margin: EdgeInsets.symmetric(vertical: 5),
        child: TextField(
            keyboardType: TextInputType.number,
            onChanged: (value) => _textChange("密码", value),
            obscureText: !isSHowPassWord,
            decoration: InputDecoration(
              border: InputBorder.none,
              hintText: "请设置6-16位登录密码",
              hintStyle: TextStyle(color: Colors.black26),
              suffixIcon: IconButton(
                icon: isSHowPassWord
                    ? Image.asset("assets/images/icon_password_see.png")
                    : Image.asset("assets/images/icon_password_nosee.png"),
                onPressed: _onPressed,
              ),
            )));
  }

  _buildInvitationCode() {
    return Container(
        margin: EdgeInsets.symmetric(vertical: 5),
        child: TextField(
            decoration: InputDecoration(
              border: InputBorder.none,
              hintText: "请输入好友邀请码（随便填）",
              hintStyle: TextStyle(color: Colors.black26),
            )));
  }
}



//IconButton
