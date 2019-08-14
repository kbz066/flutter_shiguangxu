import 'package:common_utils/common_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_shiguangxu/common/ColorUtils.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class Loadding {
  static void showLoad(context, title) {
    showDialog(
        context: context,
        builder: (context) {
          return WillPopScope(
            child:   Scaffold(
              backgroundColor: Colors.transparent,
              body: Center(
                child: Container(
                    width: 80,
                    height: 80,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.all(Radius.circular(10))),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        SpinKitCubeGrid(
                          size: 20,
                          itemBuilder: (_, int index) {
                            return DecoratedBox(
                              decoration: BoxDecoration(
                                color: ColorUtils.mainColor,
                              ),
                            );
                          },
                        ),
                        SizedBox(height: 5),
                        Text(
                          title==null?"加载中...":title,
                          style: TextStyle(color: ColorUtils.mainColor),
                        )
                      ],
                    )),
              ),
            ),
            onWillPop: () async {
              return Future.value(false);
            },
          )


          ;
        });
  }
}
