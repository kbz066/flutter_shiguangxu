import 'package:flustars/flustars.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_shiguangxu/base/BaseModel.dart';
import 'package:flutter_shiguangxu/base/BasePresenter.dart';
import 'package:flutter_shiguangxu/common/NavigatorUtils.dart';
import 'package:flutter_shiguangxu/entity/user_entity.dart';
import 'package:flutter_shiguangxu/page/home_page/home_page.dart';
import 'package:flutter_shiguangxu/page/login_page/login_page.dart';
import 'package:flutter_shiguangxu/utils/HttpUtils.dart';
import 'package:toast/toast.dart';

class LoginPresenter extends BasePresenter {
  LoginPresenter() : super(null);

  login(BuildContext context, String name, int passWord) {
    LogUtil.e("RegisterPresenter    注册    $context    ${UserData(userName: name, passWord: passWord).toJson()} ");
    HttpUtils.getInstance().postCallback("/login",
        context: context,
        data: UserData(userName: name, passWord: passWord).toJson(),
        success: (value) {

      NavigatorUtils.pushReplacement(context,HomePage());
    }, error: (value) {
      var error = value.toString().split(":");
      Toast.show(error[1], context);
    });
  }
}
