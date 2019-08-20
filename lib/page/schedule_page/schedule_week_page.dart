import 'package:flustars/flustars.dart';
import 'package:flutter/material.dart';
import 'package:flutter_shiguangxu/common/ColorUtils.dart';
import 'package:flutter_shiguangxu/common/Constant.dart';
import 'package:flutter_shiguangxu/common/WindowUtils.dart';

class ScheduleWeekPage extends StatefulWidget {
  @override
  _ScheduleWeekPageState createState() => _ScheduleWeekPageState();
}

class _ScheduleWeekPageState extends State<ScheduleWeekPage>
    with SingleTickerProviderStateMixin {
  TabController _tabController;

  var weekTitles = ["周一", "周二", "周三", "周四", "周五", "周六", "周日"];
  var timeTitles = [
    "全天",
    "03:00",
    "04:00",
    "05:00",
    "06:00",
    "07:00",
    "08:00",
    "09:00",
    "10:00",
    "11:00",
    "12:00",
    "13:00",
    "14:00",
    "15:00",
    "16:00",
    "17:00",
    "18:00",
    "19:00",
    "20:00",
    "21:00",
    "22:00",
    "23:00",
  ];

  @override
  void initState() {
    _tabController = TabController(length: 8, vsync: this);
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
              Text(
                "八月 第四周",
                style: TextStyle(fontSize: 16),
              ),
              Icon(Icons.keyboard_arrow_down)
            ],
          ),
          backgroundColor: ColorUtils.mainColor,
        ),
        body: Container(
          color: ColorUtils.mainColor,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              GridView.builder(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 8,
                    childAspectRatio: 1,
                    mainAxisSpacing: 0,
                    crossAxisSpacing: 0),
                itemBuilder: (_, index) {
                  return Center(
                    child: index == 0
                        ? Text("8月",
                            style: TextStyle(
                                letterSpacing: 2,
                                color: Colors.white,
                                fontSize: 18))
                        : Column(
                            mainAxisSize: MainAxisSize.min,
                            children: <Widget>[
                              Text(weekTitles[index - 1],
                                  style: TextStyle(
                                      letterSpacing: 2, color: Colors.white)),
                              SizedBox(height: 5),
                              Text("20",
                                  style: TextStyle(
                                      letterSpacing: 2, color: Colors.white)),
                            ],
                          ),
                  );
                },
                itemCount: 8,
                shrinkWrap: true,
              ),
              Expanded(
                child: Container(
                  color: Colors.white,
                  child: _buildScheduleGridView(),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  _buildScheduleGridView() {
    return ListView.builder(
      itemBuilder: (_, index) {
        return GridView.builder(
            gridDelegate:
                SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 8,childAspectRatio:index == 1 ? 0.5 : 1,),
            itemBuilder: (_, childIndex) {
              return Container(


                child: Text(" $childIndex"),
              );
            },
            shrinkWrap: true,
            itemCount: 8,
            physics: NeverScrollableScrollPhysics());
      },
      itemCount: timeTitles.length,
      shrinkWrap: true,
    );
  }
//  _getDateWidget(_time, index, pageIndex) {
//    /**
//     * 当前显示的日期
//     */
//    var _nowDuration =
//    _time.add(Duration(days: pageIndex * 7 + index - (_time.weekday - 1)));
//
//
//    return _time.compareTo(_nowDuration) == 0
//        ? Container(
//      height: 25,
//      alignment: Alignment.center,
//      decoration: BoxDecoration(
//          color: isCheckIndex(index, pageIndex) ? Colors.white : null,
//          border: Border.all(color: Colors.white),
//          shape: BoxShape.circle),
//      child: Text("今",
//          style: TextStyle(
//              color: isCheckIndex(index, pageIndex)
//                  ? ColorUtils.mainColor
//                  : Colors.white70,
//              textBaseline: TextBaseline.ideographic)),
//    )
//        : Container(
//      height: 25,
//      alignment: Alignment.center,
//      decoration: BoxDecoration(
//          color: isCheckIndex(index, pageIndex) ? Colors.white : null,
//          shape: BoxShape.circle),
//      child: Text("${(_nowDuration.day.toString())}",
//          style: TextStyle(
//              color: isCheckIndex(index, pageIndex)
//                  ? ColorUtils.mainColor
//                  : Colors.white70)),
//    );
//  }
//
//  isCheckIndex(index, pageIndex) {
//
//    return weekPresenter.currentPageIndex == pageIndex &&
//        weekPresenter.currentWeekIndex == index;
//  }
}
