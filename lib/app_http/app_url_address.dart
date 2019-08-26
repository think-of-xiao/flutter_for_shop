const servicePathAPI = {
  'sms': '/common/verifycode_mobile.action', // 获取短信
  'register': '/login/loginapp_mobile.action', // 注册
  'login': '/login/landApp_mobile.action', // 登录
  'forgetLoginPws': '/login/Retrievepass_mobile.action', // 修改（找回）登录密码
  'homePageUrl': '/login/LayoutPage_mobile.action', // 首页菜单信息(首页banner都是这个)
  'noticeData': '/Operation/Notice_allow.action', // 首页消息公告栏
  'appUpdate': '/Version/getVersionInfo_mobile.action', // 检查app是否需要更新
  'openRepayment': '/repayment/ifOpen_allow.action', // //判断用户是否开通还款功能
};
