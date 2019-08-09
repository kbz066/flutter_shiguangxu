import 'package:common_utils/common_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_shiguangxu/common/ColorUtils.dart';
import 'package:flutter_shiguangxu/widget/DragTargetListView.dart';

class PlanListPage extends StatefulWidget {
  @override
  PlanListPageState createState() => new PlanListPageState();
}

class PlanListPageState extends State<PlanListPage>
    with AutomaticKeepAliveClientMixin {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
//      floatingActionButton: FloatingActionButton(
//        backgroundColor: ColorUtils.mainColor,
//        onPressed: () {
//
//        },
//        child: Icon(Icons.add),
//      ),
      body: Container(
        decoration: BoxDecoration(
          color: Colors.blueAccent,
          image: DecorationImage(
            image: AssetImage("assets/images/background_img_detailed.png"),
            fit: BoxFit.cover,
          ),
        ),
        child: Container(
          padding: EdgeInsets.only( top: 20),
          child: Column(
            children: <Widget>[
             Padding(
               padding: EdgeInsets.symmetric(horizontal: 20),
               child:  Row(
                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
                 children: <Widget>[
                   SizedBox(
                     width: 60,
                     child: Row(
                       children: <Widget>[
                         Text(
                           "全部",
                           style: TextStyle(fontSize: 18, color: Colors.white70),
                         ),
                         SizedBox(
                           width: 10,
                         ),
                         SizedBox(
                           width: 6,
                           child: Image.asset(
                             "assets/images/icon_back_right_white_def.png",
                             color: Colors.white70,
                           ),
                         )
                       ],
                     ),
                   ),
                   Text(
                     "0/0",
                     style: TextStyle(color: Colors.white70),
                   )
                 ],
               )
             ),
              SizedBox(
                height: 20,
              ),
              Expanded(
                child: Stack(
                  alignment: Alignment.bottomRight,
                  children: <Widget>[
                    _showListContent(),
                    Container(
                      width: 80,
                      height: 80,
                      color: Colors.red,
                      child: Text("删除"),
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  _showListContent() {
    var datas = List.generate(50, (index) {
      return index.toString();
    });

    return
     Container(
       decoration: BoxDecoration(
           color: Colors.white,
           borderRadius: BorderRadius.only(
               topLeft: Radius.circular(20),
               topRight: Radius.circular(10))),
       margin: EdgeInsets.symmetric(horizontal: 20),
       child:  DragTargetListView(
         padding: EdgeInsets.only(left: 20,top: 10),
         itemBuilder: (BuildContext context, int index) {
           return Container(
//             color: Colors.amberAccent,
             child: SizedBox(
               height: 40,
               child: Text(
                 "当前的index==============    ${index}",
                 style: TextStyle(color: Colors.green),
               ),
             ),
           );
         },
         datas: datas,
       ),
     );
  }

  showEmptyContent() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Image.asset("assets/images/today_empty.png"),
        SizedBox(
          height: 20,
        ),
        Text(
          "还没有清单安排吖！",
          style: TextStyle(color: Colors.black, fontSize: 16),
        ),
        Text(
          "未来可期，提前做好安排",
          style: TextStyle(color: Colors.black26, fontSize: 14),
        )
      ],
    );
  }

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;
}
