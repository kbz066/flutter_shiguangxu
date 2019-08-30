 import 'package:flutter_shiguangxu/base/BaseModel.dart';
import 'package:flutter_shiguangxu/base/BasePresenter.dart';

class QuadrantPresenter extends BasePresenter{
  QuadrantPresenter() : super(null);

  var currentPageIndex = 1;
  var month=[DateTime.now().month-1,DateTime.now().month,DateTime.now().month+1];
  var week=[1,(DateTime.now().day/7).ceil()>4?4:(DateTime.now().day/7).ceil(),1];


  void updateWeek(index){
    this.week[currentPageIndex]=index;
    notifyListeners();
  }
  void updatePageIndex(index){
    this.currentPageIndex=index;
    notifyListeners();
  }


}