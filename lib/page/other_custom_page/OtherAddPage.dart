import 'package:flutter/material.dart';
import 'package:flutter_shiguangxu/common/ColorUtils.dart';

class OtherAddPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("添加分类"),
        centerTitle: true,
        backgroundColor: ColorUtils.mainColor,
      ),
      body: SafeArea(
          child: Column(
        children: <Widget>[
          Row(
            children: <Widget>[
              Text("名称"),
              Expanded(
                child: TextField(
                  decoration: InputDecoration(hintText: "请填写分类名称"),
                ),
              )
            ],
          )
        ],
      )),
    );
  }
}
