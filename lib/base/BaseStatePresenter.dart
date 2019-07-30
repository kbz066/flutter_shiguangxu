import 'package:flutter_shiguangxu/base/BaseStateView.dart';

abstract class BaseStatePresenter<T extends BaseStateView> {
  T view;
  BaseStatePresenter(this.view);
  void start();
  void stop() {
    this.view = null;
  }
}