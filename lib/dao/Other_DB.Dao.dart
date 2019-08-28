// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// EntityGenerator
// **************************************************************************

///other表
import 'package:flutter_sqlite_orm/db_manager.dart';
import 'package:flutter_sqlite_orm/entity.dart';
import 'package:flutter_shiguangxu/dao/Other_DB.dart';
import 'package:flutter_sqlite_orm/Dao.dart';
import 'package:flutter_sqlite_orm/query.dart';

class Other_DB_Dao extends Dao<Other_DB> {
  static List propertyMapList = [
    {
      "name": "imageName",
      "type": {"value": "TEXT"},
      "isPrimary": false
    },
    {
      "name": "title",
      "type": {"value": "TEXT"},
      "isPrimary": false
    },
    {
      "name": "isDBData",
      "type": {"value": "INT"},
      "isPrimary": false
    },
    {
      "name": "bgColor",
      "type": {"value": "INT"},
      "isPrimary": false
    },
    {
      "name": "id",
      "type": {"value": "INT"},
      "isPrimary": true
    }
  ];

  ///初始化数据库
  static Future<bool> init() async {
    DBManager dbManager = DBManager.getInstance();
    List<Map> maps = await await dbManager.db
        .query("sqlite_master", where: " name = 'other'");
    if (maps == null || maps.length == 0) {
      await dbManager.db.execute(
          "CREATE TABLE other(imageName  TEXT,title  TEXT,isDBData  INT,bgColor  INT,id  INT PRIMARY KEY)");
    }
    return true;
  }

  ///查询表中所有数据
  static Future<List<Other_DB>> queryAll() async {
    DBManager dbManager = DBManager.getInstance();
    List<Other_DB> entityList = List();
    Other_DB_Dao entityDao = Other_DB_Dao();
    List<Map> maps = await dbManager.db.query("other");
    for (Map map in maps) {
      entityList.add(entityDao.formMap(map));
    }
    return entityList;
  }

  ///增加一条数据
  static Future<bool> insert(Other_DB entity) async {
    DBManager dbManager = DBManager.getInstance();
    Other_DB_Dao entityDao = Other_DB_Dao();
    await dbManager.db.insert("other", entityDao.toMap(entity));
    return true;
  }

  ///增加多条条数据
  static Future<bool> insertList(List<Other_DB> entityList) async {
    DBManager dbManager = DBManager.getInstance();
    List<Map> maps = List();
    Other_DB_Dao entityDao = Other_DB_Dao();
    for (Other_DB entity in entityList) {
      maps.add(entityDao.toMap(entity));
    }
    await dbManager.db.rawInsert("other", maps);
    return true;
  }

  ///更新数据
  static Future<int> update(Other_DB entity) async {
    DBManager dbManager = DBManager.getInstance();
    Other_DB_Dao entityDao = Other_DB_Dao();
    return await dbManager.db.update("other", entityDao.toMap(entity),
        where: 'id = ?', whereArgs: [entity.id]);
  }

  ///删除数据
  static Future<int> delete(Other_DB entity) async {
    DBManager dbManager = DBManager.getInstance();
    return await dbManager.db
        .delete("other", where: 'id = ?', whereArgs: [entity.id]);
  }

  ///map转为entity
  @override
  Other_DB formMap(Map map) {
    Other_DB entity = Other_DB();
    entity.imageName = map['imageName'];
    entity.title = map['title'];
    entity.isDBData = map['isDBData'];
    entity.bgColor = map['bgColor'];
    entity.id = map['id'];
    return entity;
  }

  ///entity转为map
  @override
  Map toMap(Other_DB entity) {
    var map = Map<String, dynamic>();
    map['imageName'] = entity.imageName;
    map['title'] = entity.title;
    map['isDBData'] = entity.isDBData;
    map['bgColor'] = entity.bgColor;
    map['id'] = entity.id;
    return map;
  }

  @override
  String getTableName() {
    return "other";
  }

  static QueryProperty IMAGENAME = QueryProperty(name: 'imageName');
  static QueryProperty TITLE = QueryProperty(name: 'title');
  static QueryProperty ISDBDATA = QueryProperty(name: 'isDBData');
  static QueryProperty BGCOLOR = QueryProperty(name: 'bgColor');
  static QueryProperty ID = QueryProperty(name: 'id');

  static Query queryBuild() {
    Query query = Query(Other_DB_Dao());
    return query;
  }
}

///查询条件生成
class QueryProperty {
  String name;
  QueryProperty({this.name});
  QueryCondition equal(dynamic queryValue) {
    QueryCondition queryCondition = QueryCondition();
    queryCondition.key = name;
    queryCondition.value = queryValue;
    return queryCondition;
  }
}
