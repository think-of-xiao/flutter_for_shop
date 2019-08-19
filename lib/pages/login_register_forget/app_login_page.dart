import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_for_shop/app_http/app_url_address.dart';
import 'package:flutter_for_shop/app_http/http.dart';
import 'package:flutter_for_shop/custom/custom_widget/net_loading_widget.dart';
import 'package:flutter_for_shop/infos/json_bean/login_entity.dart';
import 'package:flutter_for_shop/pages/index_page_new.dart';
import 'package:flutter_for_shop/pages/login_register_forget/app_forget_login_password_page.dart';
import 'package:flutter_for_shop/pages/login_register_forget/app_register_page.dart';
import 'package:flutter_for_shop/utils/MyToastUtils.dart';
import 'package:flutter_for_shop/utils/crypt_util.dart';
import 'package:flutter_for_shop/utils/shared_preferences_util.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AppLoginPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return AppLoginState();
  }
}

class AppLoginState extends State<AppLoginPage> {
  TextEditingController userPhoneController, passwordController;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    userPhoneController = TextEditingController();
    passwordController = TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    //设置适配尺寸 (填入设计稿中设备的屏幕尺寸) 假如设计稿是按iPhone6的尺寸设计的(iPhone6 750*1334)
    ScreenUtil.instance = ScreenUtil(width: 750, height: 1334)..init(context);
//    ScreenUtil.instance = ScreenUtil.getInstance()..init(context);

    return CupertinoPageScaffold(
      child: SingleChildScrollView(
        child: Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            child: Padding(
              padding: EdgeInsets.all(15.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Expanded(
                      // 头部App Logo图部分
                      flex: 1,
                      child: Center(
                        child: Image.asset(
                          'assets/app_launcher.png',
                          width: 80.0,
                          height: 80.0,
                        ),
                      )),
                  Expanded(
                    // 下边主要模块部分
                    flex: 2,
                    child: Container(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisSize: MainAxisSize.min,
                        children: <Widget>[
                          Text(
                            '手机号/账号',
                            style: TextStyle(
                                color: CupertinoColors.inactiveGray,
                                fontSize: 14.0,
                                decoration: TextDecoration.none),
                          ),
                          CupertinoTextField(
                            placeholder: '输入您的账号',
                            style: TextStyle(
                              fontSize: 16.0,
                              color: CupertinoColors.black,
                            ),
                            maxLines: 1,
                            controller: userPhoneController,
                            keyboardType: TextInputType.phone,
                            autofocus: true,
                            maxLength: 11,
                            padding: EdgeInsets.all(10.0)
                          ),
                          Padding(padding: EdgeInsets.all(15.0)),
                          Text(
                            '密码',
                            style: TextStyle(
                                color: CupertinoColors.inactiveGray,
                                fontSize: 14.0,
                                decoration: TextDecoration.none),
                          ),
                          CupertinoTextField(
                            placeholder: '输入您的密码',
                            style: TextStyle(
                              fontSize: 16.0,
                              color: CupertinoColors.black,
                            ),
                            maxLines: 1,
                            controller: passwordController,
                            keyboardType: TextInputType.emailAddress,
                            autofocus: true,
                            maxLength: 16,
                            padding: EdgeInsets.all(10.0),
                            obscureText: true,
                          ),
                          Padding(padding: EdgeInsets.all(30.0)),
                          Container(
                              width: double.infinity,
                              child: CupertinoButton(
                                color: CupertinoColors.activeBlue,
                                child: Center(
                                  child: Text(
                                    '立即登录',
                                    style: TextStyle(
                                        color: CupertinoColors.white,
                                        fontSize: 16.0),
                                  ),
                                ),
                                onPressed: _loginMethod,
                                padding: EdgeInsets.only(top: 5.0, bottom: 5.0),
                                pressedOpacity: 0.5,
                                borderRadius:
                                    BorderRadius.all(Radius.circular(5.0)),
                              )),
                          Padding(padding: EdgeInsets.all(5.0)),
                          Container(
                              child: Row(
                            mainAxisSize: MainAxisSize.max,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: <Widget>[
                              GestureDetector(
                                onTap: _goRegister,
                                child: Text(
                                  '注册账号',
                                  style: TextStyle(
                                      fontSize: 15.0,
                                      decoration: TextDecoration.none,
                                      color: CupertinoColors.black),
                                ),
                              ),
                              GestureDetector(
                                onTap: _goForgetLoginPws,
                                child: Text('忘记密码?',
                                    style: TextStyle(
                                        fontSize: 15.0,
                                        decoration: TextDecoration.none)),
                              )
                            ],
                          )),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            )),
      ),
    );
  }

  /// 登录入口函数
  _loginMethod() {

    print('------------loginMethod-----------');

    String accountPhoneStr = userPhoneController.text.trim();
    String accountPwsStr = passwordController.text.trim();

    if (accountPhoneStr.isEmpty || accountPhoneStr.length < 11) {
      MyToastUtils.showToastInCenter('手机号为空或不正确', 0);
    } else if (accountPwsStr.isEmpty || accountPwsStr.length < 6) {
      MyToastUtils.showToastInCenter('密码为空或不正确', 0);
    } else {

      _showNetWaitingDialog();

      AppHttp.getInstance().post(servicePathAPI['login'], data: {
        'login_phone': accountPhoneStr,
        'client_password': generateMd5(accountPwsStr)
      }).then((values) {

        _dismissNetWaitingDialog();

        Map loginMap = json.decode(values.toString());
        var loginEntity = LoginEntity.fromJson(loginMap);

        SharedPreferencesUtil.saveStringData(
            keyStr: 'userId', valueStr: loginEntity.userId.toString());
        SharedPreferencesUtil.saveStringData(
            keyStr: 'userName', valueStr: loginEntity.userName);
        SharedPreferencesUtil.saveStringData(
            keyStr: 'phone', valueStr: loginEntity.loginPhone);

        MyToastUtils.showToastInBottom('登录成功', 0);
        // 启动首页
        Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(builder: (context) => IndexPage()),
            (route) => route == null);
      });
    }
  }

  /// 注册页面入口函数
  _goRegister() {
    print('------------registerMethod-----------');
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => AppRegisterPage()));
  }

  /// 忘记密码页面入口函数
  _goForgetLoginPws() {
    print('------------forgetLoginPwsMethod-----------');
    Navigator.push(context,
        MaterialPageRoute(builder: (context) => AppForgetLoginPwsPage()));
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
