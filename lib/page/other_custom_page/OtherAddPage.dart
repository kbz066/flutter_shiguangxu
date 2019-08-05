import 'package:common_utils/common_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_shiguangxu/common/ColorUtils.dart';
import 'package:flutter_shiguangxu/page/other_custom_page/presenter/OtherPresenter.dart';
import 'package:flutter_shiguangxu/widget/InkWellImageWidget.dart';
import 'package:provider/provider.dart';

class OtherAddPage extends StatefulWidget {
  @override
  State createState() => new OtherAddPageState();
}

class OtherAddPageState extends State<OtherAddPage> {
  var iconPreviews = [
    "assets/images/bg_money_edit_task.png",
    "assets/images/bg_aihao_edit_task.png",
    "assets/images/bg_shopping_edit_task.png",
    "assets/images/bg_project_edit_task.png",
    "assets/images/bg_travel_edit_task.png"
  ];

  var icons = [
    "icon_money_tasktag",
    "icon_aihao_tasktag",
    "icon_shopping_tasktag",
    "icon_project_tasktag",
    "icon_travel_tasktag",
  ];
  var iconsColors = [
    0xffF4691A,
    0xffFA9515,
    0xffF44ABC,
    0xff128496,
    0xff0DA775
  ];
  int index = 0;

  String title = "";

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: Text("添加分类"),
        centerTitle: true,
        backgroundColor: ColorUtils.mainColor,
        actions: <Widget>[
          Center(
              child: Padding(
                  padding: EdgeInsets.only(right: 20),
                  child: GestureDetector(
                    onTapDown: (_) {
                      Provider.of<OtherPresenter>(context, listen: false)
                          .addOther(iconsColors[index], title, icons[index]+".png");
                      Navigator.pop(context);
                    },
                    child: Text(
                      "保存",
                      style: TextStyle(fontSize: 16),
                    ),
                  )))
        ],
      ),
      body: SafeArea(
          child: Container(
        padding: EdgeInsets.symmetric(horizontal: 10),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              SizedBox(height: 10),
              Row(
                children: <Widget>[
                  Text("名称", style: TextStyle(fontSize: 16)),
                  SizedBox(width: 20),
                  Expanded(
                    child: TextField(
                      onChanged: (value) {
                        this.title = value;
                        print('input ${value}');
                      },
                      decoration: InputDecoration(
                          hintText: "请填写分类名称",
                          border: InputBorder.none,
                          hintStyle:
                              TextStyle(fontSize: 16, color: Colors.black26)),
                    ),
                  )
                ],
              ),
              SizedBox(height: 10),
              Divider(height: 1.5, indent: 0.0, color: Colors.black26),
              SizedBox(height: 20),
              Text("图标"),
              SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  _getIconitem("icon_money_tasktag", 0),
                  _getIconitem("icon_aihao_tasktag", 1),
                  _getIconitem("icon_shopping_tasktag", 2),
                  _getIconitem("icon_project_tasktag", 3),
                  _getIconitem("icon_travel_tasktag", 4)
                ],
              ),
              SizedBox(height: 20),
              Divider(height: 1.5, indent: 0.0, color: Colors.black26),
              SizedBox(height: 20),
              Text("背景图预览"),
              SizedBox(height: 20),
              Center(
                child: Image.asset(
                  iconPreviews[index],
                  width: 280,
                ),
              )
            ],
          ),
        ),
      )),
    );
  }

  _getIconitem(name, int index) {
    return Container(
      padding: EdgeInsets.all(10),
      decoration: BoxDecoration(
          color: index == this.index
              ? Color(iconsColors[this.index])
              : Colors.black12,
          borderRadius: BorderRadius.all(Radius.circular(30))),
      child: SizedBox(
        width: 20,
        height: 20,
        child: InkWellImageWidget(
            name,
            () => setState(() {
                  this.index = index;
                })),
      ),
    );
  }
}
