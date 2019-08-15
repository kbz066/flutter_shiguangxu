import 'package:common_utils/common_utils.dart';
import 'package:flutter/material.dart';

class DragTargetListView extends StatefulWidget {
  final IndexedWidgetBuilder itemBuilder;
  final EdgeInsetsGeometry padding;
  final VoidCallback onDragStartedCallback;
  final VoidCallback onDragEndCallback;
  final Function(AnimationController controller) feedbackChange;
  final Function onItemCallback;
  List<dynamic> datas;



  DragTargetListView(
      {@required this.itemBuilder,
      @required this.datas,
      this.padding,
      this.feedbackChange,
      this.onDragEndCallback,this.onDragStartedCallback,this.onItemCallback});

  @override
  _DragTargetListViewState createState() => _DragTargetListViewState();
}

class _DragTargetListViewState extends State<DragTargetListView>
    with TickerProviderStateMixin {
  var _movingValue;

  int moveStartIndex = 0;
  int moveEndIndex = 0;
  bool _needToAnimate = false;
  AnimationController feedbackController;
  AnimationController _slideController;

  @override
  void initState() {
    feedbackController = AnimationController(
      duration: Duration(milliseconds: 300),
      vsync: this,
    );
    _slideController =
        AnimationController(vsync: this, duration: Duration(milliseconds: 200));
    super.initState();
  } // 记录正在移动的数据

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      padding: widget.padding == null ? EdgeInsets.zero : widget.padding,
      itemBuilder: (BuildContext context, int index) {
        Animation<Offset> slideAnimation;
        // 需要动画时，添加一个位移动画
        if (_needToAnimate) {
          slideAnimation = createTargetItemSlideAnimation(index);
        }
      //  LogUtil.e("indexOf------------->  $_movingValue   $index   ${widget.datas.indexOf(_movingValue)}   ${_movingValue != null && widget.datas.indexOf(_movingValue) == index}");
        return

         GestureDetector(
           onTapDown: (details){
             if(widget.onItemCallback!=null){
               widget.onItemCallback(index);
             }
           },
           child:  Opacity(
             opacity:
             _movingValue ==  widget.datas[index]
                 ? 0
                 : 1, //这里控制
             child: buildItemChild(slideAnimation, context, index),
           ),
         );
      },
      itemCount: widget.datas.length,
    );
  }

  // 创建指定item的位移动画
  Animation<Offset> createTargetItemSlideAnimation(int index) {


    Tween<Offset> tween;
    if (moveStartIndex < moveEndIndex) {
      if (index < moveStartIndex || index >= moveEndIndex) {
        return null;
      }
      LogUtil.e("createTargetItemSlideAnimation --------------->   $moveStartIndex   $moveEndIndex $index");
      tween = Tween(begin: Offset(0.0, 1), end: Offset(0.0, 0));
    } else if (moveStartIndex > moveEndIndex) {
      if (index <= moveEndIndex || index > moveStartIndex) {
        return null;
      }
      tween = Tween(begin: Offset(0.0, -1), end: Offset(0.0, 0));
    }

    if (moveStartIndex != moveEndIndex) {
      return tween.animate(
          CurvedAnimation(parent: _slideController, curve: Curves.easeOut));
    }

    return null;
  }

  void startMove(startIndex, endIndex) {

    if (_needToAnimate) {
      return;
    }
    this.moveStartIndex = startIndex;
    this.moveEndIndex = endIndex;

    setState(() {
      final temp = widget.datas[startIndex];
      widget.datas.remove(temp);
      widget.datas.insert(endIndex, temp);
      _needToAnimate = true;
      LogUtil.e(" ${widget.datas}");
    });
    _slideController.forward().whenComplete(() {
      setState(() {
        _needToAnimate = false;
        _slideController.value = 0;
      });
    });
  }

  // 若动画不为空，则添加动画控件
  Widget buildItemChild(
      Animation<Offset> slideAnimation, BuildContext context, int index) {
    if (slideAnimation != null) {
      return SlideTransition(
        position: slideAnimation,
        child: _buildItem(context, index),
      );
    }
    return _buildItem(context, index);
  }

  _buildItem(BuildContext context, int index) {
    var item = widget.itemBuilder(context, index);

    Size _itemSize;
    BuildContext itemContext;
    return LongPressDraggable<dynamic>(
      data: widget.datas[index],
      childWhenDragging: Opacity(
        opacity: 0,
        child: item,
      ),

      feedback: StatefulBuilder(
        builder: (BuildContext context, StateSetter setState) {

          if (widget.feedbackChange != null) {
            widget.feedbackChange(feedbackController);
          }
          return ScaleTransition(
            alignment: Alignment.centerLeft,
            scale: Tween(begin: 1.0, end: 0.6).animate(feedbackController),
            child: Container(
              color: Colors.red,
              child: SizedBox.fromSize(
                child: item,
                size: _itemSize,
              ),
            ),
          );
        },
      ),
      child: DragTarget(
        builder: (BuildContext context, List<dynamic> candidateData,
            List<dynamic> rejectedData) {
          itemContext = context;
          return item;
        },
        onWillAccept: (data) {


          if (_itemSize == null) _itemSize = itemContext.size;
          var startIndex = widget.datas.indexOf(data);

          if (startIndex != index) {
            startMove(startIndex, index);
          }

          return startIndex != index;
        },

        onAccept: (data){
          setState(() {
            this._movingValue = null;
          });
          LogUtil.e("执行   onAccept    ");
        },
        onLeave: (data){
          LogUtil.e("执行   onLeave    ");

        },
      ),

      onDragStarted: () {
        this._movingValue = widget.datas[index];
        if(widget.onDragStartedCallback!=null){
          widget.onDragStartedCallback();
        }
        LogUtil.e("执行   onDragStarted    ");
      },


      onDragEnd: (DraggableDetails details) {
        setState(() {
          this._movingValue = null;
        });
        if(widget.onDragEndCallback!=null){
          widget.onDragEndCallback();
        }
        LogUtil.e("执行   onDragEnd    ");
      },
      onDragCompleted: (){
        if(widget.onDragEndCallback!=null){
          widget.onDragEndCallback();
        }
        LogUtil.e("执行   onDragCompleted    ");
      },
      onDraggableCanceled: (Velocity velocity, Offset offset){
        LogUtil.e("执行   onDraggableCanceled    ");
        setState(() {
          this._movingValue = null;
        });
        if(widget.onDragEndCallback!=null){
          widget.onDragEndCallback();
        }
      },

    );
  }




}
