import 'package:flutter/material.dart';

class BottomPopupRoute extends PopupRoute{


  final Duration _duration = Duration(milliseconds: 300);
  Widget child;

  Color bgColor;


  BottomPopupRoute({@required this.child,this.bgColor});

  @override
  Color get barrierColor => bgColor;

  @override
  bool get barrierDismissible => true;

  @override
  String get barrierLabel => null;

  @override
  Widget buildPage(BuildContext context, Animation<double> animation, Animation<double> secondaryAnimation) {



  return  SlideTransition(
    position: new Tween<Offset>(
      begin: const Offset(.0, 1.0),
      end: const Offset(0.0, 0.0),
    ).animate(animation),
    child: child,
  );
  }

  @override
  Duration get transitionDuration => _duration;




}