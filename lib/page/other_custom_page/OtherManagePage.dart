import 'package:common_utils/common_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_shiguangxu/common/ColorUtils.dart';
import 'package:flutter_shiguangxu/common/Constant.dart';
import 'package:flutter_shiguangxu/common/NavigatorUtils.dart';
import 'package:flutter_shiguangxu/dao/Other_DB.dart';
import 'package:flutter_shiguangxu/page/other_custom_page/presenter/OtherPresenter.dart';
import 'package:flutter_shiguangxu/widget/LoadingWidget.dart';
import 'package:flutter_shiguangxu/widget/ReorderableGridView.dart';
import 'package:provider/provider.dart';

import 'OtherAddPage.dart';
import 'model/OtherModel.dart';

class OtherManagePage extends StatefulWidget {
  @override
  State createState() => _OtherManagePageState();
}

class _OtherManagePageState extends State<OtherManagePage> {
  bool isEdit = false;

  bool showAdd = true;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("分类管理"),
        centerTitle: true,
        backgroundColor: ColorUtils.mainColor,
        actions: <Widget>[
          GestureDetector(
            onTapDown: (_) {
              print("点击；了  ${isEdit}");
              setState(() {
                this.isEdit = !isEdit;
                this.showAdd = !this.showAdd;
              });
            },
            child: Image.asset(
              Constant.IMAGE_PATH +
                  (isEdit
                      ? "icon_close_nav_white.png"
                      : "nav_icon_edit_bai.png"),
              width: 50,
            ),
          )
        ],
      ),
      backgroundColor:Colors.white ,
      body: SafeArea(
        child: _buildFutureBuilder(
            Provider.of<OtherPresenter>(context, listen: false)),
      ),
    );
  }

  _buildFutureBuilder(OtherPresenter _otherPresenter) {
    return FutureBuilder<List<Other_DB>>(
      future: _otherPresenter
          .getOtherListData(), // a previously-obtained Future<String> or null
      builder: (context, snap) {
        if (snap.connectionState == ConnectionState.done) {
          return _showListView(snap.data);
        } else {
          return LoadingWidget();
        }
      },
    );
  }

  _showListView(list) {
    return ReorderableGridView(
      delegate: new SliverGridDelegateWithFixedCrossAxisCount(
//      横轴数量 这里的横轴就是x轴 因为方向是垂直的时候 主轴是垂直的
          crossAxisCount: 3,
          childAspectRatio: 1 / 1.2),
      itemBuilder: (context, index) {
        return Container(
          color:Colors.white ,
          child: _gridItem(
              index == list.length ? null : list[index], index == list.length),
        );
      },
      showAdd: showAdd,
      datas: list,
    );
  }

  _gridItem(Other_DB data, bool isLast) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        SizedBox(
          height: 15,
        ),
        GestureDetector(
          onTapDown: (down) {
            if (isLast) {
              NavigatorUtils.push(context, OtherAddPage());
            }
          },
          child: isLast
              ? Container(
                  width: 60,
                  height: 60,
                  margin: EdgeInsets.only(bottom: 15),
                  decoration: BoxDecoration(
                      color: Color.fromARGB(10, 0, 0, 0),
                      borderRadius: BorderRadius.all(Radius.circular(30))),
                  child: Icon(
                    Icons.add,
                    color: Colors.black26,
                    size: 30,
                  ),
                )
              : data.isDBData != null && data.isDBData != 0
                  ? Container(
                      width: 60,
                      height: 60,
                      margin: EdgeInsets.only(bottom: 15),
                      decoration: BoxDecoration(
                          color: Color(data.bgColor),
                          borderRadius: BorderRadius.all(Radius.circular(30))),
                      child: Image.asset(
                        Constant.IMAGE_PATH + data.imageName,
                        width: 60,
                        fit: BoxFit.cover,
                      ),
                    )
                  : Image.asset(
                      Constant.IMAGE_PATH + data.imageName,
                      width: 60,
                      fit: BoxFit.cover,
                    ),
        ),
        SizedBox(
          height: 15,
        ),
        isLast
            ? Container()
            : Text(
                data.title,
                style: TextStyle(
                    fontSize: 14,
                    color: Colors.black,
                    fontWeight: FontWeight.w300,
                    decoration: TextDecoration.none),
              )
      ],
    );
  }
}
