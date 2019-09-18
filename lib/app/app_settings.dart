import 'package:flutter/material.dart';
import 'package:flutter_bilidown/app/utils.dart';

class AppSettings with ChangeNotifier {
  static Map<String, Color> themeColors = {
    "胖次蓝": Colors.blue,
    "姨妈红": Colors.red,
    "咸蛋黄": Colors.yellow,
    "早苗绿": Colors.green,
    "少女粉": Colors.pink,
    "基佬紫": Colors.purple,
    "朴素灰": Colors.blueGrey
  };

  void showThemeDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return new SimpleDialog(
          title: new Text('切换主题'),
          children: _createThemeWidget(context),
        );
      },
    );
  }

  List<Widget> _createThemeWidget(BuildContext context) {
    List<Widget> widgets = List<Widget>();
    for (var item in AppSettings.themeColors.keys) {
      widgets.add(RadioListTile(
        groupValue: item,
        value: _themeColorName,
        title: new Text(item,style: TextStyle(color: AppSettings.themeColors[item]),),
        onChanged: (value) {
          changeThemeColor(AppSettings.themeColors.keys.toList().indexOf(item));
          Navigator.of(context).pop();
        },
      ));
    }
    return widgets;
  }

  bool _isDark;
  Color _themeColor;
  String _themeColorName;
  get themeColor => _themeColor;
  get themeColorName => _themeColorName;
  void changeDark(bool value) {
    _isDark = value;

    notifyListeners();
    Utils.prefs.setBool("isDark", value);
  }

  get isDark => _isDark;

  void changeThemeColor(int index) {
    _themeColor = AppSettings.themeColors.values.toList()[index];
    _themeColorName = AppSettings.themeColors.keys.toList()[index];
    notifyListeners();
    Utils.prefs.setInt("themeColor", index);
  }


  String _appType;
  get appType => _appType;
  String _appTypeName;
  get appTypeName => _appTypeName;

  static Map<String, String> appTypes = {
    "正式版(tv.danmaku.bili)": "tv.danmaku.bili",
    "概念版(com.bilibili.app.blue)": "com.bilibili.app.blue",
    "Play版(com.bilibili.app.in)": "com.bilibili.app.in"
  };
   void changeAppType(int index) {
    _appType = AppSettings.appTypes.values.toList()[index];
    _appTypeName = AppSettings.appTypes.keys.toList()[index];
    notifyListeners();
    Utils.prefs.setInt("appType", index);
  }
    void showAppTypeDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return new SimpleDialog(
          title: new Text('客户端类型'),
          children: _createAppTypeWidget(context),
        );
      },
    );
  }

  List<Widget> _createAppTypeWidget(BuildContext context) {
    List<Widget> widgets = List<Widget>();
    for (var item in AppSettings.appTypes.keys) {
      widgets.add(RadioListTile(
        groupValue: item,
        value: _appTypeName,
        title: new Text(item),
        onChanged: (value) {
          changeAppType(AppSettings.appTypes.keys.toList().indexOf(item));
          Navigator.of(context).pop();
        },
      ));
    }
    return widgets;
  }

  String _downPath;
  String get downPath => _downPath;
  void changeDownPath(String value) {
    _downPath = value;
    notifyListeners();
    Utils.prefs.setString("downPath", value);
  }

  int _quality;
  int get quality => _quality;
  String _qualityName;
  get qualityName => _qualityName;

  static Map<String, int> qualits = {
    "4K(部分视频,大会员)": 120,
    "1080P+(大会员)": 112,
    "1080P": 80,
    "720P": 64,
    "480P": 32,
    "360P": 16,
  };
   void changeQualits(int index) {
    _quality = AppSettings.qualits.values.toList()[index];
    _qualityName = AppSettings.qualits.keys.toList()[index];
    notifyListeners();
    Utils.prefs.setInt("quality", index);
  }
  void showQualitsDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return new SimpleDialog(
          title: new Text('首选清晰度'),
          children: _createQualityWidget(context),
        );
      },
    );
  }
  List<Widget> _createQualityWidget(BuildContext context) {
    List<Widget> widgets = List<Widget>();
    for (var item in AppSettings.qualits.keys) {
      widgets.add(RadioListTile(
        groupValue: item,
        value: _qualityName,
        title: new Text(item),
        onChanged: (value) {
          changeQualits(AppSettings.qualits.keys.toList().indexOf(item));
          Navigator.of(context).pop();
        },
      ));
    }
    return widgets;
  }

  bool _useOtherDownloader;
  get useOtherDownloader => _useOtherDownloader;

  void changeDownloader(bool value) {
    _useOtherDownloader = value;
    notifyListeners();
    Utils.prefs.setBool("useOtherDownloader", value);
  }

  

}
