import 'package:common_utils/common_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_shiguangxu/common/Constant.dart';
import 'package:flutter_shiguangxu/common/WindowUtils.dart';
import 'package:flutter_shiguangxu/entity/sechedule_entity.dart';


import 'package:flutter_shiguangxu/widget/BottomPopupRoute.dart';
import 'package:flutter_shiguangxu/widget/InkWellImageWidget.dart';

class ScheduleDetailsPage extends StatefulWidget {
  final SecheduleData data;


  ScheduleDetailsPage(this.data );

  @override
  _ScheduleDetailsPageState createState() => _ScheduleDetailsPageState();
}

class _ScheduleDetailsPageState extends State<ScheduleDetailsPage> {
  var icons = [
    "bg_work_edit_task",
    "bg_study_edit_task",
    "bg_sishi_edit_task",
    "bg_health_edit_task",
    "bg_yule_edit_task"
  ];

  var levelIcon = [
    "icon_level_one.png",
    "icon_level_two.png",
    "icon_level_three.png",
    "icon_level_four.png"
  ];
  var levelTitle = ["主要且紧急", "主要不紧急", "紧急不重要", "不重要不紧急"];
  var typeTitle = ["工作", "学习", "私事", "健康", "娱乐"];
  var levelColor = [0xffFF6274, 0xffFFA523, 0xff58C086, 0xff4BA9FF];
  var colors = [0xffF4691A, 0xffFA9515, 0xffF44ABC, 0xff128496, 0xff0DA775];

  @override
  Widget build(BuildContext context) {


    return Material(
      borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20), topRight: Radius.circular(20)),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: SingleChildScrollView(
          child: Container(
            child: Column(
              children: <Widget>[
                ClipRRect(
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(20),
                      topRight: Radius.circular(20)),
                  child: InkWellImageWidget(
                      icons[widget.data.type], () => _showTypeDialog()),
                ),
                Row(
                  children: <Widget>[
                    Container(
                      color:
                          Color(levelColor[widget.data.level]).withAlpha(100),
                      height: 50,
                      width: 50,
                      child: Image.asset(
                          Constant.IMAGE_PATH + levelIcon[widget.data.level]),
                    ),
                    Expanded(
                      child: Padding(
                        padding: EdgeInsets.only(left: 10),
                        child: TextField(controller: TextEditingController(text: widget.data.title),decoration: InputDecoration(border: InputBorder.none),onChanged: (value){
                          widget.data.title=value;
                        },),
                      ),
                    ),
                    Image.asset(
                      Constant.IMAGE_PATH + "icon_task_add_mr.png",
                      height: 20,
                      fit: BoxFit.cover,
                    ),
                    SizedBox(width: 10)
                  ],
                ),
                Divider(
                  height: 1,
                  color: Colors.black12,
                  indent: 0,
                ),
                TextField(decoration: InputDecoration(hintText: "备注",border: InputBorder.none,contentPadding: EdgeInsets.only(left: 20,top: 20)),)
              ],
            ),
          ),
        ),
      ),
    );
  }

  _showTypeDialog() {
    Navigator.push(
        context,
        BottomPopupRoute(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: <Widget>[
                SizedBox(height: 50),
                Container(
                  width: 50,
                  height: 50,
                  margin: EdgeInsets.only(right: 20),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(25)),
                      color: Colors.black),
                  child: Image.asset(
                      Constant.IMAGE_PATH + "icon_flgl_edittask_pre.png"),
                ),
                SizedBox(height: 80),
                GridView.builder(
                  shrinkWrap: true,
                  padding: EdgeInsets.all(20),
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      childAspectRatio: 2,
                      crossAxisSpacing: 10,
                      mainAxisSpacing: 30),
                  itemBuilder: (BuildContext context, int index) {
                    return Material(
                        child: GestureDetector(
                      onTapDown: (down) {
                        setState(() {
                          widget.data.type = index;
                          Navigator.pop(context);
                        });
                      },
                      child: Stack(
                        overflow: Overflow.visible,
                        fit: StackFit.expand,
                        children: <Widget>[
                          Image.asset(
                              Constant.IMAGE_PATH + "${icons[index]}.png",
                              fit: BoxFit.cover),
                          Align(
                            alignment: Alignment.bottomCenter,
                            child: Container(
                              alignment: Alignment.center,
                              width: double.infinity,
                              color: Colors.black38,
                              height: 30,
                              padding: EdgeInsets.only(bottom: 5),
                              child: Text(
                                typeTitle[index],
                                style: TextStyle(
                                    fontSize: 16, color: Colors.white),
                              ),
                            ),
                          ),
                          Positioned(
                            top: -10,
                            right: -10,
                            child: Offstage(
                              offstage:
                                  widget.data.type == index ? false : true,
                              child: Image.asset(
                                Constant.IMAGE_PATH + "icon_sishi_pre.png",
                                height: 20,
                                fit: BoxFit.cover,
                                color: Colors.red,
                              ),
                            ),
                          )
                        ],
                      ),
                    ));
                  },
                  itemCount: icons.length,
                )
              ],
            ),
            bgColor: Colors.black26));
  }


}
