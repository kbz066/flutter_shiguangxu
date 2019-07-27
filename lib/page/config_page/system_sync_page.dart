import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_shiguangxu/common/ColorUtils.dart';

class SystemSyncPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return  Material(
      child: Scaffold(
          appBar: AppBar(title:Text("系统同步") ,centerTitle: true,backgroundColor: ColorUtils.mainColor,),

          body: SafeArea(
            child: Container(
              color: Colors.white,
              height: 50,
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text("同步系统日历"),
                  Image.asset("assets/images/icon_open.png")
                ],
              ),
            ),
          )),
    );
  }
}
