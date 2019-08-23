import 'package:flustars/flustars.dart';
import 'package:flutter/material.dart';
import 'package:flutter_shiguangxu/common/ColorUtils.dart';
import 'package:flutter_shiguangxu/common/Constant.dart';
import 'package:flutter_shiguangxu/entity/sechedule_entity.dart';
import 'package:flutter_shiguangxu/page/schedule_page/presenter/SchedulePresenter.dart';
import 'package:flutter_shiguangxu/page/schedule_page/presenter/ScheduleWeekPresenter.dart';
import 'package:provider/provider.dart';

import 'presenter/QuadrantPresenter.dart';

class QuadrantPage extends StatefulWidget {
  @override
  QuadrantPageState createState() => QuadrantPageState();
}

class QuadrantPageState extends State<QuadrantPage> {
  PageController _pageController;
  SchedulePresenter _schedulePresenter;

  @override
  void initState() {
    _schedulePresenter = Provider.of<SchedulePresenter>(context, listen: false);
    _pageController = PageController(initialPage: 1);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Scaffold(
        appBar: AppBar(
          elevation: 0,
          centerTitle: true,
          title: Row(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Consumer<QuadrantPresenter>(builder: (_, presenter, child) {
                return Text(
                  "${presenter.month[presenter.currentPageIndex]}月 第${presenter.week[presenter.currentPageIndex]}周",
                  style: TextStyle(fontSize: 16),
                );
              }),
              Icon(Icons.keyboard_arrow_down)
            ],
          ),
          backgroundColor: ColorUtils.mainColor,
        ),
        body: Consumer<QuadrantPresenter>(builder: (_, presenter, child) {
          return PageView.builder(
              itemCount: 3,
              controller: _pageController,
              onPageChanged: _onPageChanged,
              itemBuilder: (_, index) {
                return Column(
                  children: <Widget>[
                    Container(
                      color: ColorUtils.mainColor,
                      padding: EdgeInsets.symmetric(vertical: 10),
                      child: Row(
                        children: <Widget>[
                          Container(
                              width: 80,
                              child: Center(
                                child: Text(
                                  "${presenter.month[presenter.currentPageIndex]}月",
                                  style: TextStyle(
                                      color: Colors.white,
                                      letterSpacing: 5,
                                      fontSize: 18),
                                ),
                              )),
                          Expanded(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: _buildTab(index),
                            ),
                          )
                        ],
                      ),
                    ),
                    Expanded(
                      child: _buildGrid(presenter),
                    )
                  ],
                );
              });
        }),
      ),
    );
  }

  _onPageChanged(index) {
    Provider.of<QuadrantPresenter>(context, listen: false)
        .updatePageIndex(index);
  }

  _buildGrid(QuadrantPresenter presenter) {
    var levelIcon = [
      "icon_level_one.png",
      "icon_level_two.png",
      "icon_level_three.png",
      "icon_level_four.png"
    ];
    var levelTitle = ["主要且紧急", "主要不紧急", "紧急不重要", "不重要不紧急"];
    var levelColor = [0xffFF6274, 0xffFFA523, 0xff58C086, 0xff4BA9FF];
    return GridView.builder(
        shrinkWrap: true,
        physics: NeverScrollableScrollPhysics(),
        itemCount: levelTitle.length,
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2, childAspectRatio: 0.72),
        itemBuilder: (_, index) {
          return Card(
            child:Column(
              children: <Widget>[
                Container(
                  color: Color(levelColor[index]).withAlpha(50),
                  child: Row(
                    children: <Widget>[
                      SizedBox(width: 10),
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
                    ],
                  ),
                ),
                Expanded(
                  child: _buildList(index, presenter),
                )
              ],
            ),
          );
        });
  }

  _buildList(index, QuadrantPresenter presenter) {
    var scheduleList = _schedulePresenter.scheduleList;

    var list = <SecheduleData>[];
    for (var value in scheduleList) {
      var week = presenter.week[presenter.currentPageIndex];
      if (_checkTime(presenter, value, index)) {
        list.add(value);
      }
    }
    return list.length == 0
        ? Container()
        : ListView.builder(
            padding: EdgeInsets.only(left: 5, top: 10),
            itemCount: list.length,
            itemBuilder: (_, index) {
              return Container(
                decoration: BoxDecoration(border: Border(bottom:BorderSide(color: Colors.black12) )),
                padding: EdgeInsets.symmetric(vertical: 10),

                child: Row(
                  children: <Widget>[
                    Image.asset(
                      Constant.IMAGE_PATH + "icon_time_taskson.png",
                      width: 12,
                    ),
                    SizedBox(width: 10),
                    Text(list[index].title),
                    SizedBox(width: 10),

                  ],
                ),
              );
            });
  }

  _checkTime(QuadrantPresenter presenter, SecheduleData data, index) {
    int startDay;
    int endDay;
    switch (presenter.week[presenter.currentPageIndex]) {
      case 1:
        startDay = 1;
        endDay = 7;
        break;
      case 2:
        startDay = 7;
        endDay = 14;
        break;
      case 3:
        startDay = 14;
        endDay = 21;
        break;
      case 4:
        startDay = 21;
        endDay = Constant.getMonthOfDay(
            DateTime.now().year, presenter.month[presenter.currentPageIndex]);
        break;
    }
    if (presenter.month[presenter.currentPageIndex] == data.month &&
        data.level == index &&
        (data.day >= startDay && data.day < endDay)) {
      return true;
    } else {
      return false;
    }
  }

  _buildTab(pageIndex) {
    var tabTitles = ["第1周", "第2周", "第3周", "第4周"];
    var week = Provider.of<QuadrantPresenter>(context, listen: false).week;
    LogUtil.e("week   ${week[pageIndex]}");
    return tabTitles.map((value) {
      return GestureDetector(
        onTapDown: (_) {
          Provider.of<QuadrantPresenter>(context, listen: false)
              .updateWeek(tabTitles.indexOf(value) + 1);
        },
        child: Column(
          children: <Widget>[
            Text(
              value,
              style: TextStyle(color: Colors.white),
            ),
            Container(
              width: 40,
              height: 2,
              margin: EdgeInsets.only(top: 5),
              decoration: BoxDecoration(
                  color: tabTitles.indexOf(value) != (week[pageIndex] - 1)
                      ? Colors.transparent
                      : Colors.white,
                  borderRadius: BorderRadius.all(Radius.circular(5))),
            )
          ],
        ),
      );
    }).toList();
  }
}
