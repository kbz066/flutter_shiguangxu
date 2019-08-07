import 'package:common_utils/common_utils.dart';
import 'package:flutter_shiguangxu/base/BaseModel.dart';
import 'package:flutter_shiguangxu/common/Constant.dart';
import 'package:flutter_shiguangxu/dao/Other_DB.Dao.dart';
import 'package:flutter_shiguangxu/dao/Other_DB.dart';
import 'package:flutter_sqlite_orm/db_manager.dart';

class OtherModel extends BaseModel {
  Future<List<Other_DB>> getOtherListData() async {
    var dbLists = (await Other_DB_Dao.queryAll());
    var datas = Constant.OTHER_DATA;
//    await Future.delayed(Duration(seconds: 10));



    List<Other_DB> initialList=datas.map((item) {
      return Other_DB(
          id: datas.indexOf(item),
          imageName: item.keys.first,
          title: item.values.first);
    }).toList();


    if (dbLists.length == 0) {

      return initialList;
    }else{
      print("查询 other   ${(await Other_DB_Dao.queryAll()).length}");

      for(int i=0;i<dbLists.length;i++){
        dbLists[i].id=datas.length-1+i;
      }
      initialList.addAll(dbLists);

      return initialList;
    }





  }


  Future addOther(int color,String title,String imageName){
    return Other_DB_Dao.insert(Other_DB(isDBData: 1,title: title,bgColor: color,imageName: imageName));
  }
}
