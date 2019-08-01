import 'package:flutter/material.dart';
import 'package:flutter_shiguangxu/base/BaseModel.dart';
import 'package:flutter_shiguangxu/base/BaseView.dart';

abstract class BasePresenter<T extends BaseModel> extends ChangeNotifier {

  T model;

  BasePresenter(this.model);


//  T view;
//  BasePresenter(this.view);
//  void start();
//  void dispose() {
//    this.view = null;
//  }
}