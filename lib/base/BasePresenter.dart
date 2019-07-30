import 'package:flutter_shiguangxu/base/BaseView.dart';

abstract class BasePresenter<T extends BaseView> {
  T view;
  BasePresenter(this.view);
  void start();
  void dispose() {
    this.view = null;
  }
}