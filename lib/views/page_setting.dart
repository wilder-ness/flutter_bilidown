import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bilidown/app/app_settings.dart';
import 'package:flutter_bilidown/app/folder_picker.dart';
import 'package:flutter_bilidown/app/utils.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:package_info/package_info.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';



class SettingPage extends StatelessWidget {


  @override
  Widget build(BuildContext context){
   
    return Scaffold(
      appBar: AppBar(
        title: Text("设置"),
      ),
      body: ListView(
        children: <Widget>[
          Container(
            color: Theme.of(context).cardColor,
            child: SwitchListTile(
              onChanged: (value) {
                Provider.of<AppSettings>(context).changeDark(value);
              },
              title: Text("夜间模式"),
              value: Provider.of<AppSettings>(context).isDark,
            ),
          ),
          //主题设置
          Container(
            color: Theme.of(context).cardColor,
            child: ListTile(
              title: Text("主题切换"),
              trailing: Padding(
                padding: EdgeInsets.all(8),
                child: Text(
                  Provider.of<AppSettings>(context).themeColorName,
                  style: TextStyle(
                      color: Provider.of<AppSettings>(context).themeColor,
                      fontSize: 14.0),
                ),
              ),
              onTap: () => Provider.of<AppSettings>(context).showThemeDialog(
                  context), //Provider.of<AppThemeData>(context).changeThemeColor(3),
            ),
          ),
         SizedBox(height: 16.0,),
           Container(
            color: Theme.of(context).cardColor,
            child: ListTile(
              title: Text("首选清晰度(向下匹配)"),
              subtitle: Text(Provider.of<AppSettings>(context).qualityName),
              onTap: () => Provider.of<AppSettings>(context).showQualitsDialog(context),
            ),
          ),
          SizedBox(height: 16.0,),
          //应用类型
          Container(
            color: Theme.of(context).cardColor,
            child: ListTile(
              title: Text("客户端类型"),
              subtitle: Text(Provider.of<AppSettings>(context).appTypeName),
              onTap: () => Provider.of<AppSettings>(context).showAppTypeDialog(context),
            ),
          ),
           Container(
            color: Theme.of(context).cardColor,
            child: ListTile(
              title: Text("存储位置(需与哔哩哔哩目录一致)"),
              subtitle: Text(Provider.of<AppSettings>(context).downPath),
              onTap: () {
                Navigator.of(context).push<FolderPicker>(MaterialPageRoute(builder: (BuildContext context) {
                  return FolderPicker(
                      rootDirectory: Directory("/storage"),
                      action: (BuildContext context, Directory folder) async {
                         Provider.of<AppSettings>(context).changeDownPath(folder.path);
                      });
                }));
              },
            ),
          ),
           Container(
            color: Theme.of(context).cardColor,
            child: SwitchListTile(
              onChanged: (value) {
                Provider.of<AppSettings>(context).changeDownloader(value);
              },
              
              title: Text("使用其他下载器下载"),
              value: Provider.of<AppSettings>(context).useOtherDownloader,
            ),
          ),
          SizedBox(height: 16.0,),
           Container(
          color: Theme.of(context).cardColor,
          child: ListTile(
            title: Text("检查更新"),
            leading: Icon(Icons.update),
            trailing: Icon(Icons.chevron_right),
            onTap: () async{
             
              var newVer=await Utils.checkVersion();
              if(!newVer.success){
                Fluttertoast.showToast(msg: "已经是最新版本了");
                 return;
              }
              if(await Utils.showAlertDialogAsync(context, Text(newVer.data.titile), Text(newVer.data.message))){
                launch(newVer.data.url);
              }
            },
          ),
        ),
          Container(
          color: Theme.of(context).cardColor,
          child: ListTile(
            title: Text("关于应用"),
            leading: Icon(Icons.info_outline),
            trailing: Icon(Icons.chevron_right),
            onTap: () async{
               PackageInfo packageInfo= await PackageInfo.fromPlatform();
               showDialog(
              context: context,
              builder: (_)=>AboutDialog(
                applicationIcon: Image(image: AssetImage("assets/ic_launcher.png"),width: 56,),
                applicationName: "哔哩下载工具Flutter",
                applicationVersion: "${packageInfo.version} (${packageInfo.buildNumber})",
                children: <Widget>[
                  Text("此程序仅供学习交流编程技术使用,如侵犯你的合法权益，请联系本人以第一时间删除")
                ],
              )
            );
            },
          ),
        )
        ],
      ),
    );
  }
}
