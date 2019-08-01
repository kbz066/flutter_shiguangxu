
import 'package:flutter/material.dart';

class LoadingWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(

      width: double.infinity,
      alignment: Alignment.center,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          CircularProgressIndicator(valueColor: AlwaysStoppedAnimation(Color(0xff65B5DE)),),
          SizedBox(height: 10,),
          Text("正在奋力加载中...",style: TextStyle(color: Color(0xff555555),fontSize: 12),)
        ],
      ),
    );
  }
}