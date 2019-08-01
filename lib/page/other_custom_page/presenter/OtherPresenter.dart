import 'package:flutter/material.dart';
import 'package:flutter_shiguangxu/base/BaseModel.dart';
import 'package:flutter_shiguangxu/base/BasePresenter.dart';
import 'package:flutter_shiguangxu/dao/Other_DB.dart';
import 'package:flutter_shiguangxu/page/other_custom_page/model/OtherModel.dart';

class OtherPresenter extends BasePresenter<OtherModel>{
  OtherPresenter() : super(OtherModel());


  Future<List<Other_DB>> getOtherListData() {
    return model.getOtherListData();
  }


}