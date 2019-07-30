import 'package:flutter/material.dart';

typedef Widget BuildWidget(BuildContext context,State state);

enum MixinType {
  none,

  single,
  ordinary


}

abstract class BaseStateView extends StatefulWidget {


  MixinType mixinType;


  BaseStateView({this.mixinType=MixinType.none});

  void initView();
  Widget buildWidget(BuildContext context,State state);

  void dispose();

  @override
  State createState() {
    if(mixinType==MixinType.single){
      return   _BaseStateViewSingleTickerState(this.buildWidget, this.initView, this.dispose);

    }else if((mixinType==MixinType.ordinary)){
      return   _BaseStateViewTickerState(this.buildWidget, this.initView, this.dispose);
    }else{
      return   _BaseStateViewState(this.buildWidget, this.initView, this.dispose);
    }
  }

}

class _BaseStateViewState extends State<BaseStateView>  with SingleTickerProviderStateMixin{
  BuildWidget _buildWidget;
  VoidCallback _initView;
  VoidCallback _dispose;

  _BaseStateViewState(this._buildWidget, this._initView, this._dispose);

  @override
  Widget build(BuildContext context) {
    return _buildWidget(context,this);
  }

  @override
  void initState() {
    // TODO: implement initState
    _initView();
    super.initState();
  }

  @override
  void dispose() {
    _dispose();
    super.dispose();
  }
}

class _BaseStateViewSingleTickerState extends State<BaseStateView>  with SingleTickerProviderStateMixin{
  BuildWidget _buildWidget;
  VoidCallback _initView;
  VoidCallback _dispose;

  _BaseStateViewSingleTickerState(this._buildWidget, this._initView, this._dispose);

  @override
  Widget build(BuildContext context) {
    return _buildWidget(context,this);
  }

  @override
  void initState() {
    // TODO: implement initState
    _initView();
    super.initState();
  }

  @override
  void dispose() {
    _dispose();
    super.dispose();
  }
}

class _BaseStateViewTickerState extends State<BaseStateView>  with TickerProviderStateMixin{
  BuildWidget _buildWidget;
  VoidCallback _initView;
  VoidCallback _dispose;

  _BaseStateViewTickerState(this._buildWidget, this._initView, this._dispose);

  @override
  Widget build(BuildContext context) {
    return _buildWidget(context,this);
  }

  @override
  void initState() {
    // TODO: implement initState
    _initView();
    super.initState();
  }

  @override
  void dispose() {
    _dispose();
    super.dispose();
  }
}