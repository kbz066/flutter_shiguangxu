import 'package:event_bus/event_bus.dart';

class EventBusUtils {
  // 工厂模式
  factory EventBusUtils()=> _getInstance();
  static EventBusUtils get instance => _getInstance();
  static EventBusUtils _instance;
  static EventBus _eventBus;
  EventBusUtils._internal() {
    // 初始化
  }
  static EventBusUtils _getInstance() {
    if (_instance == null) {
      _instance = new EventBusUtils._internal();
      _eventBus=EventBus();

    }

    return _instance;
  }

   EventBus get eventBus => _eventBus;
}