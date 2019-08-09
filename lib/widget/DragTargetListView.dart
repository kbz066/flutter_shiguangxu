import 'package:common_utils/common_utils.dart';
import 'package:flutter/material.dart';

class DragTargetListView extends StatefulWidget {
  final IndexedWidgetBuilder itemBuilder;
  final EdgeInsetsGeometry padding;
  List<dynamic> datas;

  DragTargetListView(
      {@required this.itemBuilder, @required this.datas, this.padding});

  @override
  _DragTargetListViewState createState() => _DragTargetListViewState();
}

class _DragTargetListViewState extends State<DragTargetListView> {
  var _movingValue; // 记录正在移动的数据

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      padding: widget.padding == null ? EdgeInsets.zero : widget.padding,
      itemBuilder: (BuildContext context, int index) {
//        LogUtil.e(
//            "indexOf------------->  $_movingValue    ${widget.datas.indexOf(_movingValue)}   ${_movingValue != null && widget.datas.indexOf(_movingValue) == index}");
        return Opacity(
          opacity: _movingValue != null &&
                  widget.datas.indexOf(_movingValue) == index
              ? 0
              : 1, //这里控制
          child: _buildItem(context, index),
        );
      },
      itemCount: widget.datas.length,
    );
  }

  _buildItem(BuildContext context, int index) {
    BuildContext contents;
    return LongPressDraggable<dynamic>(
      data: widget.datas[index],
//      childWhenDragging: Container(),
      feedback: DefaultTextStyle(
        style: DefaultTextStyle.of(context).style,
        child: widget.itemBuilder(context, index),
      ),
      child: DragTarget(
        builder: (BuildContext context, List<dynamic> candidateData,
            List<dynamic> rejectedData) {
          contents = context;
          return widget.itemBuilder(context, index);
        },
        onWillAccept: (data){
          LogUtil.e("onWillAccept-----------。   ");
          return true;
        },
      ),
      onDragStarted: () => _onDragStarted(index, contents),
      onDraggableCanceled: _onDraggableCanceled,
      onDragEnd:(DraggableDetails details){
        LogUtil.e("onDragEnd-----------。   ");
        setState(() {
          this._movingValue =null;
        });
      } ,
    );
  }

  _onDraggableCanceled(velocity, offset) {

    LogUtil.e("_onDraggableCanceled-----------。   ");
    setState(() {
      this._movingValue = null;
    });
  }

  _onDragStarted(index, BuildContext contents) {
    LogUtil.e("_onDragStarted-----------。   $index  ${contents.size}");
    setState(() {
      this._movingValue = widget.datas[index];
    });
  }
}
