import 'package:flutter_shiguangxu/base/BaseModel.dart';
import 'package:flutter_shiguangxu/base/BasePresenter.dart';
import 'package:flutter_shiguangxu/entity/plan_entity.dart';
import 'package:flutter_shiguangxu/page/plan_list_page/model/PlanModel.dart';

class PlanPresenter extends BasePresenter<PlanModel>{
  PlanPresenter() : super(PlanModel());

  List<PlanEntity> lists=[];



  Future getPlanListData() async{

  }


  Future addPlan(){

  }
}