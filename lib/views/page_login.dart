import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_bilidown/app/api.dart';
import 'package:flutter_bilidown/app/app_user_info.dart';
import 'package:flutter_bilidown/models/userinfo.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:http/http.dart' as http;

class LoginPage extends StatefulWidget {
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  UserInfo _userInfo;
  WebViewController _controller;


  @override
  Widget build(BuildContext context) {
    final bool isLogout = ModalRoute.of(context).settings.arguments;
    
    return Scaffold(
      appBar: AppBar(
        title: Text(isLogout ? "退出登录" : "登录"),
      ),
      body: WebView(
        onWebViewCreated: (c){
          _controller = c;
          if(!isLogout){
      Fluttertoast.showToast(msg: "调用哔哩哔哩网页登录，不会记录敏感信息，请放心登录", toastLength: Toast.LENGTH_LONG);
    }
          },

        navigationDelegate: (request) {
          Uri uri = Uri.parse(request.url);
          if (uri.path == "/crossDomain") {
            var cookie = uri.query.replaceAll("&", ";");
            print(cookie);
            if (uri.queryParameters["DedeUserID"] != null &&
                uri.queryParameters["DedeUserID"] != "") {
              _getToken(cookie);

              return NavigationDecision.prevent;
            }
          }
          if (uri.query.contains("access_key")) {
            print("Access_key:${uri.queryParameters["access_key"]}");
            _userInfo.access_key = uri.queryParameters["access_key"];
            _userInfo.expired_time =
                DateTime.now().add(Duration(days: 30)).toString();
           
            Provider.of<AppUserInfo>(context).changeLoginInfo(_userInfo);

            Navigator.pop(context);
            return NavigationDecision.prevent;
          }
          if (request.url == "https://passport.bilibili.com/login?act=exit") {
            Provider.of<AppUserInfo>(context).logout();
          }
          if (request.url == "https://m.bilibili.com/index.html") {
            Navigator.pop(context);
            return NavigationDecision.prevent;
          }
          print(request.url);

          return NavigationDecision.navigate;
        },
        javascriptMode: JavascriptMode.unrestricted,
        initialUrl: isLogout ? Api.logoutWeb : Api.loginWeb,
      ),
    );
  }

  void _getToken(String cookie) async {
    var re = await http.get(
        "https://passport.bilibili.com/login/app/third?appkey=27eb53fc9058f8c3&api=http%3A%2F%2Flink.acg.tv%2Fforum.php&sign=67ec798004373253d60114caaad89a8c",
        headers: {"Cookie": cookie});
    var body = re.body;
    var json = jsonDecode(body);
    if (json["data"]["confirm_uri"] != null) {
      _userInfo = UserInfo(
          name: json["data"]["user_info"]["uname"],
          mid: json["data"]["user_info"]["mid"],
          photo: json["data"]["user_info"]["face"]);
      _controller.loadUrl(json["data"]["confirm_uri"]);
    }

    print(body);
  }
}
