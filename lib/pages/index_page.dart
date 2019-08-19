import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_for_shop/pages/main/app_cart_page.dart';
import 'package:flutter_for_shop/pages/main/app_category_page.dart';
import 'package:flutter_for_shop/pages/main/app_home_page.dart';
import 'package:flutter_for_shop/pages/main/app_member_page.dart';

class IndexPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return IndexPageState();
  }
}

class IndexPageState extends State<IndexPage> {
  /// 初始化选中页面的下标
  int currentIndex = 0;

  /// 选中的页面
  var currentPage;

  /// 初始化项目底部导航菜单
  final List<BottomNavigationBarItem> bottomTabs = [
    BottomNavigationBarItem(icon: Icon(CupertinoIcons.home), title: Text('首页')),
    BottomNavigationBarItem(
        icon: Icon(CupertinoIcons.search), title: Text('分类')),
    BottomNavigationBarItem(
        icon: Icon(CupertinoIcons.shopping_cart), title: Text('购物车')),
    BottomNavigationBarItem(
        icon: Icon(CupertinoIcons.profile_circled), title: Text('会员中心')),
  ];

  /// 初始化app底部导航菜单跳转的route组件
  final List<Widget> tabBodies = [
    MyHomePage(
      title: '首页',
    ),
    CategoryPage(title: '分类'),
    CartPage(
      title: '购物车',
    ),
    MemberPage(
      title: '会员中心',
    )
  ];

  @override
  void initState() {
    currentPage = tabBodies[currentIndex];
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      backgroundColor: Color.fromRGBO(244, 245, 245, 1.0),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        currentIndex: currentIndex,
        items: bottomTabs,
        onTap: (index) {
          setState(() {
            currentIndex = index;
            currentPage = tabBodies[currentIndex];
          });
        },
      ),
      body: currentPage,
    );
  }
}
