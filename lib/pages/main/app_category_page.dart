import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_for_shop/app_http/app_url_address.dart';
import 'package:flutter_for_shop/app_http/http.dart';
import 'package:flutter_for_shop/infos/json_bean/repayment_entity.dart';
import 'package:flutter_for_shop/utils/MyToastUtils.dart';
import 'package:flutter_for_shop/utils/shared_preferences_util.dart';

class CategoryPage extends StatefulWidget {
  CategoryPage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return CategoryPageState();
  }
}

class CategoryPageState extends State<CategoryPage>
    with AutomaticKeepAliveClientMixin<CategoryPage> {
  static PageController pageViewController = PageController();
  String requestData = '';
  static List<RepaymantMergoods> mergoods;

  bool showWaitingDialog() {
    if (requestData.isEmpty) {
      return true;
    }
    Map dataMap = json.decode(requestData.toString());
    RepaymentEntity entity = RepaymentEntity.fromJson(dataMap);
    mergoods = entity.mergoods;
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
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Container(
                  height: 150.0,
                  width: double.infinity,
                  color: Colors.black12,
                  child: getViewPager()),
              Padding(
                padding: EdgeInsets.all(15.0),
                child: Text(
                  '使用特权',
                  style: TextStyle(
                      fontSize: 16.0,
                      decoration: TextDecoration.none,
                      color: Colors.black,
                      fontWeight: FontWeight.bold),
                ),
              ),
              Padding(
                  padding: EdgeInsets.only(right: 15.0, left: 15.0),
                  child: Image.asset('assets/use_privilege.png',
                      fit: BoxFit.fill, width: double.infinity))
            ],
          ));
    }
  }

  Widget getViewPager() {
    return PageView.builder(
        itemCount: mergoods.length,
        controller: pageViewController,
        onPageChanged: (index) {
          print('---$index---');
        },
        itemBuilder: (buildContext, index) {
          return Card(
              elevation: 3.0,
              margin: EdgeInsets.all(5.0),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(5.0))),
              child: Stack(
                children: <Widget>[
                  Image.asset(
                    index == 0
                        ? 'assets/repay_updata_bg.png'
                        : (index == 1
                            ? 'assets/repay_updata_bg1.png'
                            : (index == 2
                                ? 'assets/repay_updata_bg1.png'
                                : 'assets/repay_updata_bg.png')),
                    width: double.infinity,
                    fit: BoxFit.fill,
                  ),
                  Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: <Widget>[
                        Container(
                            width: double.infinity,
                            color: Color(0x99000000),
                            padding: EdgeInsets.only(left: 15.0, right: 15.0),
                            child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                mainAxisSize: MainAxisSize.max,
                                children: <Widget>[
                                  Text(
                                    '您的当前级别\t\t\t\t${mergoods[index].goodsName}',
                                    maxLines: 1,
                                    textAlign: TextAlign.justify,
                                    style: TextStyle(
                                      color: Colors.white,
                                      decoration: TextDecoration.none,
                                      fontSize: 14.0,
                                      height: 1.5,
                                    ),
                                  ),
                                  Text(
                                    '¥\t${mergoods[index].goodsMoney}',
                                    style: TextStyle(
                                        color: Colors.red, fontSize: 14.0),
                                  )
                                ])),
                        RaisedButton(
                            onPressed: () {
                              MyToastUtils.showToastInCenter('---$index---', 0);
                            },
                            elevation: 3.0,
                            textColor: Colors.white,
                            color: Colors.blue,
                            child: Text(
                              '立即升级',
                              style: TextStyle(fontSize: 12.0),
                            ))
                      ])
                ],
              ));
        });
  }

  @override
  void initState() {
    SharedPreferencesUtil.getStringData(keyStr: 'userId').then((userId) {
      AppHttp.getInstance().post(servicePathAPI['openRepayment'],
          data: {'user_id': userId}).then((values) {
        setState(() {
          requestData = values;
        });
      });
    });
    super.initState();
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
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => false;
}
