import 'dart:convert';

import 'package:event_bus/event_bus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bilidown/models/api_result.dart';
import 'package:flutter_bilidown/models/version_info.dart';
import 'package:package_info/package_info.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class Utils {
  static SharedPreferences prefs;
  static EventBus eventBus_openId = EventBus();
  static EventBus eventBus_startDown = EventBus();
  static void showSnackbarWithAction(
      BuildContext context, String content, String action, Function onPressed) {
    final snackBar = new SnackBar(
        content: new Text(content),
        action: new SnackBarAction(label: action, onPressed: onPressed));

    Scaffold.of(context).showSnackBar(snackBar);
  }

  static void showSnackbar(BuildContext context, String content,
      {Duration duration}) {
    final snackBar = new SnackBar(
      content: new Text(content),
      duration: duration,
    );

    Scaffold.of(context).showSnackBar(snackBar);
  }

  static void showAlertDialog(
      BuildContext context, Widget title, Widget content,
      {Function onOkTaped, Function onCancelTaped}) {
    showDialog(
        context: context,
        builder: (_) => AlertDialog(
              title: title,
              content: content,
              actions: <Widget>[
                new FlatButton(
                  child: new Text("确定"),
                  onPressed: onOkTaped,
                ),
                new FlatButton(
                  child: new Text("取消"),
                  onPressed: onCancelTaped,
                )
              ],
            ));
  }

  static Future<bool> showAlertDialogAsync(
      BuildContext context, Widget title, Widget content) async {
    bool result = false;
    await showDialog(
        context: context,
        builder: (_) => AlertDialog(
              title: title,
              content: content,
              actions: <Widget>[
                new FlatButton(
                  child: new Text("确定"),
                  onPressed: () {
                    result = true;
                    Navigator.of(context).pop();
                  },
                ),
                new FlatButton(
                  child: new Text("取消"),
                  onPressed: () {
                    result = false;
                    Navigator.of(context).pop();
                  },
                )
              ],
            ));
    return result;
  }

  static Future<bool> checkPermission() async {
    PermissionStatus permission = await PermissionHandler()
        .checkPermissionStatus(PermissionGroup.storage);
    if (permission != PermissionStatus.granted) {
      Map<PermissionGroup, PermissionStatus> permissions =
          await PermissionHandler()
              .requestPermissions([PermissionGroup.storage]);
      if (permissions[PermissionGroup.storage] == PermissionStatus.granted) {
        return true;
      } else {
        return false;
      }
    } else {
      return true;
    }
  }

  static Future<ApiResult<VersionInfo>> checkVersion() async {
    try {
      var new_version =
          await http.get("http://pic.nsapps.cn/bilidown/bilidown.json");
      var ver_info= VersionInfo.fromJson(jsonDecode(utf8.decode(new_version.bodyBytes)));
      PackageInfo packageInfo = await PackageInfo.fromPlatform();
      if(packageInfo.buildNumber !=ver_info.buildNumber){
        return ApiResult<VersionInfo>(true, "有新版本", ver_info);
      }else{
        return ApiResult<VersionInfo>(false, "检查失败", null);
      }
    } catch (e) {
       return ApiResult<VersionInfo>(false, "检查失败", null);
    }
  }
}
