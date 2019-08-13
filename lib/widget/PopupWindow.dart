import 'package:flutter/material.dart';

class PopupWindow {
  static showDialog(
    BuildContext context,
    int milliseconds,
    TickerProvider vsync,
    WidgetBuilder builder, {
    double left,
    double top,
    double right,
    double bottom,
        bool autoClose=true
  }) {
    AnimationController controller = AnimationController(
      duration: Duration(milliseconds: 300),
      vsync: vsync,
    );

    controller.forward();
    //获取OverlayState
    OverlayState overlayState = Overlay.of(context);
//创建OverlayEntry
    OverlayEntry _overlayEntry = OverlayEntry(
        builder: (BuildContext context) =>Positioned(
          child:SlideTransition(
            position: Tween(begin: Offset(0, -1), end: Offset(0, 0))
                .animate(controller),
            child:builder(context) ,
          ) ,
          top: top,
          bottom: bottom,
          left: left,
          right: right,
        ) );
//显示到屏幕上
    overlayState.insert(_overlayEntry);
//移除屏幕
//    _overlayEntry.remove();

    if(autoClose){
      Future.delayed(Duration(milliseconds: milliseconds)).then((value) {
        _overlayEntry.remove();
      });
    }

  }

  static LayoutBuilder buildToastLayout(String msg) {
    return LayoutBuilder(builder: (context, constraints) {
      return IgnorePointer(
        ignoring: true,
        child: Container(
          child: Material(
            color: Colors.white.withOpacity(0),
            child: Container(
              child: Container(
                child: Text(
                  "${msg}",
                  style: TextStyle(color: Colors.white),
                ),
                decoration: BoxDecoration(
                  color: Colors.black.withOpacity(0.6),
                  borderRadius: BorderRadius.all(
                    Radius.circular(5),
                  ),
                ),
                padding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
              ),
              margin: EdgeInsets.only(
                bottom: constraints.biggest.height * 0.15,
                left: constraints.biggest.width * 0.2,
                right: constraints.biggest.width * 0.2,
              ),
            ),
          ),
          alignment: Alignment.bottomCenter,
        ),
      );
    });
  }
}
