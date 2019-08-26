import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_easyrefresh/easy_refresh.dart';
import 'package:flutter_for_shop/app_http/app_url_address.dart';
import 'package:flutter_for_shop/app_http/http.dart';
import 'package:flutter_for_shop/infos/app_config.dart';
import 'package:flutter_for_shop/infos/json_bean/shared_link_logo_entity.dart';
import 'package:transparent_image/transparent_image.dart';

class CartPage extends StatefulWidget {
  CartPage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return CartPageState();
  }
}

class CartPageState extends State<CartPage>
    with AutomaticKeepAliveClientMixin<CartPage> {
  EasyRefreshController _controller;
  String requestStr = '';
  List<SharedLinkLogoData> shareLinkLogoData = [];

  @override
  initState() {
    _controller = EasyRefreshController();
    getShareData(false);
    super.initState();
  }

  void getShareData(bool isRefresh) {
    AppHttp.getInstance()
        .post(servicePathAPI['shareAppLinkLogo'], data: null)
        .then((values) {
      setState(() {
        requestStr = values;
      });
      if (isRefresh) {
        print('----已刷新数据----');
        _controller.resetLoadState();
        _controller.finishRefresh(success: true);
      }
    });
  }

  bool showWaitingDialog() {
    if (requestStr.isEmpty) {
      return true;
    }
    Map dataMap = json.decode(requestStr.toString());
    SharedLinkLogoEntity entity = SharedLinkLogoEntity.fromJson(dataMap);
    shareLinkLogoData = entity.data;
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
      return EasyRefresh.custom(
          enableControlFinishRefresh: true,
          // 是否交由control来控制刷新状态
          enableControlFinishLoad: true,
          // 是否交由control来控制加载状态
          taskIndependence: false,
          // 任务独立
          controller: _controller,
          reverse: false,
          //是否反向
          scrollDirection: Axis.vertical,
          // 垂直方向
          topBouncing: true,
          // 顶部回弹
          bottomBouncing: true,
          // 底部回弹
          header: ClassicalHeader(
            enableInfiniteRefresh: false, // 设置无限刷新的一部分,这里不开启, 开启后需要手动关闭
            float: false, // 头部是否浮动（开启刷新时会挡在内容区域上边）
            enableHapticFeedback: true, // 震动
          ),
          footer: ClassicalFooter(
            enableInfiniteLoad: false, // 设置无限加载的一部分,这里不开启, 开启后需要手动关闭
            enableHapticFeedback: true, // 震动
          ),
          onRefresh: () async {
            getShareData(true);
          },
          onLoad: () async {
            Future.delayed(Duration(milliseconds: 1500), () {
              print('----已加载新数据----');
              _controller.finishLoad(success: true);
            });
          },
          slivers: <Widget>[
            SliverPadding(
                padding: EdgeInsets.all(5.0),
                sliver: SliverGrid.count(
                    crossAxisCount: 3,
                    mainAxisSpacing: 3.0,
                    crossAxisSpacing: 3.0,
                    childAspectRatio: 0.52,
                    // 设置子控件宽高比例
                    children: _shareGridViewItem()))
          ]);
    }
  }

  List<Widget> _shareGridViewItem() {
    return shareLinkLogoData
        .map((SharedLinkLogoData data) => InkWell(
            child: Column(
                mainAxisSize: MainAxisSize.max,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  FadeInImage.memoryNetwork(
                    placeholder: kTransparentImage.,
                    image: Config.baseUrl + data.picUrl,
                    fit: BoxFit.cover,
                    width: double.infinity,
                  ),
                  Text(data.picDesc,
                      style: TextStyle(
                          fontSize: 12.0,
                          color: Colors.black,
                          decoration: TextDecoration.none,
                          fontWeight: FontWeight.bold))
                ]),
            onTap: () {
              print('----${data.picDesc}----');
            }))
        .toList();
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
}
