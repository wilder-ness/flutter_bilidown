import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bilidown/app/app_settings.dart';
import 'package:flutter_bilidown/app/app_user_info.dart';
import 'package:flutter_bilidown/app/utils.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

class UserPage extends StatefulWidget {
  _UserPageState createState() => _UserPageState();
}

class _UserPageState extends State<UserPage> {
  @override
  Widget build(BuildContext context) {
    return ListView(
      children: <Widget>[
        //主题设置
        Provider.of<AppUserInfo>(context).userInfo == null
            ? Container(
                color: Theme.of(context).cardColor,
                child: ListTile(
                  title: Text("请登录"),
                  leading: Icon(Icons.account_circle),
                  onTap: () =>
                      Navigator.pushNamed(context, "/Login", arguments: false),
                ),
              )
            : Container(
                color: Theme.of(context).cardColor,
                child: ListTile(
                  title: Text(
                    Provider.of<AppUserInfo>(context).userInfo.name,
                  ),
                  subtitle: Text("mid:"+Provider.of<AppUserInfo>(context).userInfo.mid.toString()),
                  trailing: Text(Provider.of<AppUserInfo>(context).userInfo.isVip?"大会员":"",style: TextStyle(color: Theme.of(context).accentColor),),
                  leading: CircleAvatar(
                      backgroundImage: NetworkImage(
                          Provider.of<AppUserInfo>(context).userInfo.photo)),
                  onTap: () => Utils.showAlertDialog(
                      context, Text("注销"), Text("确定要注销登录吗?"),
                      onCancelTaped: () => Navigator.pop(context),
                      onOkTaped: (){Navigator.pop(context);Navigator.pushNamed(context, "/Login",arguments: true);}),
                ),
              ),
        SizedBox(
          height: 16.0,
        ),
        Container(
          color: Theme.of(context).cardColor,
          child: ListTile(
            title: Text("历史记录"),
            leading: Icon(Icons.history),
            trailing: Icon(Icons.chevron_right),
            onTap: () =>Navigator.pushNamed(context, "/History"),
          ),
        ),
        Container(
          color: Theme.of(context).cardColor,
          child: ListTile(
            title: Text("我的收藏"),
            leading: Icon(Icons.favorite_border),
            trailing: Icon(Icons.chevron_right),
            onTap: () =>Navigator.pushNamed(context, "/Favorite"),
          ),
        ),
         SizedBox(
          height: 16.0,
        ),
        Container(
          color: Theme.of(context).cardColor,
          child: ListTile(
            title: Text("修复文件大小显示为0B"),
            leading: Icon(Icons.refresh),
            trailing: Icon(Icons.chevron_right),
            onTap: setFileSize,
          ),
        ),
        SizedBox(
          height: 16.0,
        ),
         Container(
          color: Theme.of(context).cardColor,
          child: ListTile(
            title: Text("应用设置"),
            leading: Icon(Icons.settings),
            trailing: Icon(Icons.chevron_right),
            onTap: () =>Navigator.pushNamed(context, "/Settings"),
          ),
        ),
        Container(
          color: Theme.of(context).cardColor,
          child: ListTile(
            title: Text("使用帮助"),
            leading: Icon(Icons.help_outline),
            trailing: Icon(Icons.chevron_right),
            onTap: () =>launch("http://pic.nsapps.cn/bilidown/help.html"),
          ),
        ),
         SizedBox(
          height: 16.0,
        ),
         Container(
          color: Theme.of(context).cardColor,
          child: ListTile(
            title: Text("赞助作者"),
            leading: Icon(Icons.favorite),
            trailing: Icon(Icons.chevron_right),
            onTap: () async{
              if(await Utils.showAlertDialogAsync(context, Text("赞助作者"), Text("如果觉得好用,请我喝杯茶吧\r\n支付宝:2500655055@qq.com"))){
                launch("https://qr.alipay.com/FKX06526G3SYZ8MZZE2Q77");
              }
            },
          ),
        ),
      ],
    );
  }

  void setFileSize() async{
    try {
      var path = Provider.of<AppSettings>(context).downPath +
        "/Android/Data/" +Provider.of<AppSettings>(context).appType +"/download/";
    var dir = Directory(path);
    if(!await dir.exists()){
      Fluttertoast.showToast(msg: "请检查下你的路径是否设置正确");
    }

    var videoList=await dir.listSync();
    for (var item in videoList) 
    {
      var epList=Directory(item.path).listSync();
      for (var item2 in epList) {
        var dir=  Directory(item2.path);
        var enrtyJson=File(dir.path+"/entry.json");
        var jsonMap=jsonDecode(await enrtyJson.readAsString());
        if(jsonMap["total_bytes"]==0){
          //读取文件大小
          var dir_videos=Directory(dir.path+"/"+jsonMap["type_tag"]);
          var size=0;
          for (var item in dir_videos.listSync()) {
            if(item.path.contains(".m4s")||item.path.contains(".blv")){
              size+=await File(item.path).length();
            }
          }
          jsonMap["total_bytes"]=size;
          jsonMap["downloaded_bytes"]=size;
          enrtyJson.writeAsString(jsonEncode(jsonMap),flush: true);
          //print(jsonEncode(jsonMap));
        }
        
      }
       Fluttertoast.showToast(msg: "全部视频设置完成");
    }
    } catch (e) {
      Fluttertoast.showToast(msg: "修复失败");
    }
    
  }

}
