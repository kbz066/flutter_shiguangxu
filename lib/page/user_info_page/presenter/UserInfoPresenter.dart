import 'package:flustars/flustars.dart';
import 'package:flutter/material.dart';
import 'package:flutter_shiguangxu/base/BaseModel.dart';
import 'package:flutter_shiguangxu/base/BasePresenter.dart';
import 'package:flutter_shiguangxu/entity/user_info_entity.dart';
import 'package:flutter_shiguangxu/utils/HttpUtils.dart';

class UserInfoPresenter extends BasePresenter{
  UserInfoPresenter() : super(null);

  UserInfoData infoData;



  void updateInfo(UserInfoData infoData,context){
    this.infoData=infoData;
    LogUtil.e("更新              ${infoData.toJson()}");
    HttpUtils.getInstance().postCallback("/updateInfo",data:infoData.toJson(),context: context,success: (value){

      notifyListeners();
      Navigator.pop(context);
    });

  }


}