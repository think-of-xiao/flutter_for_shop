import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

class CategoryPage extends StatefulWidget {
  CategoryPage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return CategoryPageState();
  }
}

class CategoryPageState extends State<CategoryPage> with AutomaticKeepAliveClientMixin<CategoryPage> {

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: null,
    );
  }

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => false;

}
