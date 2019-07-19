

import 'package:flutter/material.dart';

///可去掉过度滑动时ListView顶部的蓝色光晕效果
class MyBehavior extends ScrollBehavior {

  final bool isShowLeadingGlow;
  final bool isShowTrailingGlow;
  final Color _kDefaultGlowColor;

  MyBehavior(this.isShowLeadingGlow,this.isShowTrailingGlow,this._kDefaultGlowColor);

  @override
  Widget buildViewportChrome(BuildContext context, Widget child, AxisDirection axisDirection) {

    //如果头部或底部有一个 不需要 显示光晕时 返回GlowingOverscrollIndicator
    if(!isShowLeadingGlow||!isShowTrailingGlow){
      return new  GlowingOverscrollIndicator(
        showLeading: isShowLeadingGlow,
        showTrailing: isShowTrailingGlow,
        child: child,
        axisDirection: axisDirection,
        color: _kDefaultGlowColor,
      );
    }else {
      //都需要光晕时  返回系统默认
      return super.buildViewportChrome(context, child, axisDirection);
    }
  }
}
