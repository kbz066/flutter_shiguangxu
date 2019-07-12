import 'dart:ui';

class WindowUtils{
  static getWidthDP(){
    return window.physicalSize.width/window.devicePixelRatio;
  }
  static getHeightDP(){
    return window.physicalSize.height/window.devicePixelRatio;
  }

  static getWidth(){
    return window.physicalSize.width;
  }
  static getHeight(){
    return window.physicalSize.height;
  }
}