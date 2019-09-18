import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_bilidown/app/api.dart';
import 'package:flutter_bilidown/app/utils.dart';
import 'package:flutter_bilidown/models/user_model.dart';
import 'package:flutter_bilidown/models/userinfo.dart';
import 'package:http/http.dart' as http;

class AppUserInfo with ChangeNotifier {
  //登录获得的用户信息,含Token
  UserInfo _userInfo;
  UserInfo get userInfo => _userInfo;
  void changeLoginInfo(UserInfo value) async{
    if(value!=null&&value.isVip==null){
      value.isVip=await getIsVip(value.mid);
    }
    _userInfo = value;
    notifyListeners();
    Utils.prefs.setString("userInfo", value.toString());
  }

  void logout() {
    changeLoginInfo(null);
  }

  
  Future<bool> getIsVip(int mid) async {
    try {
      var result = await http.get(Api.userProfile(mid));
      UserProfile data = UserProfile.fromJson(jsonDecode(result.body));
      if (data.code == 0) {
        return data.data.vip.status!=0;
      } else {
        return false;
      }
    } catch (e) {
      return false;
    }
  }
}
