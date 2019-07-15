import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Test extends StatefulWidget {
  @override
  TestState createState() => new TestState();
}

class TestState extends State<Test> {
  ScrollController _controller;
  double dy;
  double height = 60;

  @override
  void initState() {
    super.initState();
    _controller = ScrollController();
  } // 列表项

  Widget _buildListItem(BuildContext context, int index) {
    return ListTile(title: Text('list tile index $index'));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Demo'),
      ),
      body: NotificationListener(
//          onNotification: (notification){
//            //print(notification);
//            switch (notification.runtimeType){
//              case ScrollStartNotification: print("开始滚动"); break;
//              case ScrollUpdateNotification: print("正在滚动"); break;
//              case ScrollEndNotification: print("滚动停止"); break;
//              case OverscrollNotification: print("滚动到边界"); break;
//            }
//            return true;
//          },
        child: Listener(
          onPointerDown: (PointerDownEvent event) {
            dy = event.position.dy;
          },
          onPointerMove: (PointerMoveEvent event) {
            if (_controller.offset == 0&&height<120) {
              setState(() {
                height = height + (event.position.dy - dy) * 0.01;
                print(
                    "onPointerMove滑动信息   ${height}  ${event.position.dy - dy}   ${event.position.dy}");
              });
            }
            print("onPointerMove滑动信息22     ${_controller.offset}  ");
          },
          onPointerUp: (PointerUpEvent details) {
            print("抬起手指${_controller.offset}");
            if (60 <= _controller.offset && _controller.offset <= 120) {
//            _controller.animateTo(0,
//                duration: Duration(milliseconds: 300), curve: Curves.linear);
            }
          },
          child: CustomScrollView(
            controller: _controller,
            slivers: <Widget>[
              // 如果不是Sliver家族的Widget，需要使用SliverToBoxAdapter做层包裹
              SliverToBoxAdapter(
                child: Container(
                  alignment: Alignment.center,
                  height: height,
                  color: Colors.green,
                  child: Text('HeaderView'),
                ),
              ),
              // 当列表项高度固定时，使用 SliverFixedExtendList 比 SliverList 具有更高的性能
              SliverFixedExtentList(
                  delegate: SliverChildBuilderDelegate(_buildListItem,
                      childCount: 30),
                  itemExtent: 48.0)
            ],
          ),
        ),
      ),
    );
  }
}
