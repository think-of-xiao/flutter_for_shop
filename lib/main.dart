import 'package:flutter/material.dart';
import 'package:flutter_for_shop/pages/login_register_forget/app_login_page.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: '+我的九九+',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.pink,
      ),
      home: AppLoginPage(),
    );
  }
}

