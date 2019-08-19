import 'package:flutter/material.dart';

class MemberPage extends StatefulWidget {
  MemberPage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return MemberPageState();
  }
}

class MemberPageState extends State<MemberPage> with AutomaticKeepAliveClientMixin<MemberPage>{
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(title: Text(widget.title),),
      body: Text('会员中心'),
    );
  }

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => false;
}