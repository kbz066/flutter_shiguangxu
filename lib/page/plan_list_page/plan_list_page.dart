import 'package:common_utils/common_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_shiguangxu/common/ColorUtils.dart';
import 'package:flutter_shiguangxu/common/Constant.dart';
import 'package:flutter_shiguangxu/widget/DragTargetListView.dart';

class PlanListPage extends StatefulWidget {
  @override
  PlanListPageState createState() => new PlanListPageState();
}

class PlanListPageState extends State<PlanListPage>
    with AutomaticKeepAliveClientMixin, SingleTickerProviderStateMixin{
  AnimationController _feedbackController;
  AnimationController _delController;
  var datas = [
    "java",
    "c++",
    "dart",
    "flutter",
    "js",
  ];

  @override
  void initState() {
    _delController=AnimationController(vsync: this,duration: Duration(milliseconds:400));
    super.initState();
  }


  @override
  void dispose() {
    _delController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Scaffold(
//      floatingActionButton: FloatingActionButton(
//        backgroundColor: ColorUtils.mainColor,
//        onPressed: () {
//
//        },
//        child: Icon(Icons.add),
//      ),
      body: Container(
        decoration: BoxDecoration(
          color: Colors.blueAccent,
          image: DecorationImage(
            image: AssetImage("assets/images/background_img_detailed.png"),
            fit: BoxFit.cover,
          ),
        ),
        child: Container(
          padding: EdgeInsets.only(top: 20),
          child: Column(
            children: <Widget>[
              Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      SizedBox(
                        width: 60,
                        child: Row(
                          children: <Widget>[
                            Text(
                              "全部",
                              style: TextStyle(
                                  fontSize: 18, color: Colors.white70),
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            SizedBox(
                              width: 6,
                              child: Image.asset(
                                "assets/images/icon_back_right_white_def.png",
                                color: Colors.white70,
                              ),
                            )
                          ],
                        ),
                      ),
                      Text(
                        "0/0",
                        style: TextStyle(color: Colors.white70),
                      )
                    ],
                  )),
              SizedBox(
                height: 20,
              ),
              Expanded(
                child: Stack(
                  alignment: Alignment.bottomRight,
                  children: <Widget>[
                    _showListContent(),
                    DragTarget<dynamic>(
                      builder: (BuildContext context,
                          List<dynamic> candidateData,
                          List<dynamic> rejectedData) {
                        return SlideTransition(

                          position: Tween(begin: Offset(1,1),end: Offset(0,0)).animate(_delController),
                          child: Container(
                              padding: EdgeInsets.only(left: 40, top: 30),
                              decoration: BoxDecoration(
                                  color: Colors.red,
                                  borderRadius: BorderRadius.only(
                                      topLeft: Radius.circular(140))),
                              width: 140,
                              height: 150,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[
                                  Image.asset(
                                    Constant.IMAGE_PATH +
                                        "btn_sc_pressed_white.png",
                                    height: 30,
                                    fit: BoxFit.cover,
                                  ),
                                  Text("拖至此处删除",
                                      style: TextStyle(
                                          fontSize: 10, color: Colors.white)),
                                ],
                              )),
                        );
                      },
                      onWillAccept: (data) {
                        _feedbackController.forward();

                        LogUtil.e("触发删除 --------------------》");
                        return true;
                      },
                      onAccept: (data) {
                        setState(() {
                          datas.remove(data);
                          _feedbackController.reverse();
                        });
                        LogUtil.e("触发删除 ---------onAccept-----------》");
                      },
                      onLeave: (data) {
                        _feedbackController.reverse();
                        LogUtil.e("触发删除 ---------onLeave-----------》");
                      },
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  _showListContent() {
    var leadingIcon = [
      "category_icon_birthday_def.png",
      "category_icon_other_def.png",
      "category_icon_anniversary_def.png",
      "category_icon_thing_def.png",
      "category_icon_birthday_def.png",
      "category_icon_birthday_def.png",
      "category_icon_birthday_def.png",
      "category_icon_birthday_def.png"
    ];


    return Container(
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(20), topRight: Radius.circular(10))),
      margin: EdgeInsets.symmetric(horizontal: 20),
      child: DragTargetListView(
        padding: EdgeInsets.only(left: 20, top: 10),
        itemBuilder: (BuildContext context, int index) {
          return Material(
            child: Container(
              color: Colors.white,
              child: Row(
                children: <Widget>[
                  Image.asset(Constant.IMAGE_PATH + leadingIcon[0]),
                  SizedBox(width: 10),
                  Expanded(
                    child: Container(
                      padding: EdgeInsets.symmetric(vertical: 20),
                      decoration: BoxDecoration(
                          border: Border(
                              bottom: BorderSide(
                                  color: Colors.black12, width: 0.5))),
                      child: Text(datas[index]),
                    ),
                  )
                ],
              ),
            ),
          );
        },
        datas: datas,
        feedbackChange: _feedbackChange,
        onDragStartedCallback: _onDragStartedCallback,
        onDragEndCallback: _onDragEndCallback,
      ),
    );
  }

  _onDragStartedCallback() {
    _delController.forward();
  }
  _onDragEndCallback() {
    LogUtil.e("_onDragEndCallback------------------>");
    _delController.reverse();
  }

  _feedbackChange(AnimationController controller) {
    this._feedbackController = controller;
  }

  showEmptyContent() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Image.asset("assets/images/today_empty.png"),
        SizedBox(
          height: 20,
        ),
        Text(
          "还没有清单安排吖！",
          style: TextStyle(color: Colors.black, fontSize: 16),
        ),
        Text(
          "未来可期，提前做好安排",
          style: TextStyle(color: Colors.black26, fontSize: 14),
        )
      ],
    );
  }

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;
}
