import 'package:flutter/material.dart';



class Test extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Container(

          width: 200,
          height: 200,
          color: Colors.blue,
          child: Stack(
            children: <Widget>[
              Container(
                width: 100,
                height: 100,
                color: Colors.red,
              )
            ],
          ),
        ),
      ),
    );
  }
}
