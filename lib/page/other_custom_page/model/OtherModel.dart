import 'package:flutter_shiguangxu/base/BaseModel.dart';
import 'package:flutter_shiguangxu/common/Constant.dart';
import 'package:flutter_shiguangxu/dao/Other_DB.Dao.dart';
import 'package:flutter_shiguangxu/dao/Other_DB.dart';
import 'package:flutter_sqlite_orm/db_manager.dart';

class OtherModel extends BaseModel {
  Future<List<Other_DB>> getOtherListData() async {
    var list = (await Other_DB_Dao.queryAll());
    await Future.delayed(Duration(seconds: 10));
    if (list.length == 0) {
      var datas = Constant.OTHER_DATA;
      return Future.value(datas.map((item) {
        return Other_DB(
            id: datas.indexOf(item),
            imageName: item.keys.first,
            title: item.values.first);
      }).toList());
    }


    print("查询 other   ${(await Other_DB_Dao.queryAll()).length}");

    return list;
  }
}
