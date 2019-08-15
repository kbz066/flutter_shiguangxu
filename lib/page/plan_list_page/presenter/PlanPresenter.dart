
import 'package:common_utils/common_utils.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_shiguangxu/base/BasePresenter.dart';
import 'package:flutter_shiguangxu/entity/plan_entity.dart';

import 'package:flutter_shiguangxu/page/plan_list_page/model/PlanModel.dart';
import 'package:flutter_shiguangxu/utils/HttpUtils.dart';

class PlanPresenter extends BasePresenter<PlanModel>{
  PlanPresenter() : super(PlanModel());

  List<PlanData> dataList=[];



  void getPlanListData(BuildContext context)async{
    HttpUtils.getInstance().getCallback("/getPlanList",context: context,success: (value){

      dataList=PlanEntity.fromJson(value).data;
      notifyListeners();
    });


  }


  void addPlan(PlanData data,BuildContext context,{Function success})async{

    var res=await HttpUtils.getInstance().post("/addPlan",data:data.toJson() ,context: context);

      var entity=PlanEntity.fromJson(res);
    if(entity.code==200){
      dataList=entity.data;
      notifyListeners();
      if(success!=null){
        success(data.title);
      }
    }


  }
  void delPlan(context,int id){
    HttpUtils.getInstance().postCallback("/delPlan",data:{"id":id},context: context,success: (value){
      LogUtil.e("value -------------------> $value");
      dataList=PlanEntity.fromJson(value).data;
      notifyListeners();
    });
  }
  void updatePlan(context,PlanData data){
    HttpUtils.getInstance().postCallback("/updatePlan",data:data.toJson(),context: context,success: (value){
      LogUtil.e("value -------------------> $value");
      dataList=PlanEntity.fromJson(value).data;
      notifyListeners();
    });
  }

}