import 'package:flutter/material.dart';
import 'package:flutter_shiguangxu/common/Constant.dart';

class ConfigCommonItem extends StatefulWidget {
  var title;
  var content;
  var padding;
  var showSwitchBut;
  var showDivider;

  VoidCallback onClick;



  ConfigCommonItem(this. title,this.padding,
      {this.content, this.showSwitchBut=false, this.showDivider=false,this.onClick});

  @override
  State createState() => new _ConfigCommonItemState();
}

class _ConfigCommonItemState extends State<ConfigCommonItem> {
  bool check;

  @override
  void initState() {
    check = false;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapDown: (down){
        if(widget.onClick!=null){
          widget.onClick();
        }
      } ,
      child: Container(
        color: Colors.white,
        padding: EdgeInsets.all(0),
        margin: EdgeInsets.all(0),
        child: Column(
          children: <Widget>[
            Padding(
              padding: widget.padding,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Expanded(
                    child: widget.title,
                  ),
                  Padding(
                    padding: EdgeInsets.only(right: 10),
                    child: widget.content == null ? Container(height: 0,) : widget.content,
                  ),
                  Padding(
                      padding: EdgeInsets.only(left: 10),
                      child: widget.showSwitchBut
                          ? Switch(
                        value: check,
                        activeColor: Colors.white,
                        inactiveThumbColor: Colors.white,
                        activeTrackColor: Color(0xff50D066),
                        inactiveTrackColor: Color(0xffCCCCCC),
                        onChanged: (bool val) {
                          this.setState(() {
                            this.check = !this.check;
                          });
                        },
                      )
                          : Image.asset(
                          Constant.IMAGE_PATH + "icon_rightarrow_gray.png")
                  ),
                ],
              ),
            ),
            widget.showDivider
                ? Divider(
              height: 1,
              color: Colors.black26,
            )
                : Container()
          ],
        ),
      ),
    );
  }
}
