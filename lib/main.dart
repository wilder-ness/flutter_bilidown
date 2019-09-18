import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bilidown/app/app_settings.dart';
import 'package:flutter_bilidown/app/app_user_info.dart';
import 'package:flutter_bilidown/models/userinfo.dart';
import 'package:flutter_bilidown/sql/favorite.dart';
import 'package:flutter_bilidown/sql/history.dart';
import 'package:flutter_bilidown/views/page_download.dart';
import 'package:flutter_bilidown/views/page_favorite.dart';
import 'package:flutter_bilidown/views/page_history.dart';
import 'package:flutter_bilidown/views/page_login.dart';
import 'package:flutter_bilidown/views/page_parse.dart';
import 'package:flutter_bilidown/views/page_setting.dart';
import 'package:flutter_bilidown/views/page_user.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sqflite/sqflite.dart';
import 'package:url_launcher/url_launcher.dart';

import 'app/utils.dart';

void main() async {
  Utils.prefs = await SharedPreferences.getInstance();
  var appSetting = AppSettings();
  appSetting.changeDark(Utils.prefs.getBool("isDark") ?? false);
  appSetting.changeDownloader(Utils.prefs.getBool("useOtherDownloader") ?? false);
  appSetting.changeThemeColor(Utils.prefs.getInt("themeColor") ?? 0);
  appSetting.changeAppType(Utils.prefs.getInt("appType") ?? 0);
  appSetting.changeQualits(Utils.prefs.getInt("quality") ?? 2);
  appSetting.changeDownPath(
      Utils.prefs.getString("downPath") ?? "/storage/emulated/0");
  var userInfo = AppUserInfo();
  var userInfoString = Utils.prefs.getString("userInfo");
  userInfo.changeLoginInfo(
      (userInfoString != null && userInfoString.length != 0)
          ? UserInfo.fromJson(jsonDecode(userInfoString))
          : null);
  var path = await getDatabasesPath();

  for (var item in Directory(path).listSync()) {
    if (item.path.contains("bili_down")) {
      await item.delete();
    }
  }
  var db = await openDatabase("bili_down.db", version: 1,
      onCreate: (Database _db, int version) async {
    await _db.execute('''
create table $tableFavorite ( 
  $favoriteColumnId text primary key, 
  $favoriteColumnTitle text not null,
  $favoriteColumnIsSeason integer not null,
  $favoriteColumnCover text not null)
''');
    await _db.execute('''
create table $tableHistory ( 
  $historyColumnId text primary key not null, 
  $historyColumnTitle text not null,
  $historyColumnIsSeason integer not null,
  $historyColumnTime integer not null)
''');
  });

  HistoryProvider.db = db;
  FavoriteProvider.db = db;
  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider<AppSettings>.value(value: appSetting),
      ChangeNotifierProvider<AppUserInfo>.value(value: userInfo),
    ],
    child: MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: '哔哩下载工具Flutter',
      theme: ThemeData(
        brightness: Provider.of<AppSettings>(context).isDark
            ? Brightness.dark
            : Brightness.light,
        primarySwatch: Provider.of<AppSettings>(context).themeColor,
      ),
      home: MyHomePage(title: '哔哩下载工具Flutter'),
      routes: {
        "/Login": (_) => LoginPage(),
        "/Settings": (_) => SettingPage(),
        "/History": (_) => HistoryPage(),
        "/Favorite": (_) => FavoritePage(),
      },
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  List<Widget> _pages = [
    ParsePage(),
    DownloadPage(),
    UserPage(),
  ];
  int _index = 0;

  @override
  void initState() {
    super.initState();
    Utils.checkPermission();
    Utils.eventBus_openId.on<String>().listen((data) {
      setState(() {
        _index = 0;
      });
    });
    CheckUpdate();
  }

  void CheckUpdate() async {
    var newVer = await Utils.checkVersion();
    if (!newVer.success) {
      return;
    }
    if (await Utils.showAlertDialogAsync(
        context, Text(newVer.data.titile), Text(newVer.data.message))) {
      launch(newVer.data.url);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(widget.title),
        ),
        bottomNavigationBar: BottomNavigationBar(
          onTap: (i) {
            setState(() {
              _index = i;
            });
          },
          currentIndex: _index,
          items: [
            BottomNavigationBarItem(
                icon: Icon(Icons.search), title: Text("解析")),
            BottomNavigationBarItem(
                icon: Icon(Icons.file_download), title: Text("下载")),
            BottomNavigationBarItem(
                icon: Icon(Icons.account_circle), title: Text("我的"))
          ],
        ),
        body: IndexedStack(
          index: _index,
          children: _pages,
        ));
  }
}
