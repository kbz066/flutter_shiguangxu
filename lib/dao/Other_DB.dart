

import 'package:flutter_sqlite_orm/entity.dart';

@Entity(nameInDb: "other", propertyList: [
  Property(name: "imageName", type: PropertyType.STRING),
  Property(name: "title", type: PropertyType.STRING),
  Property(name: "isDBData", type: PropertyType.INT),
  Property(name: "bgColor", type: PropertyType.INT),
  Property(name: "id", isPrimary: true, type: PropertyType.INT)

])
class Other_DB{
  int id;
  String imageName;
  String title;
  int bgColor;
  int isDBData;

  Other_DB({this.id,this.imageName, this.title, this.bgColor, this.isDBData});


}