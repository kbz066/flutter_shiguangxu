import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart' hide Action;

class RegisterPage extends StatefulWidget {
  @override
  State createState() => RegisterPageState();
}

class RegisterPageState extends State<RegisterPage> {
  bool _isSHowPassWord;

  bool _isChekAgreement;

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

  @override
  Widget build(BuildContext context) {
    return
      Container(

        child: ListView(
          children: <Widget>[
            Container(

              child:
              Stack(

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


                    alignment: FractionalOffset.bottomCenter,
                    child: Container(
                      width: 320,
                      height: 420,
                      margin: EdgeInsets.only(top: 120),
                      child: Card(
                        child: Padding(
                          padding: EdgeInsets.symmetric(horizontal: 20),
                          child: Form(
                              child: Stack(
                                overflow: Overflow.visible,
                                children: <Widget>[
                                  Column(
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
                                                  style:
                                                  TextStyle(color: Colors.black)),
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
                                          child: Text("登录"),
                                          onPressed: () {},
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
                                    child: Image.asset(
                                        "assets/images/longmao_openeye.png"),
                                  )
                                ],
                              )),
                        ),
                      ),
                    ),
                  ),

                  Container(
                    padding: EdgeInsets.only(left: 20,top: 10),
                    child:  Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Icon(
                          Icons.arrow_back_ios,
                          color: Colors.white70,
                          size: 20,
                        ),
                        Text(
                          "注册",
                          style: TextStyle(color: Colors.white70, fontSize: 18),
                        ),
                        Text(
                          "",
                          style: TextStyle(color: Colors.white70, fontSize: 18),
                        )
                      ],
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      );
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
          child: TextFormField(
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
                hintText: "请输入验证码",
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
      child: TextFormField(
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
      child: TextFormField(
          decoration: InputDecoration(
        border: InputBorder.none,
        hintText: "请输入好友邀请码（选填）",
        hintStyle: TextStyle(color: Colors.black26),
      )));
}

//IconButton
