import 'package:flustars/flustars.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_shiguangxu/base/BaseModel.dart';
import 'package:flutter_shiguangxu/base/BasePresenter.dart';
import 'package:flutter_shiguangxu/common/NavigatorUtils.dart';
import 'package:flutter_shiguangxu/entity/user_entity.dart';
import 'package:flutter_shiguangxu/page/login_page/login_page.dart';
import 'package:flutter_shiguangxu/utils/HttpUtils.dart';
import 'package:toast/toast.dart';

class RegisterPresenter extends BasePresenter {
  RegisterPresenter() : super(null);

  register(BuildContext context, String name, int passWord) {

    HttpUtils.getInstance().postCallback("/register",
        context: context,
        data: UserData(userName: name, passWord: passWord).toJson(),
        success: (value) {
      Toast.show("注册成功", context);
      NavigatorUtils.pop(context);
    }, error: (value) {
      var error = value.toString().split(":");
      Toast.show(error[1], context);
    });
  }
}
