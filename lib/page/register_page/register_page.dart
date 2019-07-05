import 'package:flutter/material.dart';



class RegisterPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        Align(
          alignment: Alignment.topCenter,
          child: Image.asset(
            "assets/images/login_bg.png",
            fit: BoxFit.cover,
          ),
        ),
        Align(
          alignment: Alignment(0, -0.2),
          child: Container(
            width: 320,
            height: 300,
            child: Card(
              elevation: 5,
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 20),
                child: Form(
                  child: Column(
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
                          onPressed: () {},
                          color: Colors.blue,
                          textColor: Colors.white,
                          shape: new RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(25)),
                        ),
                      ),

                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
        Align(
          alignment: Alignment(0, -0.7),
          child: Image.asset("assets/images/longmao_openeye.png"),
        ),
      ],
    );
  }
}

_buildPasswordWidget() {
  return Text("");
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
          child: TextFormField(
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
