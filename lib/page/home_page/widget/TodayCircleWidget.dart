import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/material.dart';



//
//阶段一：出现一个圆点，半径随下拉距离变大而变大。位置始终在中间
//阶段二：圆点两边出现两个圆点，半径较小。距离随下拉距离变大而变大，中间圆点半径不断变小。位置始终在中间
//阶段三：从顶部出现内容列表，位置随手指下拉快速往下移动，同时三个圆点位置不断下移并逐渐消失
//阶段四：只剩下内容列表，手指可以继续往下滑动，但阻尼变大。内容列表始终在中间。


class  TodayCircleWidget extends StatefulWidget {


  double _percent=1.0;


  TodayCircleWidget(this._percent);

  @override
  TodayCircleWidgetState createState() => new TodayCircleWidgetState();
}

class TodayCircleWidgetState extends State<TodayCircleWidget> {




  @override
  Widget build(BuildContext context) {
    return CustomPaint(

      size: Size(double.infinity,15),
      painter: TodayCirclePainter(widget._percent),
    );
  }
  @override
  void initState() {

    super.initState();
  }



}

class TodayCirclePainter extends CustomPainter{

  double _percent=1;
  double _maxRadius = 4;
  double _maxDist = 15;


  Paint _paint;




  TodayCirclePainter(this._percent){
    _paint=Paint()..color=Colors.green;
  }

  @override
  void paint(Canvas canvas, Size size) {
    _maxRadius = size.height / 2;
    double centerX = size.width / 2;
    double centerY = size.height / 2;
    //print("radius      ${_percent}"  );
    if(_percent<= 0.5){
      double radius = _percent * 2 * _maxRadius;
      canvas.drawCircle(Offset(centerX, centerY), radius, _paint);

    }else{

      double afterPercent = (_percent - 0.5) / 0.5;
      double radius = _maxRadius - _maxRadius / 2 * afterPercent;


      canvas.drawCircle(Offset(centerX, centerY), radius, _paint);
      canvas.drawCircle(Offset(centerX - afterPercent * _maxDist, centerY), _maxRadius / 2, _paint);
      canvas.drawCircle(Offset(centerX + afterPercent * _maxDist, centerY), _maxRadius / 2, _paint);
    }

  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    // TODO: implement shouldRepaint
    return true;
  }

}