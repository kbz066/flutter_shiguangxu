import 'dart:convert';

import 'package:flustars/flustars.dart';
import 'package:flutter/material.dart';
import 'package:flutter_shiguangxu/common/ColorUtils.dart';
import 'package:flutter_shiguangxu/common/Constant.dart';
import 'package:flutter_shiguangxu/common/WindowUtils.dart';
import 'package:flutter_shiguangxu/entity/sechedule_entity.dart';

import 'package:flutter_shiguangxu/page/schedule_page/presenter/ScheduleDatePresenter.dart';
import 'package:flutter_shiguangxu/page/schedule_page/presenter/SchedulePresenter.dart';
import 'package:flutter_shiguangxu/page/schedule_page/presenter/ScheduleWeekPresenter.dart';
import 'package:provider/provider.dart';

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

  PageController _pageController;
  Map<String,List<SecheduleData>> dataMap={};

  @override
  void initState() {
    _tabController = TabController(length: 8, vsync: this);
    _pageController = PageController(
        initialPage: Provider.of<ScheduleWeekPresenter>(context, listen: false)
            .currentPageIndex);
    _distinguishList(Provider.of<SchedulePresenter>(context,listen: false));
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
              Consumer<ScheduleWeekPresenter>(builder: (_, presenter, child) {
                return Text(
                  presenter.getWeekOfMonth(),
                  style: TextStyle(fontSize: 16),
                );
              }),
              Icon(Icons.keyboard_arrow_down)
            ],
          ),
          backgroundColor: ColorUtils.mainColor,
        ),
        body: PageView.builder(
            controller: _pageController,
            onPageChanged: _onPageChanged,
            itemCount:
                Provider.of<ScheduleWeekPresenter>(context, listen: false)
                        .dateTotalSize ~/ 7,
            itemBuilder: (_, pageIndex) {
              return Container(
                color: ColorUtils.mainColor,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    Consumer<ScheduleWeekPresenter>(
                      builder: (_, presenter, child) {
                        return GridView.builder(
                          gridDelegate:
                              SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 8,
                                  childAspectRatio: 0.8,
                                  mainAxisSpacing: 0,
                                  crossAxisSpacing: 0),
                          itemBuilder: (_, index) {
                            return index == 0
                                ? Center(
                              child:  Text(
                                  "${presenter.getNewCurrentTime(pageIndex,index - 1).month}月",
                                  style: TextStyle(
                                      letterSpacing: 2,
                                      color: Colors.white,
                                      fontSize: 18)),
                            )
                                : Column(
                                    mainAxisSize: MainAxisSize.min,
                                    children: <Widget>[
                                      Text(weekTitles[index - 1],
                                          style: TextStyle(
                                              letterSpacing: 2,
                                              color: Colors.white)),
                                      SizedBox(height: 5),
                                      _getDateItem(presenter, pageIndex,index),
                                    ],
                                  );
                          },
                          itemCount: 8,
                          shrinkWrap: true,
                        );
                      },
                    ),
                    Expanded(
                      child: Container(
                        color: Colors.white,
                        child: _buildScheduleGridView(pageIndex),
                      ),
                    )
                  ],
                ),
              );
            }),
      ),
    );
  }

  void _onPageChanged(index) {
    Provider.of<ScheduleWeekPresenter>(context, listen: false).setIndex(index);
  }

  _getDateItem(ScheduleWeekPresenter presenter,pageIndex, index) {
    var _time = presenter.getNewCurrentTime(pageIndex,index - 1);

    return DateUtil.isToday(_time.millisecondsSinceEpoch)
        ? Container(
            height: 25,
            alignment: Alignment.center,
            decoration: BoxDecoration(
                color: Colors.black12,
                border: Border.all(color: Colors.white),
                shape: BoxShape.circle),
            child: Text(
              "今",
              style: TextStyle(
                color: Colors.white,
              ),
            ))
        : Container(
            height: 25,
            alignment: Alignment.center,
            child: Text(_time.day.toString(),
                style: TextStyle(letterSpacing: 2, color: Colors.white)),
          );
  }



  _buildScheduleGridView(pageIndex) {

    var schedulePresenter=Provider.of<SchedulePresenter>(context,listen: false);
    var weekPresenter = Provider.of<ScheduleWeekPresenter>(context, listen: false);
    _distinguishList(schedulePresenter);
    return ListView.builder(

      itemBuilder: (_, listIndex) {
        var itemHeight=_getItemHeight(listIndex);
        return Container(
          height:itemHeight,

          child:  ListView.builder(

              scrollDirection: Axis.horizontal,
              itemBuilder: (_, childIndex) {

                return Container(
                  width: WindowUtils.getWidthDP()/8,

                  child: childIndex == 0
                      ? Text(" ${timeTitles[listIndex]}")
                      : Container(
                    color: Colors.black12,
                    padding: EdgeInsets.all(1),
                    child: Container(

                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.all(Radius.circular(5))),
                      child: _buildItem(pageIndex,listIndex,childIndex,weekPresenter,itemHeight),
                    ),
                  ),
                );
              },
              shrinkWrap: true,
              itemCount: 8,
              physics: NeverScrollableScrollPhysics()),
        );
      },
      itemCount: timeTitles.length,
      shrinkWrap: true,
    );
  }



  _getItemHeight(listIndex){
    var list=getItemData(timeTitles[listIndex]);
    if(list==null){
      return WindowUtils.getWidthDP()/8;
    }else{
      return list.length<2?WindowUtils.getWidthDP()/8:list.length/2*WindowUtils.getWidthDP()/8;
    }
  }
  List<SecheduleData> findListByTime(pageIndex,childIndex,key,ScheduleWeekPresenter weekPresenter){
    var list=<SecheduleData>[];
    var itemList=dataMap[key];

    if(itemList==null){
      return itemList;
    }
    for (var value in itemList) {
      var time=weekPresenter.getNewCurrentTime(pageIndex,childIndex );

      if(time.year==value.year&&time.month==value.month&&time.day==value.day){
        list.add(value);
      }
    }
    return list;

  }
  _distinguishList(SchedulePresenter schedulePresenter){
    var list=schedulePresenter.scheduleList;


    for (var title in timeTitles) {
      if(title!="全天"){
        var itemList=<SecheduleData>[];
        for (var value in list) {
          if(title.indexOf(value.startHour.toString())!=-1){
            itemList.add(value);
          }
        }
        if(itemList.length>0)
          dataMap.putIfAbsent(title, ()=>itemList);

      }
    };

  }
  _buildItem(pageIndex,listIndex,childIndex,weekPresenter,itemHeight) {
    var itemList = findListByTime(
        pageIndex, childIndex-1, timeTitles[listIndex], weekPresenter);



    return Column(
      children: itemList == null ? [] : itemList.map((value) {

        return Container(
          width: double.infinity,
          alignment: Alignment.center,
          height: itemList.length==1?itemHeight/2:itemHeight/itemList.length-(itemList.length-1*2)-2,
          margin: EdgeInsets.only(bottom: itemList.indexOf(value)==itemList.length-1?0:2),
          decoration: BoxDecoration(
              color: Colors.blue,

              borderRadius: BorderRadius.all(Radius.circular(5))
          ),
          child: Text(value.title,style: TextStyle(color: Colors.white),maxLines: 1,),
        );
      }).toList(),
    );
  }

  List<SecheduleData> getItemData(key){
    return dataMap==null?null:dataMap[key];
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
