import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_for_shop/app_http/app_url_address.dart';
import 'package:flutter_for_shop/app_http/http.dart';
import 'package:flutter_for_shop/infos/json_bean/home_menu_entity.dart';
import 'package:flutter_for_shop/utils/MyToastUtils.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage>
    with AutomaticKeepAliveClientMixin {
  String requestData = '';
  List<HomemanuHomepagelist> _menuList;

  bool showWaitingDialog() {
    if (requestData.isEmpty) {
      return true;
    }
    Map menuMap = json.decode(requestData);
    var homeMenuEntity = HomeMenuEntity.fromJson(menuMap);
    _menuList = homeMenuEntity.homepagelist;
    return false;
  }

  Widget getWaitingDialog() {
    return Center(
      child: CircularProgressIndicator(),
    );
  }

  Widget getBody() {
    if (showWaitingDialog()) {
      return getWaitingDialog();
    } else {
      return SingleChildScrollView(
        child: Container(
          width: ScreenUtil.getInstance().width,
          height: ScreenUtil.getInstance().height,
          child: Column(
            children: <Widget>[
              Image.asset(
                'assets/main_banner2.png',
                width: ScreenUtil.getInstance().width,
                height: ScreenUtil.getInstance().setHeight(350.0),
                fit: BoxFit.fill,
              ),
              Container(
                  width: ScreenUtil.getInstance().width,
                  height: 2.0,
                  color: Colors.black12),
              _topRow(),
              GridView.count(
                crossAxisCount: 3,
                childAspectRatio: 1.0,
                children: <Widget>[
                  Icon(Icons.ac_unit),
                  Icon(Icons.airport_shuttle),
                  Icon(Icons.all_inclusive),
                  Icon(Icons.beach_access),
                  Icon(Icons.cake),
                  Icon(Icons.free_breakfast),
                ],
              )
            /*GridView.count(
                physics: NeverScrollableScrollPhysics(),
                childAspectRatio: 11/16,
                crossAxisCount: 4,
                mainAxisSpacing: 3.0,
                crossAxisSpacing: 3.0,
                children: _centerGridData(),
              )*/
            ],
          ),
        ),
      );
    }
  }

  Row _topRow() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: <Widget>[
        Expanded(
            flex: 1,
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  ListTile(
                    onTap: () {
                      MyToastUtils.showToastInCenter('收款', 0);
                    },
                    leading: Image.asset('assets/shoukuan_icon.png',
                        width: 25.0, height: 25.0),
                    title: Text(
                      '收款',
                      style: TextStyle(
                          fontSize: 16.0, fontWeight: FontWeight.bold),
                    ),
                    subtitle: Text(
                      '随时随地\t\t收款无忧',
                      style: TextStyle(fontSize: 12.0, color: Colors.blueGrey),
                    ),
                  )
                ])),
        Container(
          color: Colors.black12,
          width: 1.0,
          height: 30.0,
        ),
        Expanded(
            flex: 1,
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  ListTile(
                    onTap: () {
                      MyToastUtils.showToastInCenter('还款', 0);
                    },
                    leading: Image.asset('assets/repay_icon.png',
                        width: 25.0, height: 25.0),
                    title: Text(
                      '还款',
                      style: TextStyle(
                          fontSize: 16.0, fontWeight: FontWeight.bold),
                    ),
                    subtitle: Text(
                      '随时随地\t\t还款无忧',
                      style: TextStyle(fontSize: 12.0, color: Colors.blueGrey),
                    ),
                  )
                ]))
      ],
    );
  }

  List<Widget> _centerGridData() {
    return _menuList.map((value) {
      GestureDetector(
          onTap: () {
            MyToastUtils.showToastInCenter(value.menuId.toString(), 0);
          },
          child: Container(
              child: Column(mainAxisSize: MainAxisSize.min, children: <Widget>[
                Image.network(value.menuLogo, width: 35.0, height: 35.0),
                SizedBox(height: 12.0),
                Text(value.describes)
              ]),
              decoration: BoxDecoration(
                  border: Border.all(
                      color: Color.fromRGBO(233, 233, 233, 0.9), width: 1.0))));
    }).toList();
  }

  @override
  void initState() {
    super.initState();
    AppHttp.getInstance().post(servicePathAPI['homePageUrl'],
        data: {'roll': '0'}).then((values) {
      setState(() {
        requestData = values.toString();
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: getBody(),
    );
  }

  @override
  bool get wantKeepAlive => true;
}
