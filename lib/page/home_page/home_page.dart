import 'package:flutter/material.dart';
import 'package:flutter_shiguangxun/page/home_page/today_page.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  var _currentIndex;

  List<Widget> pageLists;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _currentIndex = 0;
    pageLists = [ToDayPage(), ToDayPage(), ToDayPage()];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: pageLists[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        selectedItemColor: Colors.blue,
        unselectedItemColor: Colors.black12,
        items: [
          BottomNavigationBarItem(
            title: Text("今日", style: TextStyle(fontSize: 12)),
            icon: Image.asset("assets/images/tab_icon_rc_def.png"),
            activeIcon: Image.asset("assets/images/tab_icon_rc_sel.png"),
          ),
          BottomNavigationBarItem(
            title: Text("清单", style: TextStyle(fontSize: 12)),
            icon: Image.asset("assets/images/tab_icon_plan_sel.png"),
            activeIcon: Image.asset("assets/images/tab_icon_plan_def.png"),
          ),
          BottomNavigationBarItem(
            title: Text("我的", style: TextStyle(fontSize: 12)),
            icon: Image.asset("assets/images/tab_icon_my_def.png"),
            activeIcon: Image.asset("assets/images/tab_icon_my_sel.png"),
          )
        ],
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
      ),
    );
  }
}
