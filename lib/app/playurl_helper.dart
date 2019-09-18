import 'dart:convert' show json;
import 'dart:convert';
import 'package:flutter_bilidown/app/api.dart';
import 'package:flutter_bilidown/models/api_result.dart';
import 'package:flutter_bilidown/models/dash_json_model.dart';
import 'package:flutter_bilidown/models/durl_json_model.dart';
import 'package:flutter_bilidown/models/play_url_model.dart';
import 'package:flutter_bilidown/models/season_model.dart';
import 'package:flutter_bilidown/models/userinfo.dart';
import 'package:flutter_bilidown/models/video_model.dart';
import 'package:http/http.dart' as http;

class PlayUrlHelper {
  static Future<ApiResult<PlayUrlInfo>> getSeasonPlayUrl(
      SeasonInfoResult seasonInfo, Episodes item, int qn,
      {UserInfo userInfo}) async {
    var android = await _getSeasonPlayUrl(false, seasonInfo, item, qn,
        userInfo: userInfo);
    if (android.success) {
      return android;
    } else {
      //使用biliplus
      return await _getSeasonPlayUrl(true, seasonInfo, item, qn,
          userInfo: userInfo);
    }
  }

  static Future<ApiResult<PlayUrlInfo>> getVideoPlayUrl(
      VideoInfoData videoInfo, Pages item, int qn,
      {UserInfo userInfo}) async {
    var android =
        await _getVideoPlayUrl(videoInfo, item, qn, userInfo: userInfo);
    if (android.success) {
      return android;
    } else {
      //使用biliplus
      return await _getVideoPlayUrlBiliplus(videoInfo, item, qn,
          userInfo: userInfo);
    }
  }

  static Future<ApiResult<PlayUrlInfo>> _getSeasonPlayUrl(
      bool useBiliplus, SeasonInfoResult seasonInfo, Episodes item, int qn,
      {UserInfo userInfo}) async {
    try {
      var api = useBiliplus
          ? Api.seasonBiliplusPlayUrl(
              item.aid, item.cid, qn, seasonInfo.season_type,
              access_key: userInfo?.access_key, mid: userInfo?.mid)
          : Api.seasonPlayUrl(item.aid, item.cid, qn, seasonInfo.season_type,
              access_key: userInfo?.access_key, mid: userInfo?.mid);

      var result = await http.get(api);
      var result_body = utf8.decode(result.bodyBytes);
      if (result.statusCode != 200) {
        return ApiResult<PlayUrlInfo>(
            false, "请求错误:" + result.statusCode.toString(), null);
      }
      Map<String, dynamic> jsonMap = jsonDecode(result_body);
      if (jsonMap["code"] != 0) {
        return ApiResult<PlayUrlInfo>(false, jsonMap["message"], null);
      }
      PlayUrlInfo info = PlayUrlInfo();
      info.time_length = jsonMap["timelength"];
      info.video_codec_id = jsonMap["video_codecid"];
      info.urls = [];
      //判断是FLV还是DASH
      if (jsonMap.keys.contains("durl")) {
        info.format = "flv";
        for (var item in jsonMap["durl"]) {
          var playUrlitem = PlayUrlItem();
          playUrlitem.codecid = info.video_codec_id;
          playUrlitem.length = item["length"];
          playUrlitem.order = item["order"];
          playUrlitem.size = item["size"];
          playUrlitem.url = item["url"];
          info.urls.add(playUrlitem);
        }
        return ApiResult<PlayUrlInfo>(true, "", info);
      }
      if (jsonMap.keys.contains("dash")) {
        info.format = "dash";
        var dashData = DashJsonModel.fromJson(jsonMap["dash"]);
        var video = dashData.video.firstWhere(
            (x) => x.codecid == info.video_codec_id && x.id == qn,
            orElse: () => null);
        if (video == null) {
          dashData.video.sort((x, y) => y.id.compareTo(x.id));
          dashData.video.sort((x, y) => x.codecid.compareTo(y.codecid));
          video = dashData.video.first;
        }
        var videoItem = PlayUrlItem();
        videoItem.bandwidth = video.bandwidth;
        videoItem.codecid = video.codecid;
        videoItem.length = 0;
        videoItem.order = 1;
        videoItem.size = video.size;
        videoItem.url = video.base_url;
        info.urls.add(videoItem);
        var audio = dashData.audio.first;
        var audioItem = PlayUrlItem();
        audioItem.bandwidth = audio.bandwidth;
        audioItem.codecid = audio.codecid;
        audioItem.length = 0;
        audioItem.order = 1;
        audioItem.size = audio.size;
        audioItem.url = audio.base_url;
        audioItem.isAudio = true;
        info.urls.add(audioItem);
        return ApiResult<PlayUrlInfo>(true, "", info);
      }
      return ApiResult<PlayUrlInfo>(false, "不支持下载的格式", null);
    } catch (e) {
      print(e);
      return ApiResult<PlayUrlInfo>(false, "请求出现错误", null);
    }
  }

  static Future<ApiResult<PlayUrlInfo>> _getVideoPlayUrlBiliplus(
      VideoInfoData videoInfo, Pages item, int qn,
      {UserInfo userInfo}) async {
    try {
      var api = Api.videoBiliplusPlayUrl(videoInfo.aid, item.cid, qn,
          access_key: userInfo?.access_key, mid: userInfo?.mid);

      var result = await http.get(api);
      var result_body = utf8.decode(result.bodyBytes);
      if (result.statusCode != 200) {
        return ApiResult<PlayUrlInfo>(
            false, "请求错误:" + result.statusCode.toString(), null);
      }
      Map<String, dynamic> jsonMap = jsonDecode(result_body);
      if (jsonMap.containsKey("code") && jsonMap["code"] != 0) {
        return ApiResult<PlayUrlInfo>(false, jsonMap["message"], null);
      }

      PlayUrlInfo info = PlayUrlInfo();
      info.time_length = jsonMap["timelength"];
      info.video_codec_id = jsonMap["video_codecid"];
      info.urls = [];
      //判断是FLV还是DASH
      if (jsonMap.keys.contains("durl")) {
        info.format = "flv";
        for (var item in jsonMap["durl"]) {
          var playUrlitem = PlayUrlItem();
          playUrlitem.codecid = info.video_codec_id;
          playUrlitem.length = item["length"];
          playUrlitem.order = item["order"];
          playUrlitem.size = item["size"];
          playUrlitem.url = item["url"];
          info.urls.add(playUrlitem);
        }
        return ApiResult<PlayUrlInfo>(true, "", info);
      }
      if (jsonMap.keys.contains("dash")) {
        info.format = "dash";
        var dashData = DashJsonModel.fromJson(jsonMap["dash"]);
        var video = dashData.video.firstWhere(
            (x) => x.codecid == info.video_codec_id && x.id == qn,
            orElse: () => null);
        if (video == null) {
          dashData.video.sort((x, y) => y.id.compareTo(x.id));
          dashData.video.sort((x, y) => x.codecid.compareTo(y.codecid));
          video = dashData.video.first;
        }
        var videoItem = PlayUrlItem();
        videoItem.bandwidth = video.bandwidth;
        videoItem.codecid = video.codecid;
        videoItem.length = 0;
        videoItem.order = 1;
        videoItem.size = video.size;
        videoItem.url = video.base_url;
        info.urls.add(videoItem);
        var audio = dashData.audio.first;
        var audioItem = PlayUrlItem();
        audioItem.bandwidth = audio.bandwidth;
        audioItem.codecid = audio.codecid;
        audioItem.length = 0;
        audioItem.order = 1;
        audioItem.size = audio.size;
        audioItem.url = audio.base_url;
        audioItem.isAudio = true;
        info.urls.add(audioItem);
        return ApiResult<PlayUrlInfo>(true, "", info);
      }
      return ApiResult<PlayUrlInfo>(false, "不支持下载的格式", null);
    } catch (e) {
      print(e);
      return ApiResult<PlayUrlInfo>(false, "请求出现错误", null);
    }
  }

  static Future<ApiResult<PlayUrlInfo>> _getVideoPlayUrl(
      VideoInfoData videoInfo, Pages item, int qn,
      {UserInfo userInfo}) async {
    try {
      var api = Api.videoPlayUrl(videoInfo.aid, item.cid, qn,
          access_key: userInfo?.access_key, mid: userInfo?.mid);

      var result = await http.get(api);
      var result_body = utf8.decode(result.bodyBytes);
      if (result.statusCode != 200) {
        return ApiResult<PlayUrlInfo>(
            false, "请求错误:" + result.statusCode.toString(), null);
      }
      Map<String, dynamic> jsonMap = jsonDecode(result_body);
      if (jsonMap["code"] != 0) {
        return ApiResult<PlayUrlInfo>(false, jsonMap["message"], null);
      }
      var dataJsonMap = jsonMap["data"];
      PlayUrlInfo info = PlayUrlInfo();
      info.time_length = dataJsonMap["timelength"];
      info.video_codec_id = dataJsonMap["video_codecid"];
      info.urls = [];
      //判断是FLV还是DASH
      if (dataJsonMap.keys.contains("durl")) {
        info.format = "flv";
        for (var item in dataJsonMap["durl"]) {
          var playUrlitem = PlayUrlItem();
          playUrlitem.codecid = info.video_codec_id;
          playUrlitem.length = item["length"];
          playUrlitem.order = item["order"];
          playUrlitem.size = item["size"];
          playUrlitem.url = item["url"];
          info.urls.add(playUrlitem);
        }
        return ApiResult<PlayUrlInfo>(true, "", info);
      }
      if (dataJsonMap.keys.contains("dash")) {
        info.format = "dash";
        var dashData = DashJsonModel.fromJson(dataJsonMap["dash"]);
        var video = dashData.video.firstWhere(
            (x) => x.codecid == info.video_codec_id && x.id == qn,
            orElse: () => null);
        if (video == null) {
          dashData.video.sort((x, y) => y.id.compareTo(x.id));
          dashData.video.sort((x, y) => x.codecid.compareTo(y.codecid));
          video = dashData.video.first;
        }
        var videoItem = PlayUrlItem();
        videoItem.bandwidth = video.bandwidth;
        videoItem.codecid = video.codecid;
        videoItem.length = 0;
        videoItem.order = 1;
        videoItem.size = video.size;
        videoItem.url = video.base_url;
        info.urls.add(videoItem);
        var audio = dashData.audio.first;
        var audioItem = PlayUrlItem();
        audioItem.bandwidth = audio.bandwidth;
        audioItem.codecid = audio.codecid;
        audioItem.length = 0;
        audioItem.order = 1;
        audioItem.size = audio.size;
        audioItem.url = audio.base_url;
        audioItem.isAudio = true;
        info.urls.add(audioItem);
        return ApiResult<PlayUrlInfo>(true, "", info);
      }
      return ApiResult<PlayUrlInfo>(false, "不支持下载的格式", null);
    } catch (e) {
      print(e);
      return ApiResult<PlayUrlInfo>(false, "请求出现错误", null);
    }
  }
}
