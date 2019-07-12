import 'package:flutter/material.dart';

class ConfigPage extends StatefulWidget {
  @override
  ConfigPageState createState() => new ConfigPageState();
}

class ConfigPageState extends State<ConfigPage>
    with AutomaticKeepAliveClientMixin {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.red,
      child: Stack(
        children: <Widget>[
          Container(
            width: double.infinity,
            height: double.infinity,
          ),
          Image.asset("assets/images/my_bg.png",fit: BoxFit.cover,width: double.infinity,height: 150,),
        ],
      ),
    );
  }

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;
}
