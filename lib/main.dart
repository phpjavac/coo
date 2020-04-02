import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:password/model/User.dart';
import 'package:password/views/bottomBar/fab_bottom_app_bar.dart';
import 'package:password/views/bottomBar/fab_icons.dart';
import 'package:password/views/bottomBar/layout.dart';
import 'package:password/theme/theme.dart';
import 'package:password/pages/home.dart';
import 'package:password/pages/tag.dart';
import 'package:password/pages/time.dart';
import 'package:password/pages/my.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() => {
      runApp(ChangeNotifierProvider<User>.value(
        value: User(false, true),
        child: MyApp(),
      )),
      if (Platform.isAndroid)
        {
          SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
              statusBarColor: Colors.transparent,

              ///这是设置状态栏的图标和字体的颜色
              ///Brightness.light  一般都是显示为白色
              ///Brightness.dark 一般都是显示为黑色
              statusBarIconBrightness: Brightness.light)),
        }
    };

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      darkTheme: ThemeProvider().getTheme(isDarkMode: true),
      theme: ThemeProvider().getTheme(),
      // routes: ,
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _selectedIndex = 0;
  static const TextStyle optionStyle =
      TextStyle(fontSize: 30, fontWeight: FontWeight.bold);
  static List<Widget> _widgetOptions = <Widget>[
    Homelist(),
    Tag(),
    Time(),
    My()
  ];
  static List homeList = ["首页", "标签", "统计", "我的"];
  _onItemTapped(int index) {
    setState(() {
      // 我的模块
      _selectedIndex = index;
    });
  }

  setUserLoginState(value) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool("loginState", value);
  }

  getUserLoginState() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final loginState = prefs.getBool("loginState");
    return loginState;
  }

  /// 从本地获取登陆状态
  displayUserLoginState() {
    Future<dynamic> loginState = getUserLoginState();
    loginState.then((dynamic loginState) {
      if (loginState != null) {
        Provider.of<User>(context, listen: false).changeLoginState(true);
      } else {
        Provider.of<User>(context, listen: false).changeLoginState(false);
      }
    });
  }

  @override
  void initState() {
    super.initState();
    displayUserLoginState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(homeList[_selectedIndex]),
      ),
      body: Center(
        child: _widgetOptions.elementAt(_selectedIndex),
      ),
      bottomNavigationBar: FABBottomAppBar(
        centerItemText: '',
        color: Colors.grey,
        selectedColor: Theme.of(context).accentColor,
        notchedShape: CircularNotchedRectangle(),
        onTabSelected: _onItemTapped,
        changeLogin: setUserLoginState,
        items: [
          FABBottomAppBarItem(iconData: Icons.menu, text: '首页'),
          FABBottomAppBarItem(iconData: Icons.layers, text: '标签'),
          FABBottomAppBarItem(iconData: Icons.dashboard, text: '统计'),
          FABBottomAppBarItem(iconData: Icons.info, text: '我的'),
        ],
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: _buildFab(
          context), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }

  Widget _buildFab(BuildContext context) {
    final icons = [Icons.menu,Icons.layers, Icons.mail];
    return AnchoredOverlay(
      showOverlay: Provider.of<User>(context, listen: false).showOverlay,
      overlayBuilder: (context, offset) {
        return CenterAbout(
          position: Offset(offset.dx, offset.dy - icons.length * 35.0),
          child: FabWithIcons(
            icons: icons,
            onIconTapped: (index) {},
          ),
        );
      },
      child: FloatingActionButton(
        onPressed: () {},
        child: Icon(Icons.add),
        elevation: 2.0,
      ),
    );
  }
}
