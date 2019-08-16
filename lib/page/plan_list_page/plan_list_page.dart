import 'package:common_utils/common_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_shiguangxu/common/ColorUtils.dart';

import 'package:flutter_shiguangxu/common/Constant.dart';
import 'package:flutter_shiguangxu/common/NavigatorUtils.dart';
import 'package:flutter_shiguangxu/common/WindowUtils.dart';
import 'package:flutter_shiguangxu/entity/schedule_entity.dart';

import 'package:flutter_shiguangxu/page/plan_list_page/plan_details_page.dart';
import 'package:flutter_shiguangxu/page/schedule_page/presenter/SchedulePresenter.dart';
import 'package:flutter_shiguangxu/page/schedule_page/widget/TodayAddPlanDialog.dart';

import 'package:flutter_shiguangxu/widget/BottomPopupRoute.dart';
import 'package:flutter_shiguangxu/widget/BottomSheet.dart' as sgx;

import 'package:flutter_shiguangxu/widget/DragTargetListView.dart';
import 'package:provider/provider.dart';



class PlanListPage extends StatefulWidget {
  @override
  PlanListPageState createState() => new PlanListPageState();
}

class PlanListPageState extends State<PlanListPage>
    with AutomaticKeepAliveClientMixin, TickerProviderStateMixin {
  AnimationController _feedbackController;
  AnimationController _delController;
  AnimationController _buttonController;

  List<ScheduleData> dataList = [];

  @override
  void initState() {
    _delController =
        AnimationController(vsync: this, duration: Duration(milliseconds: 400));
    _buttonController =
        AnimationController(vsync: this, duration: Duration(milliseconds: 400));
    super.initState();

  }



  @override
  void dispose() {
    _delController.dispose();
    _buttonController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);

    LogUtil.e("打印      ----------------》");
    return Scaffold(
      resizeToAvoidBottomPadding: false,
      floatingActionButton: SlideTransition(
        position: Tween(begin: Offset(0, 0), end: Offset(2, 2))
            .animate(_buttonController),
        child: FloatingActionButton(
          heroTag: "plan",
          backgroundColor: ColorUtils.mainColor,
          onPressed: () => _showAddPlanDialog(),
          child: Icon(Icons.add),
        ),
      ),
      body: Container(
        padding: EdgeInsets.only(top: 20),
        decoration: BoxDecoration(
          color: Colors.blueAccent,
          image: DecorationImage(
            image: AssetImage("assets/images/background_img_detailed.png"),
            fit: BoxFit.cover,
          ),
        ),
        child: Container(
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
                    Consumer<SchedulePresenter>(
                      builder: (context, value, child) {
                        this.dataList = value.planList;
                        LogUtil.e("dataList         $dataList");
                        return Container(
                          width: double.infinity,
                          margin: EdgeInsets.symmetric(horizontal: 15),
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(10),
                                  topRight: Radius.circular(10))),
                          child: dataList == null || dataList.length == 0
                              ? showEmptyContent()
                              : _showListContent(),
                        );
                      },
                    ),
                    DragTarget<dynamic>(
                      builder: (BuildContext context,
                          List<dynamic> candidateData,
                          List<dynamic> rejectedData) {
                        return SlideTransition(
                          position:
                              Tween(begin: Offset(1, 1), end: Offset(0, 0))
                                  .animate(_delController),
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
                        return true;
                      },
                      onAccept: (data) {
                        setState(() {
                          _feedbackController.reverse();
                          Provider.of<SchedulePresenter>(context, listen: false)
                              .delSchedule(context, data.id);
                        });
                      },
                      onLeave: (data) {
                        _feedbackController.reverse();
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

  _showAddPlanDialog() {
    var contentKey = GlobalKey();

    Navigator.push(
        context,
        BottomPopupRoute(
          child: GestureDetector(
              onTapDown: (down) {
                if (down.globalPosition.dy <
                    WindowUtils.getHeightDP() -
                        contentKey.currentContext.size.height) {
                  Navigator.pop(context);
                }
              },
              child: TodayAddPlanDialog(
                contentKey,
                DateTime.now(),
                addScheduleCallback: (data) {
                  Provider.of<SchedulePresenter>(context, listen: false)
                      .addSchedule(data, context);
                },
              )),
        ));
  }

  _showListContent() {
    var leadingIcon = [
      "category_icon_work_def.png",
      "category_icon_thing_def.png",
      "category_icon_other_def.png",
      "category_icon_birthday_def.png",
      "category_icon_anniversary_def.png",
    ];

    return Container(
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(20), topRight: Radius.circular(10))),
      child: DragTargetListView(
        padding: EdgeInsets.only(left: 20, top: 10),
        itemBuilder: (BuildContext context, int index) {
          LogUtil.e("  ${dataList[index].id}");
          return Material(
            child: Container(
              color: Colors.white,
              child: Row(
                children: <Widget>[
                  Image.asset(
                      Constant.IMAGE_PATH + leadingIcon[dataList[index].type]),
                  SizedBox(width: 10),
                  Expanded(
                    child: Container(
                      padding: EdgeInsets.symmetric(vertical: 20),
                      decoration: BoxDecoration(
                          border: Border(
                              bottom: BorderSide(
                                  color: Colors.black12, width: 0.5))),
                      child: Text(dataList[index].title),
                    ),
                  )
                ],
              ),
            ),
          );
        },
        datas: dataList,
        feedbackChange: _feedbackChange,
        onDragStartedCallback: _onDragStartedCallback,
        onDragEndCallback: _onDragEndCallback,
        onItemCallback: _onItemCallback,
      ),
    );
  }

  _onItemCallback(index) {
    LogUtil.e("点击   ${index}");

    sgx.showModalBottomSheet(
            context: context,
            builder: (context) {
              return PlanDetailsPage(dataList[index]);
            },
            backgroundColor: Colors.transparent,
            ratio: 0.85)
        .whenComplete(() {
      Provider.of<SchedulePresenter>(context, listen: false)
          .updateSchedule(context, dataList[index]);
      LogUtil.e("页面销毁了   ${dataList[index]}");
    });
  }

  _onDragStartedCallback() {
    _delController.forward();
    _buttonController.forward();
  }

  _onDragEndCallback() {
    _delController.reverse();
    _buttonController.reverse();
  }

  _feedbackChange(AnimationController controller) {
    this._feedbackController = controller;
  }

  showEmptyContent() {
    return SingleChildScrollView(
      child: SizedBox(
        height: 500,
        child: Column(
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
        ),
      ),
    );
  }

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;
}
