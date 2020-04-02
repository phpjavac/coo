import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:password/model/User.dart';
import 'package:password/router/router.dart';
import 'package:provider/provider.dart';

class LoginIndex extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<LoginIndex> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage("assets/bg.png"),
              fit: BoxFit.cover,
            ),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: <Widget>[
              Container(
                child: Padding(
                  padding: const EdgeInsets.only(bottom: 80),
                  child: Column(
                    children: [
                      FlatButton(
                        child: Container(
                          height: 60,
                          padding: EdgeInsets.all(8),
                          child: Row(
                            children: <Widget>[
                              Container(
                                  height: 45,
                                  width: 45,
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(15),
                                  ),
                                  child: Icon(
                                    Icons.message,
                                    color: const Color(0xFF1d74db),
                                    size: 32.0,
                                  )),
                              Container(
                                width: 30,
                              ),
                              Text(
                                "使用微信快捷登录",
                                style: TextStyle(
                                    fontSize: 14, color: Colors.white),
                              )
                            ],
                          ),
                          decoration: BoxDecoration(
                            color: Theme.of(context).accentColor,
                            borderRadius: BorderRadius.circular(20),
                          ),
                        ),
                        onPressed: () {},
                      ),
                      Container(
                        height: 50,
                      ),
                      FlatButton(
                        child: Container(
                          height: 60,
                          padding: EdgeInsets.all(8),
                          child: Row(
                            children: <Widget>[
                              Container(
                                  height: 45,
                                  width: 45,
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(15),
                                  ),
                                  child: Icon(
                                    Icons.phone_android,
                                    color: const Color(0xFF1d3566),
                                    size: 32.0,
                                  )),
                              Container(
                                width: 30,
                              ),
                              Text(
                                "使用账号登陆",
                                style: TextStyle(
                                    fontSize: 14, color: Colors.white),
                              )
                            ],
                          ),
                          decoration: BoxDecoration(
                            color: Theme.of(context).accentColor,
                            borderRadius: BorderRadius.circular(20),
                          ),
                        ),
                        onPressed: () {
                          Router.pushNoParams(
                              context,
                              Router.login,
                              ((value) => {
                                    if (value)
                                      {
                                        Provider.of<User>(context,
                                                listen: false)
                                            .changeLoginState(true),
                                        Navigator.of(context).pop(true)
                                      }
                                  }));
                        },
                      ),
                      Container(
                        height: 30,
                      ),
                      FlatButton(
                        child: Text("去注册一个账号   >",
                            style: TextStyle(
                                color: const Color(0xFF2b90e9), fontSize: 14)),
                        onPressed: () {},
                      )
                    ],
                  ),
                ),
              ),
            ],
          )),
    );
  }
}
