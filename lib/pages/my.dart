import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:password/model/User.dart';

class My extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<My> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
      child: Text("我的页面"),
    ));
  }
}
