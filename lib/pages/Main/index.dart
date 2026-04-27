import 'package:flutter/material.dart';
import 'package:shop/pages/Cart/index.dart';
import 'package:shop/pages/Home/index.dart';
import 'package:shop/pages/Menu/index.dart';
import 'package:shop/pages/Person/index.dart';

class MainPage extends StatefulWidget {
  MainPage({Key? key}) : super(key: key);

  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  final List<Map<String, String>> _tabList = [
    {
      "icon": "lib/assets/home_normal.png",
      "active_icon": "lib/assets/home_active.png",
      "label": "首页",
    },
    {
      "icon": "lib/assets/cart_normal.png",
      "active_icon": "lib/assets/cart_active.png",
      "label": "购物车",
    },
    {
      "icon": "lib/assets/person_normal.png",
      "active_icon": "lib/assets/person_active.png",
      "label": "我的",
    },
    {
      "icon": "lib/assets/menu_normal.png",
      "active_icon": "lib/assets/menu_active.png",
      "label": "菜单",
    },
  ];
  int _currentIndex = 0;
  List<Widget> _getChildren() {
    return [HomeView(), CartView(), PersonView(), MenuView()];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: IndexedStack(
          index: _currentIndex,
          children: _getChildren(),
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        showUnselectedLabels: true,
        selectedItemColor: Colors.red,
        unselectedItemColor: Colors.grey,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
        currentIndex: _currentIndex,
        items: _getTabBarWidget(),
      ),
    );
  }

  List<BottomNavigationBarItem> _getTabBarWidget() {
    return List.generate(
        _tabList.length,
        (index) => BottomNavigationBarItem(
              icon: Image.asset(
                _tabList[index]["icon"]!,
                width: 30,
                height: 30,
              ),
              activeIcon: Image.asset(
                _tabList[index]["active_icon"]!,
                width: 30,
                height: 30,
              ),
              label: _tabList[index]["label"]!,
            ));
  }
}
