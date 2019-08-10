import 'package:flutter/material.dart';



class TestPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: 'Flutter Demo',
      theme: new ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: new Scaffold(
          appBar: new AppBar(
            title: new Text("DraggableDemo"),
          ),
          body: MyDraggable()),//用于测试Draggable的Widget
    );
  }
}
class MyDraggable extends StatelessWidget {
  final data;
  const MyDraggable({this.data = "MyDraggable", Key key}) : super(key: key);
  @override
  Widget build(BuildContext context) {

    return ListView(
      children: List.generate(20, (index){
        return Draggable(
          data: data,
          child: Text('Draggable  $index'),
          feedback: Container(
            width: 150.0,
            height: 150.0,
            color: Colors.blue[500],
            child: Text('aaaaaaaaaaaa  $index'),
          ),
        );
      }),
    ) ;
  }
}