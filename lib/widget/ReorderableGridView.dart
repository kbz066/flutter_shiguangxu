import 'package:common_utils/common_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_shiguangxu/dao/Other_DB.dart';

class ReorderableGridView extends StatefulWidget {
  final SliverGridDelegate delegate;
  final IndexedWidgetBuilder itemBuilder;

  final List<int> moveItems = [];

  bool showAdd = false;
  List datas;

  ReorderableGridView(
      {@required this.delegate,
      @required this.itemBuilder,
      @required this.datas,
      this.showAdd});

  @override
  ReorderableGridViewState createState() => new ReorderableGridViewState();
}

class ReorderableGridViewState extends State<ReorderableGridView>
    with TickerProviderStateMixin {
  AnimationController _slideController;
  int moveStartIndex = 0;
  int moveEndIndex = 0;
  Size _itemSize;
  var _movingValue; // 记录正在移动的数据
  bool _needToAnimate = false;

  @override
  Widget build(BuildContext context) {
    var datas = widget.datas;

    return GridView.custom(
        gridDelegate: widget.delegate,
        childrenDelegate: new SliverChildBuilderDelegate(
          (context, index) {

            if (widget.showAdd) {

              return widget.itemBuilder(context, index);
            }

            Animation<Offset> slideAnimation;
            // 需要动画时，添加一个位移动画
            if (_needToAnimate) {
              slideAnimation = createTargetItemSlideAnimation(index);
            }
            LogUtil.e("isHide---- start---------->  ");
            var isHide = _movingValue == datas[index];

            LogUtil.e("isHide-------------->  ${isHide}");
            return isHide
                ? Container()
                : _GridItem(
                    index,
                    widget.itemBuilder(context, index),
                    datas,
                    slideAnimation,
                    this.startMove,
                    this.updateMovingValue,
                    this.isRunMoveAni,
                    onItemBuild: itemBuildCallBack,
                  );
          },
          childCount: widget.showAdd == false
              ? widget.datas.length
              : widget.datas.length + 1,
        ));
  }

  @override
  void initState() {
    _slideController =
        AnimationController(vsync: this, duration: Duration(milliseconds: 200));
    super.initState();
  }

  // 首次触发时，计算item所占空间的大小，用于计算位移动画的位置
  void itemBuildCallBack(Size size) {
    if (_itemSize == null) {
      _itemSize = size;
    }
  }

  bool isRunMoveAni() {
    return _needToAnimate;
  }

  void updateMovingValue(value, {bool update = false}) {
    if (update) {
      setState(() {
        this._movingValue = value;
      });
    } else {
      this._movingValue = value;
    }
  }

  void startMove(startIndex, endIndex) {
    if (_needToAnimate) {
      return;
    }
    this.moveStartIndex = startIndex;
    this.moveEndIndex = endIndex;

    setState(() {
      _needToAnimate = true;
      final temp = widget.datas[startIndex];
      widget.datas.remove(temp);
      widget.datas.insert(endIndex, temp);
      _needToAnimate = true;
    });
    _slideController.forward().whenComplete(() {
      setState(() {
        _needToAnimate = false;
        _needToAnimate = false;
        _slideController.value = 0;
      });
    });
  }

  // 创建指定item的位移动画
  Animation<Offset> createTargetItemSlideAnimation(int index) {
    Tween<Offset> tween;
    if (moveStartIndex < moveEndIndex) {
      if (index < moveStartIndex || index >= moveEndIndex) {
        return null;
      }
      tween = Tween(
          begin: getTargetOffset(index + 1, index), end: Offset(0.0, 0.0));
    } else if (moveStartIndex > moveEndIndex) {
      if (index <= moveEndIndex || index > moveStartIndex) {
        return null;
      }
      tween = Tween(
          begin: getTargetOffset(index - 1, index), end: Offset(0.0, 0.0));
    }

    if (moveStartIndex != moveEndIndex) {
      return tween.animate(
          CurvedAnimation(parent: _slideController, curve: Curves.easeOut));
    }

    return null;
  }

  // 返回动画的位置
  Offset getTargetOffset(int startIndex, int endIndex) {
    SliverGridDelegateWithFixedCrossAxisCount delegate = widget.delegate;

    int horizionalSeparation = (startIndex % delegate.crossAxisCount) -
        (endIndex % delegate.crossAxisCount);
    int verticalSeparation = (startIndex ~/ delegate.crossAxisCount) -
        (endIndex ~/ delegate.crossAxisCount);

    double dx = (delegate.crossAxisSpacing + _itemSize.width) *
        horizionalSeparation /
        _itemSize.width;
    double dy = (delegate.mainAxisSpacing + _itemSize.height) *
        verticalSeparation /
        _itemSize.width;

    return Offset(dx, dy);
  }

  @override
  void dispose() {
    _slideController.dispose();
    super.dispose();
  }
}

class _GridItem extends StatefulWidget {
  final int index;

  final Widget child;
  final List<dynamic> datas;

  final Animation<Offset> slideAnimation;
  final bool Function() isRunMoveAni;

  final void Function(Size size) onItemBuild;
  final void Function(int start, int end) startMove;
  final void Function(dynamic value, {bool update}) updateMovingValue;

  _GridItem(this.index, this.child, this.datas, this.slideAnimation,
      this.startMove, this.updateMovingValue, this.isRunMoveAni,
      {this.onItemBuild});

  @override
  State<StatefulWidget> createState() {
    return _GridItemState();
  }
}

class _GridItemState extends State<_GridItem> with TickerProviderStateMixin {
  Size _size;

  @override
  void initState() {
    super.initState();
    // 获取当前控件的size属性,当渲染完成之后，自动回调,无需unregist
    WidgetsBinding.instance.addPostFrameCallback(onAfterRender);
  }

  @override
  void didUpdateWidget(_GridItem oldWidget) {
    super.didUpdateWidget(oldWidget);
    // 获取当前控件的size属性,当渲染完成之后，自动回调,无需unregist
    WidgetsBinding.instance.addPostFrameCallback(onAfterRender);
  }

  void onAfterRender(Duration timeStamp) {
    _size = context.size;
    widget.onItemBuild(_size);
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      child: buildItem(context),
      onTap: () {},
    );
  }

  Widget buildItem(BuildContext context) {
    return buildItemChild();
  }

  // 若动画不为空，则添加动画控件
  Widget buildItemChild() {
    if (widget.slideAnimation != null) {
      return SlideTransition(
        position: widget.slideAnimation,
        child: buildDragTarget(),
      );
    }
    return buildDragTarget();
  }

  Widget buildDragTarget() {

    LogUtil.e("buildDragTarget----------------------->  ${widget.index}");
    return LongPressDraggable<dynamic>(
            data: widget.datas[widget.index],
            child: DragTarget(
              builder: (BuildContext context, List<dynamic> candidateData,
                  List<dynamic> rejectedData) {
                return widget.child;
              },
              onWillAccept: (data) {
                var startIndex = widget.datas.indexOf(data);

                if (startIndex != widget.index) {
                  widget.startMove(startIndex, widget.index);
                }

                return startIndex != null &&
                    startIndex !=
                        widget.index; //当Draggable传递过来的dada不是null的时候 决定接收该数据。
              },
              onAccept: (data) {
                widget.updateMovingValue(null);
              },
            ),
            childWhenDragging: Container(),
            feedback:  widget.child,
            onDragStarted: () {
              widget.updateMovingValue(widget.datas[widget.index]);
            },
            onDraggableCanceled: (velocity, offset) {
              widget.updateMovingValue(null, update: true);
            },
          );
  }
}
