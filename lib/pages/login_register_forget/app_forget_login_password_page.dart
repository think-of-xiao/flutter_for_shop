import 'dart:async';
import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_des/flutter_des.dart';
import 'package:flutter_for_shop/app_http/app_url_address.dart';
import 'package:flutter_for_shop/app_http/http.dart';
import 'package:flutter_for_shop/custom/custom_widget/net_loading_widget.dart';
import 'package:flutter_for_shop/infos/app_config.dart';
import 'package:flutter_for_shop/utils/MyToastUtils.dart';
import 'package:flutter_for_shop/utils/crypt_util.dart';
import 'package:simple_rsa/simple_rsa.dart';

class AppForgetLoginPwsPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return AppForgetLoginPwsPageState();
  }
}

class AppForgetLoginPwsPageState extends State<AppForgetLoginPwsPage> {
  TextEditingController phoneController,
      smsController,
      pws1Controller,
      pws2Controller;
  Timer _timer;
  int _second = 60;
  String _smsText = '获取验证码';
  bool _timerCanClick = true;

  @override
  void initState() {
    phoneController = TextEditingController();
    smsController = TextEditingController();
    pws1Controller = TextEditingController();
    pws2Controller = TextEditingController();
    super.initState();
  }

  /// 启动倒计时的定时器
  _startTimer() {
    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      _second--;
      if (_second == 0) {
        _cancelTimer();
        _second = 60;
        _smsText = '重新获取';
        _timerCanClick = true;
      } else {
        _smsText = '已发送${_second}s';
        _timerCanClick = false;
      }
      setState(() {}); // 刷新界面
    });
  }

  /// 取消计时器
  _cancelTimer() {
    print('~~~~~~~~~~~~计时器已取消~~~~~~~~~~~~~');
    _timer?.cancel();
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      resizeToAvoidBottomPadding: false,
      appBar: AppBar(
        title: Text('忘记密码'),
        leading: IconButton(
            icon: Icon(Icons.arrow_back),
            onPressed: () {
              _cancelTimer();
              Navigator.pop(context);
            }, tooltip: '返回上一个界面',),
      ),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Container(
          padding: EdgeInsets.all(15.0),
          width: MediaQuery.of(context).size.width,
          child: Column(
            mainAxisSize: MainAxisSize.max,
            children: <Widget>[
              buildContainer('手机号', '请输入您的手机号', phoneController, TextInputType.phone),
              Container(
                  padding: EdgeInsets.only(top: 5.0, bottom: 5.0, left: 5.0),
                  margin: EdgeInsets.only(top: 15.0),
                  decoration: BoxDecoration(
                      color: CupertinoColors.white,
                      borderRadius: BorderRadius.all(Radius.circular(5.0))),
                  child: Row(
                    mainAxisSize: MainAxisSize.max,
                    children: <Widget>[
                      Text(
                        '验证码',
                        style: TextStyle(
                            color: CupertinoColors.black,
                            fontSize: 14.0,
                            decoration: TextDecoration.none),
                      ),
                      Expanded(
                          flex: 1,
                          child: CupertinoTextField(
                              placeholder: '输入验证码',
                              style: TextStyle(
                                fontSize: 16.0,
                                color: CupertinoColors.black,
                              ),
                              maxLines: 1,
                              controller: smsController,
                              keyboardType: TextInputType.number,
                              autofocus: true,
                              maxLength: 16,
                              padding: EdgeInsets.only(
                                  left: 25.0, top: 5.0, bottom: 5.0))),
                      Material(
                        elevation: 1.5,
                        color: CupertinoColors.activeBlue,
                        borderRadius: BorderRadius.all(Radius.circular(3.0)),
                        shadowColor: CupertinoColors.inactiveGray,
                        child: GestureDetector(
                          onTap: _getSms,
                          child: Padding(
                              padding: EdgeInsets.only(
                                  top: 10.0,
                                  bottom: 10.0,
                                  left: 5.0,
                                  right: 5.0),
                              child: Text(
                                _smsText,
                                style: TextStyle(
                                    color: CupertinoColors.white,
                                    fontSize: 14.0,
                                    decoration: TextDecoration.none),
                              )),
                        ),
                      )
                    ],
                  )),
              buildContainer('密码', '输入6~16位密码', pws1Controller, TextInputType.emailAddress),
              buildContainer('确认密码', '再次输入密码', pws2Controller, TextInputType.emailAddress),
              Container(
                width: double.infinity,
                margin: EdgeInsets.only(top: 60.0),
                child: CupertinoButton(
                  color: CupertinoColors.activeBlue,
                  child: Center(
                    child: Text(
                      '确认',
                      style: TextStyle(
                          color: CupertinoColors.white, fontSize: 16.0),
                    ),
                  ),
                  onPressed: _findUserLoginPws,
                  padding: EdgeInsets.only(top: 5.0, bottom: 5.0),
                  pressedOpacity: 0.5,
                  borderRadius: BorderRadius.all(Radius.circular(5.0)),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  /// 相同的布局做统一函数处理加载
  Container buildContainer(var title, var tipStr, var controller, var textType) {
    return Container(
              padding: EdgeInsets.only(top: 5.0, bottom: 5.0, left: 5.0),
              decoration: BoxDecoration(
                  color: CupertinoColors.white,
                  borderRadius: BorderRadius.all(Radius.circular(5.0))),
              child: Row(
                mainAxisSize: MainAxisSize.max,
                children: <Widget>[
                  Text(
                    title,
                    style: TextStyle(
                        color: CupertinoColors.black,
                        fontSize: 14.0,
                        decoration: TextDecoration.none),
                  ),
                  Expanded(
                      flex: 1,
                      child: CupertinoTextField(
                          placeholder: tipStr,
                          style: TextStyle(
                            fontSize: 16.0,
                            color: CupertinoColors.black,
                          ),
                          maxLines: 1,
                          controller: controller,
                          keyboardType: textType,
                          autofocus: true,
                          maxLength: 16,
                          padding: EdgeInsets.only(
                              left: 25.0, top: 5.0, bottom: 5.0)))
                ],
              ),
            );
  }

  _getSms() async {
    if (_timerCanClick) {
      print('~~~~~~~~~~~获取短信~~~~~~~~~~~');
      String userPhone = phoneController.text.trim();
      if (userPhone.isEmpty || userPhone.length < 11) {
        MyToastUtils.showToastInCenter('手机号为空或不正确', 0);
      } else {
        /// RSA加密Des密钥
//        final rsaEncodeDesKey = await encryptString(
//            DES_KEY, utf8.decode(base64.decode(PUBLIC_KEY_STR)));
        var rsaEncodeDesKey = await encryptString(DES_KEY, PUBLIC_KEY_STR);

        var desEncodeHexTypeNumber =
        await FlutterDes.encryptToBase64('22222222', DES_KEY, iv: DES_IV);

        var desEncodeHexBrandNumber = await FlutterDes.encryptToBase64(
            Config.brandNumber, DES_KEY,
            iv: DES_IV);

        _showNetWaitingDialog();
        AppHttp.getInstance().post(servicePathAPI['sms'], data: {
          'login_phone': userPhone,
          'type_number': desEncodeHexTypeNumber.toString(),
          'secret_key': rsaEncodeDesKey.toString(),
          'brand_number': desEncodeHexBrandNumber.toString()
        }).then((value) {
          _dismissNetWaitingDialog();
          _startTimer();
          Map smsMap = json.decode(value.toString());
          if (smsMap.containsKey('mobileState')) {
            if (smsMap['mobileState'] == 4) {
              MyToastUtils.showToastInCenter('该用户已注册', 0);
            } else {
              MyToastUtils.showToastInCenter(smsMap['mobileData'], 0);
            }
          } else {
            MyToastUtils.showToastInCenter('响应的状态未知', 0);
          }
        });
      }
    }
  }

  _findUserLoginPws() {
    print('~~~~~~~~~~~~找回密码~~~~~~~~~~~~~');
    String accountPhoneStr = phoneController.text.trim();
    String smsCodeStr = smsController.text.trim();
    String accountPws1Str = pws1Controller.text.trim();
    String accountPws2Str = pws2Controller.text.trim();
    if (accountPhoneStr.isEmpty || accountPhoneStr.length < 11) {
      MyToastUtils.showToastInCenter('手机号为空或不正确', 0);
    } else if (smsCodeStr.isEmpty) {
      MyToastUtils.showToastInCenter('请填写验证码', 0);
    } else if (accountPws1Str.isEmpty || accountPws1Str.length < 6) {
      MyToastUtils.showToastInCenter('密码为空或不正确', 0);
    } else if (accountPws2Str.isEmpty || accountPws2Str.length < 6) {
      MyToastUtils.showToastInCenter('确认密码为空或不正确', 0);
    } else if (accountPws1Str != accountPws2Str) {
      MyToastUtils.showToastInCenter('两次输入的密码不一致', 0);
    } else {
      _showNetWaitingDialog();

      AppHttp.getInstance().post(servicePathAPI['forgetLoginPws'], data: {
        'login_phone': accountPhoneStr,
        'client_password': generateMd5(accountPws1Str),
        'type_number': '22222222',
        'mobileCode': smsCodeStr,
      }).then((value) {
        _dismissNetWaitingDialog();
        Map registerDataMap = json.decode(value.toString());
        if (registerDataMap.containsKey('mobileState')) {
          if (registerDataMap['mobileState'] == '0') {
            _goLoginPage(registerDataMap['mobileData']);
          } else {
            MyToastUtils.showToastInCenter(registerDataMap['mobileData'], 0);
          }
        } else {
          MyToastUtils.showToastInCenter('出现异常，响应内容为空', 0);
        }
      });
    }
  }

  _goLoginPage(var msg) {
    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) => Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            color: Colors.transparent,
            child: Center(
                child: ClipRRect(
                    borderRadius: BorderRadius.all(Radius.circular(6.0)),
                    child: Container(
                        color: Colors.white,
                        child: SizedBox(
                          width: 250.0,
                          height: 120.0,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Text(
                                msg,
                                softWrap: true,
                                style: TextStyle(
                                    fontSize: 12.0,
                                    decoration: TextDecoration.none,
                                    color: Colors.blueGrey),
                              ),
                              Container(
                                  margin: EdgeInsets.only(top: 15.0),
                                  child: CupertinoButton(
                                      color: Colors.blue,
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(3.0)),
                                      padding: EdgeInsets.only(
                                          right: 15.0, left: 15.0),
                                      child: Text(
                                        '去登陆',
                                        style: TextStyle(
                                            decoration: TextDecoration.none,
                                            fontSize: 14.0,
                                            color: Colors.white),
                                      ),
                                      onPressed: () {
                                        Navigator.pop(context);
                                        Future.delayed(
                                            Duration(milliseconds: 100), () {
                                          Navigator.of(context).pop();
                                        });
                                      }))
                            ],
                          ),
                        ))))));
  }

  /// 展示等待框效果
  _showNetWaitingDialog() {
    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) => NetLoadingDialog(
          outsideDismiss: false,
        ));
  }

  /// 请确保是在showDialog之后调用
  /// 隐藏等待框
  _dismissNetWaitingDialog() {
    Navigator.pop(context);
  }
}
