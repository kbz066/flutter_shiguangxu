import 'package:flutter/material.dart';

class PlanDetailsPage extends StatefulWidget {
  @override
  _PlanDetailsPageState createState() => _PlanDetailsPageState();
}

class _PlanDetailsPageState extends State<PlanDetailsPage> {

  var icons = [
    "assets/images/bg_money_edit_task.png",
    "assets/images/bg_aihao_edit_task.png",
    "assets/images/bg_shopping_edit_task.png",
    "assets/images/bg_project_edit_task.png",
    "assets/images/bg_travel_edit_task.png"
  ];
  var colors = [
    0xffF4691A,
    0xffFA9515,
    0xffF44ABC,
    0xff128496,
    0xff0DA775
  ];
  var levelIcon = [
    "icon_level_one.png",
    "icon_level_two.png",
    "icon_level_three.png",
    "icon_level_four.png"
  ];
  var levelTitle = ["主要且紧急", "主要不紧急", "紧急不重要", "不重要不紧急"];
  var levelColor = [0xffFF6274, 0xffFFA523, 0xff58C086, 0xff4BA9FF];
  @override
  Widget build(BuildContext context) {
    return Material();
  }
}
