import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_for_shop/custom/customRouteAnimator/CustomRouteRotationScaleTransition.dart';
import 'package:flutter_for_shop/pages/main/app_cart_page.dart';
import 'package:flutter_for_shop/pages/main/app_category_page.dart';
import 'package:flutter_for_shop/pages/main/app_find_page.dart';
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

  /// 初始化app底部导航菜单跳转的route组件
  final List<Widget> tabBodies = [
    MyHomePage(
      title: '首页',
    ),
    CategoryPage(title: '升级'),
    CartPage(
      title: '分享',
    ),
    MemberPage(
      title: '我的',
    )
  ];

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      backgroundColor: Color.fromRGBO(244, 245, 245, 1.0),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context)
              .push(CustomRouteRotationScaleTransition(CenterFindPage(
            title: '发现',
          )));
        },
        tooltip: '发现',
        child: Icon(
          CupertinoIcons.eye_solid,
          color: Colors.white,
        ),
      ),
      bottomNavigationBar: BottomAppBar(
        elevation: 10.0,
        shape: CircularNotchedRectangle(),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          mainAxisSize: MainAxisSize.max,
          children: <Widget>[
            bottomItemWidget(CupertinoIcons.home, '首页', 0),
            bottomItemWidget(CupertinoIcons.search, '升级', 1),
            bottomItemWidget(null, '', 8), // 此控件实质作用就是为了中间空出容留突出按钮的间距
            bottomItemWidget(CupertinoIcons.shopping_cart, '分享', 2),
            bottomItemWidget(CupertinoIcons.profile_circled, '我的', 3),
          ],
        ),
      ),
      body: IndexedStack( //添加IndexedStack, 解决页面设置了保持状态后无效的问题
          index: currentIndex,
          children: tabBodies),
    );
  }

  /// 底部菜单样式统一化处理
  Widget bottomItemWidget(var bottomIcon, String bottomTitle, int index) {
    return Expanded(
      flex: 1, // 设置每个菜单的权重都是一份（平分）
      child: GestureDetector(
        child: Container(
          width: double.infinity, // 设置子控件宽度填充
          padding: EdgeInsets.only(top: 5.0, bottom: 5.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Icon(bottomIcon,
                  color: currentIndex == index ? Colors.pink : Colors.blueGrey),
              Text(bottomTitle,
                  style: TextStyle(
                      color:
                          currentIndex == index ? Colors.pink : Colors.blueGrey,
                      fontWeight: currentIndex == index
                          ? FontWeight.bold
                          : FontWeight.normal))
            ],
          ),
        ),
        onTap: () {
          if (index != 8) {
            setState(() {
              currentIndex = index;
            });
          }
        },
      ),
    );
  }
}
