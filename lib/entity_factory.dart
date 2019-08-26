import 'package:flutter_for_shop/infos/json_bean/app_update_entity.dart';
import 'package:flutter_for_shop/infos/json_bean/home_menu_entity.dart';
import 'package:flutter_for_shop/infos/json_bean/login_entity.dart';
import 'package:flutter_for_shop/infos/json_bean/main_banner_entity.dart';
import 'package:flutter_for_shop/infos/json_bean/main_notice_entity.dart';
import 'package:flutter_for_shop/infos/json_bean/repayment_entity.dart';

class EntityFactory {
  static T generateOBJ<T>(json) {
    if (1 == 0) {
      return null;
    } else if (T.toString() == "AppUpdateEntity") {
      return AppUpdateEntity.fromJson(json) as T;
    } else if (T.toString() == "HomeMenuEntity") {
      return HomeMenuEntity.fromJson(json) as T;
    } else if (T.toString() == "LoginEntity") {
      return LoginEntity.fromJson(json) as T;
    } else if (T.toString() == "MainBannerEntity") {
      return MainBannerEntity.fromJson(json) as T;
    } else if (T.toString() == "MainNoticeEntity") {
      return MainNoticeEntity.fromJson(json) as T;
    } else if (T.toString() == "RepaymentEntity") {
      return RepaymentEntity.fromJson(json) as T;
    } else {
      return null;
    }
  }
}