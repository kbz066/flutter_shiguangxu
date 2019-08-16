
import 'package:common_utils/common_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_calendar/controller.dart';
import 'package:flutter_calendar/model/date_model.dart';
import 'package:flutter_calendar/widget/base_day_view.dart';
import 'package:flutter_calendar/widget/base_week_bar.dart';
import 'package:flutter_calendar/widget/calendar_view.dart';
import 'package:flutter_shiguangxu/base/BaseStateView.dart';
import 'package:flutter_shiguangxu/base/BaseView.dart';
import 'package:flutter_shiguangxu/common/ColorUtils.dart';
import 'package:flutter_shiguangxu/common/WindowUtils.dart';
import 'package:flutter_shiguangxu/page/schedule_page/model/DialogStateModel.dart';
import 'package:flutter_shiguangxu/page/schedule_page/model/TodayStateModel.dart';

import 'package:flutter_shiguangxu/widget/InkWellImageWidget.dart';
import 'package:flutter_shiguangxu/widget/NumberPicker.dart';
import 'package:flutter_shiguangxu/widget/TextPagerIndexBar.dart'hide TabBarView;
import 'package:provider/provider.dart';

class TodayTimeDialog extends BaseStateView{



  BuildContext _parentContext;


  TodayTimeDialog(this._parentContext) : super(mixinType:MixinType.ordinary);

  @override
  Widget buildWidget(BuildContext context,State state) {
    // TODO: implement build
    return Scaffold(
      resizeToAvoidBottomPadding: false,
      backgroundColor: Colors.black12,
      body: MultiProvider(
        providers: [
          ChangeNotifierProvider(builder: (context) => DialogPageModel()),
          ChangeNotifierProvider(builder: (context) => DialogTipsModel()),
        ],
        child:
        Center(
          child: Container(
            width: WindowUtils.getWidthDP() * 0.9,
            height: WindowUtils.getHeightDP() * 0.65,

            decoration: BoxDecoration(
              color: Colors.white, // 底色

              borderRadius: BorderRadius.circular((15.0)), // 圆角度
            ), //
            child: Consumer<DialogPageModel>(
              builder: (context, model, child) {
                LogUtil.e(
                    "Consumer  打印 build 了  ---DialogPageModel------>  $context");

                return model.showCalendar
                    ? _calendarPage(context)
                    : _contentPage(context, _parentContext,state);
              },
            ),
          ),
        ),
      ),
    );
  }

  _saveTimeDate(BuildContext context, BuildContext currentContext, int index) {
    var pageModel = Provider.of<DialogPageModel>(context, listen: false);

    Provider.of<TodayStateModel>(currentContext, listen: false)
        .setSelectDate(true, pageModel, index);
    Navigator.pop(context);
  }

  _calendarPage(context) {
    var _provider = Provider.of<DialogPageModel>(context, listen: false);

    var controller = new CalendarController(
      weekBarItemWidgetBuilder: () {
        return CustomStyleWeekBarItem();
      },
      dayWidgetBuilder: (dateModel) {
        return CustomStyleDayWidget(dateModel);
      },
      selectDateModel: DateModel()
        ..year = _provider.selectDate.year
        ..month = _provider.selectDate.month
        ..day = _provider.selectDate.day,
    );
    var text = "${_provider.year}年${_provider.month}月";

    controller.addOnCalendarSelectListener((dateModel) {
      Provider.of<DialogPageModel>(context, listen: false).setSelectDate (dateModel);
    });

    controller.addMonthChangeListener((int year, int month) {
      Provider.of<DialogPageModel>(context, listen: false).setDate(year, month);
    });

    return Column(
      children: <Widget>[
        new Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            IconButton(
                icon: Icon(Icons.navigate_before),
                onPressed: () {
                  controller.moveToPreviousMonth();
                }),
            Text(text),
            IconButton(
                icon: Icon(Icons.navigate_next),
                onPressed: () {
                  controller.moveToNextMonth();
                }),
          ],
        ),
        Expanded(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 20),
            child: CalendarViewWidget(
              calendarController: controller,
            ),
          ),
        )
      ],
    );
  }

  _contentPage(context, BuildContext currentContext, State<StatefulWidget> state) {
    var tabs = ["时间点", "时间段", "全天"];
    var _tabController = TabController(
        length: 3,
        vsync: state as TickerProvider,
        initialIndex:
        Provider.of<DialogPageModel>(context, listen: false).initialIndex);

    _tabController.addListener(() {
      Provider.of<DialogPageModel>(context, listen: false)
          .setInitialIndex(_tabController.index);
    });

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        Container(
          height: 34,
          width: 250,
          margin: EdgeInsets.only(top: 20),
          decoration: BoxDecoration(
              border: Border.all(color: Color(0xffdddddd)), // 边色与边宽度

              //        borderRadius: new BorderRadius.circular((20.0)), // 圆角度
              borderRadius:
              BorderRadius.all(Radius.circular(17))), // 也可控件一边圆角大小
          child: TextPagerIndexBar(
            indicatorWeight: 10,
            circular: 15,
            unselectedLabelColor: Color(0xffdddddd),
            indicatorColor: Color(0xff6495ED),
            indicatorPadding: EdgeInsets.all(50),
            controller: _tabController,
            tabs: tabs.map((item) {
              return Text(item);
            }).toList(),
          ),
        ),
        SizedBox(height: 30),
        Expanded(
          child: TabBarView(
            controller: _tabController,
            children: <Widget>[
              _timePointPage(context),
              _timeDistancePage(context),
              _timeAllpage(context),
            ],
          ),
        ),
        Container(
          height: 50,
          decoration: BoxDecoration(
            //        borderRadius: new BorderRadius.circular((20.0)), // 圆角度
            border: Border(top: BorderSide(color: Colors.black12, width: 1)),
          ),
          child: Row(
            children: <Widget>[
              Expanded(
                child: FlatButton(
                  onPressed: () {
                    Provider.of<DialogPageModel>(context, listen: false)
                        .setShowCalendar(true);
                  },
                  padding: EdgeInsets.all(0),
                  child: Text("修改日期",
                      style: TextStyle(color: Colors.blue, fontSize: 16)),
                ),
              ),
              Container(
                color: Colors.black12,
                width: 1,
                height: 50,
              ),
              Expanded(child: Consumer<DialogTipsModel>(
                builder: (contexts, model, child) {
                  LogUtil.e(
                      "Consumer  打印 build 了  -保存-------->  ${model.disabled}");

                  return FlatButton(
                    onPressed: model.disabled
                        ? null
                        : () => _saveTimeDate(
                        context, currentContext, _tabController.index),
                    disabledTextColor: Colors.black12,
                    child: Text("保存",
                        style: TextStyle(
                            color: model.disabled ? null : Colors.blue,
                            fontSize: 16)),
                  );
                },
              ))
            ],
          ),
        )
      ],
    );
  }
  _timePointPage(context) {
    var _model = Provider.of<DialogPageModel>(context, listen: false);

    LogUtil.e("_timePointPage           ${_model.initTimePoint}");

    return Column(
      children: <Widget>[
        Expanded(
          child: Column(
            children: <Widget>[
              Consumer<DialogPageModel>(
                builder: (context, model, child) {
                  LogUtil.e("  _timePointPage  Consumer");
                  return Container(
                    width: 150,
                    height: 30,
                    decoration: BoxDecoration(
                        color: Color.fromARGB(10, 0, 0, 0),
                        borderRadius: BorderRadius.all(Radius.circular(75))),
                    child: FlatButton(
                      child: Text(
                        "${model.timeTxt}",
                        style: TextStyle(color: Colors.blue),
                      ),
                      onPressed: () => this._onDatePressed(context),
                    ),
                  );
                },
              ),
              Picker(
                itemExtent: 40,
                height: 200,
                looping: true,
                selecteds: _model.initTimePoint,
                adapter: NumberPickerAdapter(data: [
                  NumberPickerColumn(begin: 0, end: 0),
                  NumberPickerColumn(begin: 0, end: 23),
                  NumberPickerColumn(begin: 0, end: 55, jump: 5),
                  NumberPickerColumn(begin: 0, end: 0),
                ]),
                hideHeader: true,
                title: Text("Please Select"),
                selectedTextStyle: TextStyle(color: Colors.blue, fontSize: 30),
              ).makePicker(),
            ],
          ),
        ),
      ],
    );
  }

  _timeDistancePage(context) {
    var startPicker;
    var endPicker;
    var _model = Provider.of<DialogPageModel>(context, listen: false);

    startPicker = Picker(
        itemExtent: 40,
        height: 200,
        looping: true,
        selecteds: _model.initTimeDistanceStart,
        adapter: NumberPickerAdapter(data: [
          NumberPickerColumn(begin: 0, end: 0),
          NumberPickerColumn(begin: 0, end: 23),
          NumberPickerColumn(begin: 0, end: 55, jump: 5),
        ]),
        hideHeader: true,
        selectedTextStyle: TextStyle(color: Colors.blue, fontSize: 25),
        onConfirm: (Picker picker, List value) {},
        onSelect: (Picker picker, int index, List<int> selecteds) {
          Provider.of<DialogTipsModel>(context, listen: false).updateTips(
              picker.getSelectedValues(), endPicker.getSelectedValues());
        });

    endPicker = Picker(
      itemExtent: 40,
      height: 200,
      looping: true,
      selecteds: _model.initTimeDistanceEnd,
      adapter: NumberPickerAdapter(data: [
        NumberPickerColumn(begin: 0, end: 23),
        NumberPickerColumn(begin: 0, end: 55, jump: 5),
        NumberPickerColumn(begin: 0, end: 0),
      ]),
      hideHeader: true,
      onSelect: (Picker picker, int index, List<int> selecteds) {
        Provider.of<DialogTipsModel>(context, listen: false).updateTips(
            startPicker.getSelectedValues(), picker.getSelectedValues());
      },
      selectedTextStyle: TextStyle(color: Colors.blue, fontSize: 25),
    );
    return Column(
      children: <Widget>[
        Expanded(
          child: Column(
            children: <Widget>[
              Consumer<DialogPageModel>(
                builder: (context, model, child) {
                  LogUtil.e("  _timeDistancePage  Consumer");

                  return Container(
                    width: 150,
                    height: 30,
                    decoration: BoxDecoration(
                        color: Color.fromARGB(10, 0, 0, 0),
                        borderRadius: BorderRadius.all(Radius.circular(75))),
                    child: FlatButton(
                      child: Text(
                        "${model.timeTxt}",
                        style: TextStyle(color: Colors.blue),
                      ),
                      onPressed: () => this._onDatePressed(context),
                    ),
                  );
                },
              ),
              Row(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Expanded(
                    flex: 2,
                    child: startPicker.makePicker(),
                  ),
                  Expanded(
                    flex: 1,
                    child: Picker(
                      itemExtent: 40,
                      height: 200,
                      adapter: PickerDataAdapter(data: [
                        PickerItem(
                            text: Text("至",
                                style: TextStyle(
                                    color: Colors.blue, fontSize: 16))),
                      ]),
                      hideHeader: true,
                      onConfirm: (Picker picker, List value) {
                        print(value.toString());
                        print(picker.getSelectedValues());
                      },
                    ).makePicker(),
                  ),
                  Expanded(
                    flex: 2,
                    child: endPicker.makePicker(),
                  ),
                ],
              ),
              Consumer<DialogTipsModel>(
                builder: (context, model, child) {
                  LogUtil.e("  DialogTipsModel  Consumer");
                  return model.distanceTips;
                },
              ),
            ],
          ),
        ),
      ],
    );
  }

  _timeAllpage(context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        InkWellImageWidget("dialog_time_select_img_add_calendar", () => this._onDatePressed(context)),
        Consumer<DialogPageModel>(
          builder: (context, model, child) {
            LogUtil.e("  _timeAllpage  Consumer");
            return Padding(
              padding: EdgeInsets.symmetric(vertical: 20),
              child: FlatButton(
                child: Text(
                  "${model.timeTxt}",
                  style: TextStyle(color: Colors.blue, fontSize: 20),
                ),
                onPressed: () => this._onDatePressed(context),
              ),
            );
          },
        ),
        Text("全天事件会出现在今日视图中,",
            style: TextStyle(fontSize: 14, color: Colors.black45)),
        Text("表示您任意时间去执行，小序不会提醒您！",
            style: TextStyle(fontSize: 14, color: Colors.black45)),
      ],
    );
  }

  _onDatePressed(context) {
    LogUtil.e("   _onDatePressed     --------->  $context");
    Provider.of<DialogPageModel>(context, listen: false).setShowCalendar(true);
  }



  @override
  void dispose() {
    // TODO: implement dispose
  }

  @override
  void initView() {
    // TODO: implement initView
  }




}





class CustomStyleWeekBarItem extends BaseWeekBar {
  List<String> weekList = ["一", "二", "三", "四", "五", "六", "日"];

  @override
  Widget getWeekBarItem(int index) {
    return new Container(
      margin: EdgeInsets.symmetric(vertical: 20),
      child: new Center(
        child: new Text(
          weekList[index],
          style: TextStyle(fontSize: 10, color: Colors.black),
        ),
      ),
    );
  }
}

class CustomStyleDayWidget extends BaseCustomDayWidget {
  CustomStyleDayWidget(DateModel dateModel) : super(dateModel);

  @override
  void drawNormal(DateModel dateModel, Canvas canvas, Size size) {
    bool isCurrentDay = dateModel.isCurrentDay;

    //顶部的文字
    TextPainter dayTextPainter = new TextPainter()
      ..text = TextSpan(
          text: isCurrentDay ? "今" : dateModel.day.toString(),
          style: new TextStyle(
              color: isCurrentDay ? ColorUtils.mainColor : Colors.black,
              fontSize: 18))
      ..textDirection = TextDirection.ltr
      ..textAlign = TextAlign.center;

    dayTextPainter.layout(minWidth: size.width, maxWidth: size.width);
    dayTextPainter.paint(canvas, Offset(0, isCurrentDay ? 0 : 5));

    //下面的文字
    TextPainter lunarTextPainter = new TextPainter()
      ..text = new TextSpan(
          text: dateModel.lunarString,
          style: new TextStyle(
              color: isCurrentDay ? ColorUtils.mainColor : Colors.black12,
              fontSize: 12))
      ..textDirection = TextDirection.ltr
      ..textAlign = TextAlign.center;

    lunarTextPainter.layout(minWidth: size.width, maxWidth: size.width);
    lunarTextPainter.paint(canvas, Offset(0, size.height / 2));
  }

  void drawSelected(DateModel dateModel, Canvas canvas, Size size) {
    //绘制背景
    Paint backGroundPaint = new Paint()
      ..color = Colors.blue
      ..strokeWidth = 2;
    double padding = 8;
    canvas.drawRect(
        Rect.fromLTRB(0, 0, size.width, size.height), backGroundPaint);

    //顶部的文字
    TextPainter dayTextPainter = new TextPainter()
      ..text = TextSpan(
          text: dateModel.day.toString(),
          style: new TextStyle(color: Colors.white, fontSize: 16))
      ..textDirection = TextDirection.ltr
      ..textAlign = TextAlign.center;

    LogUtil.e("height       $size");
    dayTextPainter.layout(minWidth: size.width, maxWidth: size.width);
    dayTextPainter.paint(canvas, Offset(0, size.height / 8));

    //下面的文字
    TextPainter lunarTextPainter = new TextPainter()
      ..text = new TextSpan(
          text: dateModel.lunarString,
          style: new TextStyle(color: Colors.white, fontSize: 10))
      ..textDirection = TextDirection.ltr
      ..textAlign = TextAlign.center;

    lunarTextPainter.layout(minWidth: size.width, maxWidth: size.width);
    lunarTextPainter.paint(canvas, Offset(0, size.height / 2));
  }
}


