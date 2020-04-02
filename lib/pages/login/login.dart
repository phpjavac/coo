import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  GlobalKey _formKey = new GlobalKey<FormState>();
  final TextEditingController _passWrodTextController =
      new TextEditingController();
  final TextEditingController _codeTextController = new TextEditingController();
  bool _passWrodVisibility = true;
  bool isLoading = false;
  String controller = "";
  // 点击控制密码是否显示
  void showPassWord() {
    setState(() {
      _passWrodVisibility = !_passWrodVisibility;
    });
  }

  _loginButtonState() {
    if (isLoading) {
      return null;
    } else {
      return () {
        //在这里不能通过此方式获取FormState，context
        //print(Form.of(context));
        // 通过_formKey.currentState 获取FormState后，
        // 调用validate()方法校验用户名密码是否合法，校验
        // 通过后再提交数据。
        if ((_formKey.currentState as FormState).validate()) {
          setState(() {
            isLoading = true;
          });
          //验证通过提交数据
          Navigator.of(context).pop(true);
        }
      };
    }
  }

  @override
  Widget build(BuildContext context) {
    var dark_text_gray;
    return Scaffold(
        body: Stack(
      children: <Widget>[
        ConstrainedBox(
            constraints: const BoxConstraints.expand(),
            child: Container(
              decoration: new BoxDecoration(
                image: DecorationImage(
                  image: AssetImage("assets/bg.png"),
                  fit: BoxFit.cover,
                ),
                //  color: Colors.black,
                // color: Colors.grey.shade200,
              ),
            )),
        Container(
            child: ClipRect(
          child: new BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 22.0, sigmaY: 10.0),
            child: Opacity(
              opacity: 0.5,
              child: new Container(
                  decoration: new BoxDecoration(
                color: Colors.grey,
                // color: Colors.grey.shade200,
              )),
            ),
          ),
        )),
        Padding(
          child: Column(children: <Widget>[
            Center(
              child: Form(
                key: _formKey, //设置globalKey，用于后面获取FormState
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    TextFormField(
                        autofocus: true,
                        controller: _codeTextController,
                        
                        decoration: InputDecoration(
                            border: OutlineInputBorder(
                              
                              borderRadius: BorderRadius.circular(0),
                            ),
                            labelText: "账号",
                            hintText: "请输入账号",
                            prefixIcon: Icon(Icons.person)),
                        // 校验用户名
                        validator: (v) {
                          return v.trim().length > 0 ? null : "账号不能为空";
                        }),
                    Container(
                      height: 30,
                      width: MediaQuery.of(context).size.width * 0.75,
                      color: Colors.transparent,
                    ),
                    TextFormField(
                      controller: _passWrodTextController,
                      decoration: InputDecoration(
                        labelText: "密码",
                        hintText: "您的登录密码",
                        prefixIcon: Icon(Icons.lock),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(0),
                        ),
                        suffixIcon: IconButton(
                          icon: Icon(_passWrodVisibility
                              ? Icons.visibility
                              : Icons.visibility_off),
                          onPressed: showPassWord,
                        ),
                      ),
                      //校验密码
                      validator: (v) {
                        return v.trim().length > 5 ? null : "密码不能少于6位";
                      },
                      obscureText: _passWrodVisibility,
                    ),
                    // 登录按钮
                    Padding(
                      padding: const EdgeInsets.only(top: 28.0),
                      child: Row(
                        children: <Widget>[
                          Expanded(
                            child: RaisedButton(
                              padding: EdgeInsets.all(15.0),
                              child: Text(
                                "登录",
                                style: TextStyle(fontSize: 18),
                              ),
                              color: Colors.black,
                              textColor: Colors.white,
                              onPressed: _loginButtonState(),
                            ),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),
          ]),
          padding: EdgeInsets.only(left: 16, right: 16, top: 220),
        )
      ],
    ));
  }
}
