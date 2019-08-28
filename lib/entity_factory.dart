import 'package:flutter_shiguangxu/entity/user_entity.dart';
import 'package:flutter_shiguangxu/entity/sechedule_entity.dart';

class EntityFactory {
  static T generateOBJ<T>(json) {
    if (1 == 0) {
      return null;
    } else if (T.toString() == "RegisterEntity") {
      return UserData.fromJson(json) as T;
    } else if (T.toString() == "SecheduleEntity") {
      return SecheduleEntity.fromJson(json) as T;
    } else {
      return null;
    }
  }
}