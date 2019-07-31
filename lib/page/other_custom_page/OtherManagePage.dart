import 'package:common_utils/common_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_shiguangxu/common/ColorUtils.dart';
import 'package:flutter_shiguangxu/common/Constant.dart';

class OtherManagePage extends StatefulWidget {
  @override
  State createState() => new _OtherManagePageState();
}

class _OtherManagePageState extends State<OtherManagePage> {
  bool isEdit = false;

  @override
  Widget build(BuildContext context) {
    var list = Constant.OTHER_DATA;
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
              child: Image.asset(Constant.IMAGE_PATH +
                  (isEdit
                      ? "icon_close_nav_white.png"
                      : "nav_icon_edit_bai.png"),width: 50,),
            )
          ],
        ),
        body: SafeArea(
            child: GridView.custom(
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
        )),
      ),
    );
  }

  _gridItem(Map map, bool isLast) {
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
                Constant.IMAGE_PATH + map.keys.first,
                width: 60,
                fit: BoxFit.cover,
              ),
        SizedBox(
          height: 15,
        ),
        isLast ? Container() : Text(map.values.first)
      ],
    );
  }
}
