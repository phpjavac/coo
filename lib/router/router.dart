import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:password/pages/login/index.dart';
import 'package:password/pages/login/login.dart';

typedef RequestCallBack = void Function(bool data);

class Router {
  static const loginpage = 'app://login';
  static const login = 'app://login/login';
  Widget _getPage(String url, dynamic params) {
    switch (url) {
      case loginpage:
        return LoginIndex();
      case login:
        return Login();
    }
    return null;
  }

  Router.pushNoParams(
      BuildContext context, String url, RequestCallBack requestCallBack) {
    Navigator.push(context, MaterialPageRoute(builder: (context) {
      return _getPage(url, null);
    })).then((value) {
      requestCallBack(value);
    });
  }

  Router.push(BuildContext context, String url, dynamic params) {
    Navigator.push(context, MaterialPageRoute(builder: (context) {
      return _getPage(url, params);
    }));
  }
}
