import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_des/flutter_des.dart';
import 'package:flutter_for_shop/app_http/app_url_address.dart';
import 'package:flutter_for_shop/app_http/http.dart';
import 'package:flutter_for_shop/custom/custom_widget/net_loading_widget.dart';
import 'package:flutter_for_shop/infos/app_config.dart';
import 'package:flutter_for_shop/utils/crypt_util.dart';
import 'package:flutter_for_shop/utils/shared_preferences_util.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:simple_rsa/simple_rsa.dart';
import 'package:flutter_for_shop/infos/json_bean/share_playbill_entity.dart';
import 'package:transparent_image/transparent_image.dart';

class SharePage extends StatefulWidget {
  String imgId;

  SharePage({Key key, this.imgId = ''}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return SharePageState();
  }
}

class SharePageState extends State<SharePage> {
  var imgWidth;
  var imgHeight;
  SharePlaybillEntity entity;

  @override
  void initState() {
    super.initState();
    SharedPreferencesUtil.getStringData(keyStr: 'userId').then((userId) async {
      _showNetWaitingDialog();
      var rsaEncodeDesKey = await encryptString(DES_KEY, PUBLIC_KEY_STR);
      var desEncodeBase64BrandNumber = await FlutterDes.encryptToBase64(
          Config.brandNumber, DES_KEY,
          iv: DES_IV);

      AppHttp.getInstance().post(servicePathAPI['shareAppLinkLogo'], data: {
        'user_id': userId,
        'secret_key': rsaEncodeDesKey,
        'id': widget.imgId,
        'brand_number': desEncodeBase64BrandNumber
      }).then((values) {
        _dismissNetWaitingDialog();
        setState(() {
          Map playbillData = json.decode(values.toString());
          entity = SharePlaybillEntity.fromJson(playbillData);
        });
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    imgWidth = MediaQuery.of(context).size.width / 1.5;
    imgHeight = imgWidth * 1.75;
    return Scaffold(
      backgroundColor: Colors.transparent,
      appBar: AppBar(title: Text('海报'), centerTitle: true, actions: <Widget>[
        Center(
            child: RaisedButton(
                color: Colors.transparent,
                onPressed: () {},
                child: Text('分享链接'),
                textColor: Colors.white))
      ]),
      body: entity == null
          ? Center(child: Text('还未显示'))
          : Center(
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                  FadeInImage.memoryNetwork(
                    placeholder: kTransparentImage,
                    image: Config.baseUrl + entity.qrcodeUrl,
                    width: imgWidth,
                    height: imgHeight,
                  ),
                  Row(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        RaisedButton(onPressed: () {}, color: Colors.redAccent, child: Text('分享二维码')),
                        SizedBox(height: 1.0, width: 15.0),
                        RaisedButton(onPressed: () {}, color: Colors.redAccent, child: Text('保存到手机'))
                      ])
                ])),
    );
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
