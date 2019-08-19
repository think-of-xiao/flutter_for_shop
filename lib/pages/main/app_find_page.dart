import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

class CenterFindPage extends StatefulWidget {
  CenterFindPage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return CenterFindPageState();
  }
}

class CenterFindPageState extends State<CenterFindPage> {

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

}