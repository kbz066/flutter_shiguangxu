import 'package:flutter/material.dart';
import 'package:flutter_shiguangxu/page/config_page/config_page.dart';
import 'package:flutter_shiguangxu/page/today_page/today_page.dart';
import 'package:flutter_shiguangxu/page/home_page/plan_list_page.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  var _currentIndex;

  PageController _pageController;
  List<Widget> pageLists;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _currentIndex = 0;

    _pageController = PageController(initialPage: _currentIndex);
    pageLists = [ToDayPage(), PlanListPage(), ConfigPage()];


  }

  @override
  Widget build(BuildContext context) {

    return         Scaffold(
      body:
      PageView(

        controller: _pageController,
        children: pageLists,
        onPageChanged: this.onPageChanged,
        physics: new NeverScrollableScrollPhysics(),//禁止滑动
      ),
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
        onTap: this.onTap,
      ),
    );
  }

  void onTap(int index) {

    _pageController.animateToPage(index,
        duration: Duration(milliseconds: 300), curve: Curves.linear);

  }

  void onPageChanged(int index) {

    setState(() {
      _currentIndex = index;
    });
  }


}
