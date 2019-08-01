import 'package:common_utils/common_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_shiguangxu/common/ColorUtils.dart';
import 'package:flutter_shiguangxu/common/Constant.dart';
import 'package:flutter_shiguangxu/dao/Other_DB.dart';
import 'package:flutter_shiguangxu/page/other_custom_page/presenter/OtherPresenter.dart';
import 'package:flutter_shiguangxu/widget/LoadingWidget.dart';
import 'package:provider/provider.dart';

import 'model/OtherModel.dart';

class OtherManagePage extends StatefulWidget {
  @override
  State createState() => _OtherManagePageState();
}

class _OtherManagePageState extends State<OtherManagePage> {
  bool isEdit = false;

  @override
  void initState() {
    super.initState();

    OtherModel().getOtherListData();
  }

  @override
  Widget build(BuildContext context) {


    var _otherPresenter = Provider.of<OtherPresenter>(context, listen: false);
    return MaterialApp(
      home: Scaffold(
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
        body: SafeArea(
            child: FutureProvider<List<Other_DB>>(
          builder: (content) => _otherPresenter.getOtherListData(),
          child: Consumer<List<Other_DB>>(builder:
              (BuildContext context, List<Other_DB> list, Widget child) {
            return list == null ? LoadingWidget() : _showListView(list);
          }),
        )),
      ),
    );
  }



  _showListView(list) {

    return GridView.custom(
      gridDelegate: new SliverGridDelegateWithFixedCrossAxisCount(
//      横轴数量 这里的横轴就是x轴 因为方向是垂直的时候 主轴是垂直的
          crossAxisCount: 3,
          childAspectRatio: 1 / 1.2),
      childrenDelegate: new SliverChildBuilderDelegate(
        (context, index) {
          return Container(
            child: _gridItem(index == list.length ? null : list[index],
                index == list.length),
          );
        },
        childCount: list.length + 1,
      ),
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
        isLast
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
            : Image.asset(
                Constant.IMAGE_PATH + data.imageName,
                width: 60,
                fit: BoxFit.cover,
              ),
        SizedBox(
          height: 15,
        ),
        isLast ? Container() : Text(data.title)
      ],
    );
  }
}
