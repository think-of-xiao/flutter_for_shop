import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class MyToastUtils {
  /// msg:展示内容
  /// showTimeTag:0为短暂显示SHORT 1为长时间显示LONG
  static showToastInCenter(String msg, int showTimeTag){
    if(showTimeTag == 0)
      Fluttertoast.showToast(
          msg: msg,
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIos: 1,
          backgroundColor: Colors.pink[300],
          textColor: Colors.white,
          fontSize: 16.0
        );
    else if(showTimeTag == 1)
      Fluttertoast.showToast(
          msg: msg,
          toastLength: Toast.LENGTH_LONG,
          gravity: ToastGravity.CENTER,
          timeInSecForIos: 1,
          backgroundColor: Colors.pinkAccent,
          textColor: Colors.white,
          fontSize: 16.0
      );
  }

  /// msg:展示内容
  /// showTimeTag:0为短暂显示SHORT 1为长时间显示LONG
  static showToastInBottom(String msg, int showTimeTag){
    if(showTimeTag == 0)
      Fluttertoast.showToast(
          msg: msg,
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIos: 1,
          backgroundColor: Colors.pink[300],
          textColor: Colors.white,
          fontSize: 16.0
      );
    else if(showTimeTag == 1)
      Fluttertoast.showToast(
          msg: msg,
          toastLength: Toast.LENGTH_LONG,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIos: 1,
          backgroundColor: Colors.pinkAccent,
          textColor: Colors.white,
          fontSize: 16.0
      );
  }
}