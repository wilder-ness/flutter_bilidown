import 'dart:convert';
import 'package:crypto/crypto.dart';

class Api{
  static final String android_appkey="1d8b6e7d45233436";
  static final String android_appsecret="560c52ccd288fed045859ed18bffd973";
  static final String android_video_appkey="iVGUTjsxvpLeuDCf";
  static final String android_video_appsecret="aHRmhWMLkdeMuILqORnYZocwMBpMEOdt";

  static String get loginWeb=>"https://passport.bilibili.com/login";
  static String get logoutWeb=>"https://account.bilibili.com/login?act=exit";
  static String seasonDetail(int seasonId){
    return "https://bangumi.bilibili.com/view/web_api/season?season_id=$seasonId";
  }
  static String videoDetail(int avId){
    return "https://api.bilibili.com/x/web-interface/view?aid=$avId";
  }
  static String userProfile(int mid){
    return "https://api.bilibili.com/x/space/acc/info?mid=$mid";
  }
  static String danmu(int cid){
    return "https://api.bilibili.com/x/v1/dm/list.so?oid=$cid";
  }
  static String seasonPlayUrl(int aid,int cid,int qn,int seasonType,{String access_key,int mid}){
    var access_info=access_key!=null?"&access_key=$access_key&mid=$mid":"";
    var url="https://api.bilibili.com/pgc/player/api/playurl?aid=$aid&appkey=$android_appkey&build=5442100&cid=$cid&device=android&fnval=16&fnver=0&fourk=1$access_info&mobi_app=android&module=bangumi&npcybs=0&otype=json&platform=android&qn=$qn&season_type=$seasonType&ts=${DateTime.now().millisecondsSinceEpoch}";
    return "$url&sign=${sign(url,android_appsecret)}" ;
  }
  static String seasonBiliplusPlayUrl(int aid,int cid,int qn,int seasonType,{String access_key,int mid}){
    var access_info=access_key!=null?"&access_key=$access_key&mid=$mid":"";
    var url="https://www.biliplus.com/BPplayurl.php?aid=$aid&appkey=$android_appkey&build=5442100&cid=$cid&device=android&fnval=16&fnver=0&fourk=1$access_info&mobi_app=android&module=bangumi&npcybs=0&otype=json&platform=android&qn=$qn&season_type=$seasonType&ts=${DateTime.now().millisecondsSinceEpoch}";
    return "$url&sign=${sign(url,android_appsecret)}" ;
  }

  static String videoPlayUrl(int aid,int cid,int qn,{String access_key,int mid}){
    var access_info=access_key!=null?"&access_key=$access_key&mid=$mid":"";
    var url="https://app.bilibili.com/x/playurl?aid=$aid&actionkey=appkey&appkey=$android_video_appkey&build=5442100&cid=$cid&device=android&fnval=16&fnver=0&fourk=1$access_info&mobi_app=android&npcybs=0&otype=json&platform=android&qn=$qn&ts=${DateTime.now().millisecondsSinceEpoch}";
    return "$url&sign=${sign(url,android_video_appsecret)}" ;
  }
  static String videoBiliplusPlayUrl(int aid,int cid,int qn,{String access_key,int mid}){
    var access_info=access_key!=null?"&access_key=$access_key&mid=$mid":"";
    var url="https://www.biliplus.com/BPplayurl.php?aid=$aid&appkey=$android_video_appkey&build=5442100&cid=$cid&device=android&fnval=16&fnver=0&fourk=1$access_info&mobi_app=android&npcybs=0&otype=json&platform=android&qn=$qn&ts=${DateTime.now().millisecondsSinceEpoch}";
    return "$url&sign=${sign(url,android_video_appsecret)}" ;
  }

  static String sign(String url,String appsecret){
    Uri uri=Uri.parse(url);
    var pars= uri.queryParameters.keys.toList();
    pars.sort();
    var u="";
    for (var item in pars) {
      u+="$item=${uri.queryParameters[item]}&";
    }
    u=u.substring(0,u.length-1)+appsecret;
    return toMd5(u);
  }
  static String toMd5(String input){
    var bytes = utf8.encode(input); 
    var digest = md5.convert(bytes);
    return digest.toString();
  }


}