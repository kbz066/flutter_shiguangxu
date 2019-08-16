
import 'package:common_utils/common_utils.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_shiguangxu/base/BasePresenter.dart';

import 'package:flutter_shiguangxu/entity/schedule_entity.dart';
import 'package:flutter_shiguangxu/page/schedule_page/model/ScheduleModel.dart';



import 'package:flutter_shiguangxu/utils/HttpUtils.dart';

class SchedulePresenter extends BasePresenter{
  SchedulePresenter() : super(ScheduleModel());

  List<ScheduleData> _dataList=[];
  List<ScheduleData> planList=[];
  List<ScheduleData> scheduleList=[];


  void classiFicationList(){
    planList.clear();
    scheduleList.clear();
    for (var value in _dataList) {

      if(value.year==null &&value.month==null&&value.day==null){
        planList.add(value);
      }else{
        scheduleList.add(value);
      }
    }
  }

  void getListData(BuildContext context)async{
    HttpUtils.getInstance().getCallback("/getScheduleList",context: context,success: (value){

      _dataList=ScheduleEntity.fromJson(value).data;
      classiFicationList();
      notifyListeners();
    });


  }


  void addSchedule(ScheduleData data,BuildContext context,{Function success})async{

    var res=await HttpUtils.getInstance().post("/addSchedule",data:data.toJson() ,context: context);

      var entity=ScheduleEntity.fromJson(res);
    if(entity.code==200){
      _dataList=entity.data;

      classiFicationList();
      notifyListeners();
      if(success!=null){
        success(data.title);
      }
    }


  }
  void delSchedule(context,int id){
    HttpUtils.getInstance().postCallback("/delSchedule",data:{"id":id},context: context,success: (value){
      LogUtil.e("value -------------------> $value");
      _dataList=ScheduleEntity.fromJson(value).data;
      classiFicationList();
      notifyListeners();
    });
  }
  void updateSchedule(context,ScheduleData data){
    HttpUtils.getInstance().postCallback("/updateSchedule",data:data.toJson(),context: context,success: (value){
      LogUtil.e("value -------------------> $value");
      _dataList=ScheduleEntity.fromJson(value).data;
      classiFicationList();
      notifyListeners();
    });
  }

}