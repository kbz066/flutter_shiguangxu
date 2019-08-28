import 'package:flustars/flustars.dart';
import 'package:flutter/material.dart';
import 'package:flutter_shiguangxu/common/Constant.dart';
import 'package:flutter_shiguangxu/common/WindowUtils.dart';
import 'package:flutter_shiguangxu/entity/sechedule_entity.dart';

class QuadrantBigPage extends StatefulWidget {
  final List<SecheduleData> list;
  final int index;

  QuadrantBigPage(this.list, this.index);

  @override
  _QuadrantBigPageState createState() => _QuadrantBigPageState();
}

class _QuadrantBigPageState extends State<QuadrantBigPage> {
  var levelIcon = [
    "icon_level_one.png",
    "icon_level_two.png",
    "icon_level_three.png",
    "icon_level_four.png"
  ];
  var levelTitle = ["主要且紧急", "主要不紧急", "紧急不重要", "不重要不紧急"];
  var levelColor = [0xffFF6274, 0xffFFA523, 0xff58C086, 0xff4BA9FF];
  @override
  Widget build(BuildContext context) {

    LogUtil.e("高度   ${WindowUtils.getHeight()-600}");
    return Material(
      color: Colors.transparent,
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: SafeArea(
          child: Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              height: WindowUtils.getHeightDP()-125,
              child:  Card(
                child: Column(
                  children: <Widget>[
                    Container(
                      color: Color(levelColor[widget.index]).withAlpha(50),
                      child: Row(
                        children: <Widget>[
                          SizedBox(width: 10),
                          Image.asset(
                              "assets/images/${levelIcon[widget.index]}"),
                          SizedBox(
                            width: 20,
                          ),
                          Expanded(
                            child: Text(
                              levelTitle[widget.index],
                              textAlign: TextAlign.left,
                              style: TextStyle(
                                  color: Color(levelColor[widget.index])),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Expanded(
                      child: _buildList(),
                    )
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  _buildList() {
    return widget.list.length == 0
        ? Container()
        : ListView.builder(
            padding: EdgeInsets.only(left: 5, top: 10),
            itemCount: widget.list.length,
            itemBuilder: (_, index) {
              return Container(
                decoration: BoxDecoration(
                    border: Border(bottom: BorderSide(color: Colors.black12))),
                padding: EdgeInsets.symmetric(vertical: 10),
                child: Row(
                  children: <Widget>[
                    Image.asset(
                      Constant.IMAGE_PATH + "icon_time_taskson.png",
                      width: 12,
                    ),
                    SizedBox(width: 10),
                    Text(widget.list[index].title),
                    SizedBox(width: 10),
                  ],
                ),
              );
            });
  }
}
