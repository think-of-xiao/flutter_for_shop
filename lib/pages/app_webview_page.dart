import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_for_shop/utils/file_path_util.dart';
import 'package:flutter_webview_plugin/flutter_webview_plugin.dart';

class MyWebView extends StatefulWidget {
  String title;
  String contentUrl;
  bool isBase64Url;

  MyWebView(
      {Key key,
      this.title = '网页',
      this.contentUrl = 'https://www.baidu.com',
      this.isBase64Url = false})
      : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return MyWebViewState();
  }
}

class MyWebViewState extends State<MyWebView> {
  final flutterWebviewPlugin = new FlutterWebviewPlugin();

  @override
  void initState() {
    super.initState();

    //是富文本但没有head头标签，做以下处理后重新加载
    if (widget.isBase64Url) {
      if (!widget.contentUrl.contains(RegExp('head'))) {
        FilePathUtil()
            .writeDataFile(getHtmlData(widget.contentUrl))
            .then((webUrl) {
          if (flutterWebviewPlugin != null) {
            flutterWebviewPlugin.reloadUrl(webUrl);
          }
        });
      }
    }

    //监听网址的变化
    flutterWebviewPlugin.onUrlChanged.listen((String url) {
      print('---url_changed---:\t\n $url');
    });
    //监听web界面上下滑动监听
    flutterWebviewPlugin.onScrollYChanged.listen((double offsetY) {
      // latest offset value in vertical scroll
      // compare vertical scroll changes here with old value
      print('---url_changed---:\t\n $offsetY');
    });
    //监听web界面左右滑动监听
    flutterWebviewPlugin.onScrollXChanged.listen((double offsetX) {
      // latest offset value in horizontal scroll
      // compare horizontal scroll changes here with old value
      print('---url_changed---:\t\n $offsetX');
    });
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return WebviewScaffold(
      appBar: AppBar(title: Text(widget.title), centerTitle: true),
      url: widget.contentUrl,
      withZoom: true,
      supportMultipleWindows: true,
      withJavascript: true,
      withLocalStorage: true,
      hidden: true,
      initialChild: Container(
        color: Colors.redAccent,
        child: Center(
          child: Text('Waiting...'),
        ),
      ),
    );
  }

  /// 将获取到的富文本字符串调用下面方法，即可适配屏幕，占满一屏幕！！！
  String getHtmlData(String bodyHTML) {
    String head = "<head>" +
        "<meta name=\"viewport\" content=\"width=device-width, initial-scale=1.0, user-scalable=no\"> " +
        "<style>img{max-width: 100%; width:auto; height:auto;}</style>" +
        "</head>";
    return "<html>" + head + "<body>" + bodyHTML + "</body></html>";
  }

  /// webview加载本地js文件
  Future<String> loadJS(String name) async {
    var givenJS = rootBundle.loadString('assets/$name.js');
    return givenJS.then((String js) {
      flutterWebviewPlugin.onStateChanged.listen((viewState) async {
        if (viewState.type == WebViewState.finishLoad) {
          flutterWebviewPlugin.evalJavascript(js);
        }
      });
    });
  }

  @override
  void dispose() {
    if (flutterWebviewPlugin != null) {
      flutterWebviewPlugin.close();
    }
    super.dispose();
  }
}
