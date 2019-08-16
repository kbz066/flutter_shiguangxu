import 'package:common_utils/common_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_calendar/model/date_model.dart';
import 'package:flutter_calendar/utils/date_util.dart' as prefix0;
import 'package:flutter_shiguangxu/base/BaseView.dart';
import 'package:flutter_shiguangxu/common/Constant.dart';
import 'package:flutter_shiguangxu/common/WindowUtils.dart';
import 'package:flutter_shiguangxu/entity/schedule_entity.dart';
import 'package:flutter_shiguangxu/page/schedule_page/model/DialogStateModel.dart';
import 'package:flutter_shiguangxu/page/schedule_page/model/TodayStateModel.dart';


import 'package:flutter_shiguangxu/widget/InkWellImageWidget.dart';
import 'package:provider/provider.dart';

import 'TodayTimeDialog.dart';

class TodayAddPlanDialog extends BaseView {
  GlobalKey contentKey;
  var typeIcon;
  var levelIcon;
  var labels;
  Function addScheduleCallback;

  DateTime currentTime;
  TodayAddPlanDialog(this.contentKey, this.currentTime,{this.addScheduleCallback}) {
    typeIcon = [
      "search_class_icon_work",
      "search_class_icon_learn",
      "search_class_icon_default",
      "search_class_icon_health",
      "search_class_icon_anniversary"
    ];

    levelIcon = [
      "icon_red_level",
      "icon_yellow_level",
      "icon_green_level",
      "icon_blue_level",
    ];
    labels = ["今天", "明天", "后天", "大后天", "下周"].map((item) {
      return Container(
        width: item.length * 25.toDouble(),
        height: 30,
        alignment: Alignment.center,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(25)),
            color: Colors.white),
        child: Text(
          "$item",
          style: TextStyle(),
        ),
      );
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    bool isNowDay = DateUtil.isToday(currentTime.millisecondsSinceEpoch);

    return
      Scaffold(

      backgroundColor: Colors.black12,
      body:
      ChangeNotifierProvider(
        builder: (context) => isNowDay
            ? TodayStateModel()
            : (TodayStateModel()
              ..setSelectDate(
                  true,
                  DialogPageModel()
                    ..setSelectDate(DateModel.fromDateTime(currentTime)),
                  0,
                  isNotifyListeners: false)),
        child: Align(
          alignment: Alignment.bottomCenter,
          child:
          Column(
            key: contentKey,
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Consumer<TodayStateModel>(
                builder: (context, model, child) {
                  LogUtil.e("model.dateTips     ${model.dateTips}");
                  return model.dateTips == null
                      ? Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: labels,
                  )
                      : Container(
                    height: 30,
                    margin: EdgeInsets.only(left: 20),
                    decoration: BoxDecoration(
                        borderRadius:
                        BorderRadius.all(Radius.circular(25)),
                        color: Colors.white),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        SizedBox(
                          width: 20,
                        ),
                        Text(model.dateTips),
                        IconButton(
                          padding: EdgeInsets.all(0),
                          icon: Icon(
                            Icons.clear,
                            color: Colors.black26,
                            size: 18,
                          ),
                          onPressed: () {
                            model.setSelectDate(false, null, 0);
                          },
                        )
                      ],
                    ),
                  );
                },
              ),
              SizedBox(
                height: 10,
              ),
              Container(
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(10),
                        topRight: Radius.circular(10))),
                child: Column(
                  children: <Widget>[
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 20),
                      child: Row(
                        children: <Widget>[
                          Expanded(
                            child: TextField(
                              decoration: InputDecoration(
                                border: InputBorder.none,
                                hintText: "写点什么,吧事情记录下来....",
                                hintStyle: TextStyle(color: Colors.black26),
                              ),
                              onChanged: (value) {
                                var state = Provider.of<TodayStateModel>(
                                    contentKey.currentContext,
                                    listen: false);

                                state.updateContent(value == "" ? null : value);
                              },
                            ),
                          ),
                          Consumer<TodayStateModel>(
                            builder: (context, model, child) {
                              LogUtil.e(
                                  "TodayStateModel   build    content  -------------> ${model.content}");
                              return Container(
                                child: InkWellImageWidget(
                                    model.content == null ||
                                        model.content.isEmpty
                                        ? "icon_add_voice_nor"
                                        : "icon_add_sent_nor",
                                        () =>_addScheduleData(context)),
                              );
                            },
                          )
                        ],
                      ),
                    ),
                    Container(
                      padding:
                      EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                      color: Color.fromARGB(255, 250, 250, 250),
                      child: Row(
                        children: <Widget>[
                          Consumer<TodayStateModel>(
                            builder: (context, model, child) {
                              LogUtil.e(
                                  "TodayStateModel   build      ------------->");
                              return Container(
                                child: InkWellImageWidget(
                                    model.selectDate
                                        ? "icon_add_time_pre"
                                        : "plant_icon_time", () {
                                  _showTimeDialog(contentKey.currentContext);
                                }),
                              );
                            },
                          ),

                          SizedBox(
                            width: 30,
                          ),

                          Consumer<TodayStateModel>(
                            builder: (_context, model, child) {
                              LogUtil.e(
                                  "TodayStateModel   build      ------------->");
                              return Container(
                                child: InkWellImageWidget(

                                    model.updateTypeIcon
                                        ? typeIcon[model.selectTypeIndex]
                                        : "icon_add_category_nor", () {
                                  FocusScope.of(context).requestFocus(FocusNode());
                                  Provider.of<TodayStateModel>(
                                      contentKey.currentContext,
                                      listen: false)
                                      .setShowTypeView();

                                }),
                              );
                            },
                          ),

                          SizedBox(
                            width: 30,
                          ),

                          Consumer<TodayStateModel>(
                            builder: (context, model, child) {
                              LogUtil.e(
                                  "TodayStateModel   build      ------------->");
                              return Container(
                                child: InkWellImageWidget(
                                    model.updateLeveleIcon
                                        ? levelIcon[model.selectLevelIndex]
                                        : "icon_add_important_nor", () {
                                  FocusScope.of(context).requestFocus(FocusNode());
                                  Provider.of<TodayStateModel>(
                                      contentKey.currentContext,
                                      listen: false)
                                      .setShowLevelView();
                                }),
                              );
                            },
                          ),

                          //
                        ],
                      ),
                    ),
                    Consumer<TodayStateModel>(
                      builder: (context, model, child) {
                        LogUtil.e(
                            "TodayStateModel   build      ------------->");
                        return Container(
                          height: model.showType || model.showLevel ? 290 : 0,
                          child: model.showType
                              ? _showTypeView(model)
                              : _showLevelView(model),
                        );
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

  _addScheduleData(BuildContext context){
    var state = Provider.of<TodayStateModel>(contentKey.currentContext, listen: false);
    ScheduleData data=ScheduleData();
    data.title=state.content;
    data.level=state.selectLevelIndex;
    data.type=state.selectTypeIndex;
    data.state=0;


    if(state.dateTips!=null){

      data.year=int.parse(state.dateTips.substring(0,4)) ;
      data.month= int.parse(state.dateTips.substring(state.dateTips.indexOf("年")+1,state.dateTips.indexOf("月")));
      data.day=  int.parse(state.dateTips.substring(state.dateTips.indexOf("月")+1,state.dateTips.indexOf("日")));
      LogUtil.e("${data.year}    ${data.month}  ${data.day}");
    }
    Navigator.pop(context);
      if(addScheduleCallback!=null)
     addScheduleCallback(data);


  }
  _showLevelView(TodayStateModel model) {
    var levelIcon = [
      "icon_level_one.png",
      "icon_level_two.png",
      "icon_level_three.png",
      "icon_level_four.png"
    ];
    var levelTitle = ["主要且紧急", "主要不紧急", "紧急不重要", "不重要不紧急"];
    var levelColor = [0xffFF6274, 0xffFFA523, 0xff58C086, 0xff4BA9FF];

    return ListView.separated(
      itemCount: 4,
      itemBuilder: (BuildContext context, int index) {
        return GestureDetector(
          onTapUp: (details) {
            model.setSelectLevelIndex(index);
          },
          child: Container(
            padding: EdgeInsets.only(left: 20, right: 20),
            height: 50,
            child: Row(
              children: <Widget>[
                Image.asset("assets/images/${levelIcon[index]}"),
                SizedBox(
                  width: 20,
                ),
                Expanded(
                  child: Text(
                    levelTitle[index],
                    textAlign: TextAlign.left,
                    style: TextStyle(color: Color(levelColor[index])),
                  ),
                ),
                model.selectLevelIndex == index
                    ? Image.asset("assets/images/icon_select_bell.png")
                    : Container(),
              ],
            ),
          ),
        );
      },
      separatorBuilder: (BuildContext context, int index) => Divider(),
    );
  }

  _showTypeView(TodayStateModel model) {
    LogUtil.e(" model    $model");
    var _gridIcon = [
      "class_icon_work2.png",
      "class_icon_learn2.png",
      "class_icon_default2.png",
      "class_icon_health2.png",
      "class_icon_yule2.png"
    ];
    var _gridTxt = ["工作", "学习", "私事", "健康", "娱乐"];

    var _gridChildren = _gridIcon.map((item) {
      var index = _gridIcon.indexOf(item);

      return GestureDetector(
        onTapUp: (details) {
          model.setSelectTypeIndex(index);
        },
        child: Container(
          decoration: BoxDecoration(
              border: Border(
                  right: BorderSide(
                      color: Colors.black12,
                      width: 1.0,
                      style: BorderStyle.solid),
                  bottom: BorderSide(
                      color: index == _gridIcon.length - 1
                          ? Colors.white
                          : Colors.black12,
                      width: 1.0,
                      style: BorderStyle.solid))),
          child: Stack(
            children: <Widget>[
              Align(
                child: Image.asset("assets/images/$item"),
                alignment: Alignment.center,
              ),
              model.selectTypeIndex == index
                  ? Align(
                      child: Image.asset("assets/images/add_icon_hook.png"),
                      alignment: Alignment(0.4, -0.3),
                    )
                  : Container(),
              Align(
                alignment: Alignment(0, 0.6),
                child: Text("${_gridTxt[index]}"),
              )
            ],
          ),
        ),
      );
    }).toList();
    return GridView.count(

      crossAxisCount: 4,
      childAspectRatio: 1 / 1.6,
      padding: EdgeInsets.all(0),
      children: _gridChildren,
    );
  }

  _showTimeDialog(BuildContext currentContext) {
    showDialog(
      context: currentContext,
      builder: (ctx) {
        LogUtil.e("顶级    bulid     --------->  $contentKey");
        return TodayTimeDialog(contentKey.currentContext);
      },
    );
  }
}
