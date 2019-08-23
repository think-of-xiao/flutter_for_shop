import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_downloader/flutter_downloader.dart';
import 'package:flutter_for_shop/utils/MyToastUtils.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:progress_dialog/progress_dialog.dart';

/// app更新帮助类
class AppUpdateUtil{

  static BuildContext context;
  static ProgressDialog pr;

  static notification() async {
    pr = new ProgressDialog(context, ProgressDialogType.Download);
    pr.setMessage('下载中…');
    // 设置下载回调
    FlutterDownloader.registerCallback((id, status, progress) {
      // 打印输出下载信息
      print(
          'Download task ($id) is in status ($status) and process ($progress)');
      if (!pr.isShowing()) {
        pr.show();
      }
      if (status == DownloadTaskStatus.running) {
        pr.update(progress: progress.toDouble(), message: "下载中，请稍后…");
      }
      if (status == DownloadTaskStatus.failed) {
        MyToastUtils.showToastInBottom('下载异常，请稍后重试', 0);
        if (pr.isShowing()) {
          pr.hide();
        }
      }
      if (status == DownloadTaskStatus.complete) {
        print(pr.isShowing());
        if (pr.isShowing()) {
          pr.hide();
        }
        // 显示是否打开的对话框
        showDialog(
          // 设置点击 dialog 外部不取消 dialog，默认能够取消
            barrierDismissible: false,
            context: context,
            builder: (context) => AlertDialog(
              title: Text('提示'),
              // 标题文字样式
              content: Text('文件下载完成，是否打开？'),
              // 内容文字样式
              backgroundColor: CupertinoColors.white,
              elevation: 8.0,
              // 投影的阴影高度
              semanticLabel: 'Label',
              // 这个用于无障碍下弹出 dialog 的提示
              shape: Border.all(),
              // dialog 的操作按钮，actions 的个数尽量控制不要过多，否则会溢出 `Overflow`
              actions: <Widget>[
                // 点击取消按钮
                FlatButton(
                    onPressed: () => Navigator.pop(context),
                    child: Text('取消')),
                // 点击打开按钮
                FlatButton(
                    onPressed: () {
                      Navigator.pop(context);
                      // 打开文件
                      _openDownloadedFile(id).then((success) {
                        if (!success) {
                          Scaffold.of(context).showSnackBar(SnackBar(
                              content: Text('Cannot open this file')));
                        }
                      });
                    },
                    child: Text('打开')),
              ],
            ));
      }
    });
  }

  static showAppUpdateDialog(BuildContext con, String updateContent, String downLoadUrl){
    context = con;
    notification();
    showDialog(context: context,
        barrierDismissible: false,
        builder: (context) => AlertDialog(
            title: Text('更新提示'),
            content: Text(updateContent),
            shape: Border.all(),
            backgroundColor: CupertinoColors.white,
            elevation: 8.0,
            // 投影的阴影高度
            semanticLabel: 'Label',
            actions: <Widget>[
              // 点击取消按钮
              FlatButton(
                  onPressed: () => Navigator.pop(context),
                  child: Text('取消')),
              // 点击确认
              FlatButton(
                  onPressed: () {
                    Navigator.pop(context);
                    // 去下载
                    _checkPermission().then((bol) async {
                      if(bol){
                        // 获取存储路径
                        var _localPath = (await _findLocalPath()) + '/flutter_download';
                        final savedDir = Directory(_localPath);
                        // 判断下载路径是否存在
                        bool hasExisted = await savedDir.exists();
                        // 不存在就新建路径
                        if (!hasExisted) {
                          savedDir.create();
                        }
                        _downloadFile(downLoadUrl, savedDir.path);
                      }
                    });
                  },
                  child: Text('打开')),
            ]
        ));
  }

  // 根据taskId打开下载文件
  static Future<bool> _openDownloadedFile(taskId) {
    return FlutterDownloader.open(taskId: taskId);
  }

  // 根据 downloadUrl 和 savePath 下载文件
  static _downloadFile(downloadUrl, savePath) async {
    await FlutterDownloader.enqueue(
      url: downloadUrl,
      savedDir: savePath,
      showNotification: true,
      fileName: 'flutter_for_shop_app',
      // show download progress in status bar (for Android)
      openFileFromNotification:
      true, // click on notification to open downloaded file (for Android)
    );
  }

  // 申请权限
  static Future<bool> _checkPermission() async {
    // 先对所在平台进行判断
    if (Theme.of(context).platform == TargetPlatform.android) {
      PermissionStatus permission = await PermissionHandler()
          .checkPermissionStatus(PermissionGroup.storage);
      if (permission != PermissionStatus.granted) {
        Map<PermissionGroup, PermissionStatus> permissions =
        await PermissionHandler()
            .requestPermissions([PermissionGroup.storage]);
        if (permissions[PermissionGroup.storage] == PermissionStatus.granted) {
          return true;
        }
      } else {
        return true;
      }
    } else {
      return true;
    }
    return false;
  }

  // 获取存储路径
  static Future<String> _findLocalPath() async {
    // 因为Apple没有外置存储，所以第一步我们需要先对所在平台进行判断
    // 如果是android，使用getExternalStorageDirectory
    // 如果是iOS，使用getApplicationSupportDirectory
    final directory = Theme.of(context).platform == TargetPlatform.android
        ? await getExternalStorageDirectory()
        : await getApplicationSupportDirectory();
    return directory.path;
  }

}