import 'package:common_utils/common_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_shiguangxu/common/Constant.dart';

class InkWellImageWidget extends StatelessWidget{

  String _imageName;
  VoidCallback _callback;


  InkWellImageWidget(this._imageName, this._callback);

  @override
  Widget build(BuildContext context) {
   // LogUtil.e("_imageName         $_imageName");
    return InkWell(
      child: Image.asset(Constant.IMAGE_PATH +"$_imageName.png",fit: BoxFit.cover,),
      onTap: _callback
    );
  }

}