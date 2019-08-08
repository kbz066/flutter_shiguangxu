import 'package:common_utils/common_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_shiguangxu/common/ColorUtils.dart';


class PlanListPage  extends StatefulWidget {
  @override
  PlanListPageState createState() => new PlanListPageState();
}

class PlanListPageState extends State<PlanListPage> with AutomaticKeepAliveClientMixin {
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

          padding: EdgeInsets.only(left: 20, right: 20, top: 20),
          child: Column(
            children: <Widget>[
              Row(
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
              ),
              SizedBox(height: 20,),
              Expanded(
                child: Container(
                  width: double.infinity,
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(10),
                          topRight: Radius.circular(10))),
                  child: _showListContent(),
                ),
              )
            ],
          ),
        ),
      ),
    )

      ;
  }

  _showListContent(){


     return  ReorderableListView(

       children:
           List.generate(20, (index){
             return Container(
               decoration: BoxDecoration(
                 border: Border.all(width: 2,color: Colors.red)
               ),
               height: 50,
                 key: ObjectKey(index),
               child: Text("-------->     $index"),
             );
           }),
       onReorder: (old,news){
         LogUtil.e("执行了    onReorder    $old   $news");
       },
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



