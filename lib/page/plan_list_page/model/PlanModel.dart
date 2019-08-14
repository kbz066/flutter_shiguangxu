import 'package:flutter_shiguangxu/base/BaseModel.dart';
import 'package:flutter_shiguangxu/utils/HttpUtils.dart';

class PlanModel extends BaseModel{


  Future getPlanListData() async{
    return HttpUtils.getInstance().getCallback("/getPlanList");
  }
}