import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_for_shop/app_http/app_url_address.dart';
import 'package:flutter_for_shop/app_http/http.dart';
import 'package:flutter_for_shop/custom/custom_widget/BannerWidget.dart';
import 'package:flutter_for_shop/custom/custom_widget/MyNoticeVecAnimation.dart';
import 'package:flutter_for_shop/infos/app_config.dart';
import 'package:flutter_for_shop/infos/json_bean/app_update_entity.dart';
import 'package:flutter_for_shop/infos/json_bean/home_menu_entity.dart';
import 'package:flutter_for_shop/infos/json_bean/main_banner_entity.dart';
import 'package:flutter_for_shop/infos/json_bean/main_notice_entity.dart';
import 'package:flutter_for_shop/pages/app_webview_page.dart';
import 'package:flutter_for_shop/utils/MyToastUtils.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:package_info/package_info.dart';

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
  List<MainNoticeNlist> _noticeData = [];
  List<BannerItem> bannerList = [];

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
        scrollDirection: Axis.vertical,
        child: Column(
          children: <Widget>[
            Image.asset(
              'assets/main_banner2.png',
              width: ScreenUtil.getInstance().width,
              height: ScreenUtil.getInstance().setHeight(350.0),
              fit: BoxFit.fill,
            ),
            Container(
                width: double.infinity, height: 2.5, color: Colors.black12),
            _topRow(), // 中间两固定菜单
            Container(
                width: double.infinity, height: 2.5, color: Colors.black12),
            _noticeWidget(), // 消息公告栏
            Container(
                width: double.infinity, height: 2.5, color: Colors.black12),
            GridView.count(
              /*scrollDirection: Axis.vertical,*/
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              crossAxisCount: 4,
              crossAxisSpacing: 3.0,
              children: _centerGridData(),
            ),
            BannerWidget(
              110.0,
              bannerList,
              bannerPress: (index, item) {
                MyToastUtils.showToastInCenter('点击了第$index项', 0);
              },
              textBackgroundColor: Colors.transparent,
            )
          ],
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

  Widget _noticeWidget() {
    return Padding(
        padding:
            EdgeInsets.only(left: 15.0, right: 15.0, top: 5.0, bottom: 5.0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Image.asset(
              'assets/main_notice_icon.png',
              width: 20.0,
              height: 20.0,
            ),
            Flexible(
                flex: 1,
                child: MyNoticeVecAnimation(
                  duration: Duration(milliseconds: 3000),
                  messages: _noticeData,
                  itemPress: (index, noticeData) {
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (buildContext) => MyWebView(
                              isBase64Url: true,
                              title: _noticeData[index].title,
                              contentUrl: _noticeData[index].content,
                            )));
                  },
                )),
            Icon(Icons.arrow_forward)
          ],
        ));
  }

  List<Widget> _centerGridData() {
    return _menuList.map((value) {
      return InkWell(
        customBorder:
            Border.all(color: Color.fromRGBO(223, 223, 223, 0.7), width: 1.0),
        onTap: (){_centerMenuClick(value);},
        child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Image.network(value.menuLogo, width: 35.0, height: 35.0),
              SizedBox(height: 12.0),
              Text(value.describes,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(color: Colors.blueGrey))
            ]),
      );
    }).toList();
  }

  @override
  void initState() {
    super.initState();
    PackageInfo.fromPlatform().then((packageInfo) {
      // 检查app是否需要更新
      AppHttp.getInstance().post(servicePathAPI['appUpdate'], data: {
        'version_number': packageInfo.version,
        'os': Config.phoneOs
      }).then((value) async {
        Map appUpdateData = json.decode(value.toString());
        var updateEntity = AppUpdateEntity.fromJson(appUpdateData);
        switch (updateEntity.msg) {
          case '1': // 需要更新
//            AppUpdateUtil.showAppUpdateDialog(
//                context, updateEntity.updateContent, updateEntity.downAndroid);
//            break;
          default:
            setState(() {
              // 首页消息公告栏
              AppHttp.getInstance()
                  .post(servicePathAPI['noticeData'], data: null)
                  .then((value) {
                Map noticeData = json.decode(value.toString());
                _noticeData = MainNoticeEntity.fromJson(noticeData).nList;
              });
              // 读取首页菜单
              AppHttp.getInstance().post(servicePathAPI['homePageUrl'],
                  data: {'roll': '0'}).then((values) {
                setState(() {
                  requestData = values.toString();
                  // 读取首页banner头
                  AppHttp.getInstance().post(servicePathAPI['homePageUrl'],
                      data: {'roll': '1'}).then((values) {
                    setState(() {
                      Map dataMap = json.decode(values.toString());
                      bannerList = (MainBannerEntity.fromJson(dataMap))
                          .homepagelist
                          .map((value) =>
                              BannerItem.defaultBannerItem(value.menuLogo, ''))
                          .toList();
                    });
                  });
                });
              });
            });
            break;
        }
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
  bool get wantKeepAlive => false;

  ///中间菜单点击监听
  _centerMenuClick(HomemanuHomepagelist value) {
    String urlTypeStr = value.menuUrl;
    String titleStr = value.describes;
    switch (urlTypeStr) {
      case '#':
        MyToastUtils.showToastInBottom('敬请期待', 0);
        break;
      default:
        Navigator.of(context).push(MaterialPageRoute(
            builder: (buildContext) => MyWebView()));
        break;
    }
  }
}
