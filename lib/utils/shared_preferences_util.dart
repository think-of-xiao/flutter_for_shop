import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferencesUtil{

  /// 存值(String类型)
  static saveStringData({String keyStr, String valueStr}) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setString(keyStr, valueStr);
  }

  /// 获取值(String类型)（在then中返回）
  static Future getStringData({keyStr}) async {
    final prefs = await SharedPreferences.getInstance();
    String counter = prefs.getString(keyStr) ?? 0;
    return counter;
  }

  /// 移除指定key和值
  static removeKeyData({keyStr}) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.remove(keyStr);
  }

}