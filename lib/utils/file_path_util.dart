import 'dart:io';

import 'package:path_provider/path_provider.dart';

class FilePathUtil{

  Future<File> getLocalCssFile(String fileCssName) async {
// 获取本地文档目录
    String dir = (await getApplicationDocumentsDirectory()).path;
// 返回本地文件目录
    return new File('$dir/$fileCssName');
  }

  Future<File> getLocalHtmlFile(String fileName) async {
// 获取本地文档目录
    String dir = (await getApplicationDocumentsDirectory()).path;
// 返回本地文件目录
    return new File('$dir/$fileName');
  }

  /// 写入到本地缓存目录中文件中，再读其文件uri地址
  Future<String> writeDataFile(String data) async {
//    _checkCssFile();
    File file = await getLocalHtmlFile('textRich.html');
    File afterFile = await file.writeAsString(data);
    String webUrl = afterFile.uri.toString();
    print('weburl ==== $webUrl');
    return webUrl;
  }

//  void _checkCssFile() async {
//    File file = await getLocalCssFile();
//    bool isExist = await file.exists();
//    int fileLength = isExist ? await file.length() : -1;
//    print('csss file length === $fileLength');
//    if (!isExist || fileLength <= 0) {
//      if (isExist) {
//        await file.delete();
//      }
//      await file.create();
//      String cssStr = await DefaultAssetBundle.of(context)
//          .loadString('htmlsource/css/main.css');
//      print('csss ==== $cssStr');
//      await file.writeAsString(cssStr);
//    }
//  }

}