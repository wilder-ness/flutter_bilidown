import 'dart:convert';
import 'dart:io';

import 'package:event_bus/event_bus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bilidown/app/api.dart';
import 'package:flutter_bilidown/app/app_settings.dart';
import 'package:flutter_bilidown/app/app_user_info.dart';
import 'package:flutter_bilidown/app/playurl_helper.dart';
import 'package:flutter_bilidown/app/utils.dart';
import 'package:flutter_bilidown/models/entry_json_season.dart';
import 'package:flutter_bilidown/models/entry_json_video.dart';
import 'package:flutter_bilidown/models/index_json_dash.dart';
import 'package:flutter_bilidown/models/index_json_flv.dart';
import 'package:flutter_bilidown/models/play_url_model.dart';
import 'package:flutter_bilidown/models/season_model.dart';
import 'package:flutter_bilidown/models/userinfo.dart';
import 'package:flutter_bilidown/models/video_model.dart';
import 'package:flutter_bilidown/sql/favorite.dart';
import 'package:flutter_bilidown/sql/history.dart';
import 'package:flutter_bilidown/views/page_downinfo.dart';
import 'package:flutter_downloader/flutter_downloader.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:progress_dialog/progress_dialog.dart';
import 'package:provider/provider.dart';
import 'package:receive_sharing_intent/receive_sharing_intent.dart';

class ParsePage extends StatefulWidget {
  _ParsePageState createState() => _ParsePageState();
}

class _ParsePageState extends State<ParsePage> {
  TextEditingController _controller;
  bool isParsed = false;
  bool isSeason = false;
  bool isFavorite = false;
  int seasonId = 0;
  int avid = 0;
  SeasonInfoResult _seasonInfo;
  VideoInfoData _videoInfo;
  ProgressDialog pr;
  @override
  void initState() {
    super.initState();
    pr = ProgressDialog(context,
        type: ProgressDialogType.Normal, isDismissible: true, showLogs: true);

    _controller = TextEditingController();
    ReceiveSharingIntent.getInitialText().then((String value) {
      if (value != null) {
        setState(() {
          _controller.text = value;
          parse();
        });
      }
    });
    Utils.eventBus_openId.on<String>().listen((data) {
      setState(() {
        _controller.text = data;
        parse();
      });
    });
  }

  Future parse() async {
    var url = _controller.text;
    RegExp ssExp = new RegExp(r'ss(\d+)');
    if (ssExp.hasMatch(url)) {
      setState(() {
        isSeason = true;
        seasonId = int.parse(ssExp.firstMatch(url).group(1));
      });
      loadSeason(seasonId);
      return;
    }
    RegExp epExp = new RegExp(r'ep(\d+)');
    if (epExp.hasMatch(url)) {
      var sid = await getSeasonId(epExp.firstMatch(url).group(1));
      if (sid == 0) {
        Fluttertoast.showToast(msg: "解析失败", toastLength: Toast.LENGTH_SHORT);
        return;
      }
      setState(() {
        isSeason = true;
        seasonId = sid;
      });
      loadSeason(seasonId);
      return;
    }

    RegExp avExp = new RegExp(r'av(\d+)');
    if (avExp.hasMatch(url)) {
      setState(() {
        isSeason = false;
        avid = int.parse(avExp.firstMatch(url).group(1));
      });
      loadVideo(avid);
      return;
    }

    Fluttertoast.showToast(msg: "解析失败,检查你的链接", toastLength: Toast.LENGTH_SHORT);
  }

  Future<int> getSeasonId(String epid) async {
    try {
      var result =
          await http.get("https://www.bilibili.com/bangumi/play/ep$epid");
      return int.parse(RegExp(r'ss(\d+)').firstMatch(result.body).group(1));
    } catch (e) {
      return 0;
    }
  }

  void loadSeason(int seasonId) async {
    pr.update(message: "读取数据中...");
    pr.show();
    try {
      var result = await http.get(Api.seasonDetail(seasonId));
      var data = SeasonInfo.fromJson(jsonDecode(result.body));
      if (data.code == 0) {
        var favorite = await FavoriteProvider.getItem("ss$seasonId");
        setState(() {
          _seasonInfo = data.result;
          isParsed = true;
          _videoInfo = null;
          isFavorite = favorite != null;
        });
        var historyItem = await HistoryProvider.getItem("ss$seasonId");
        if (historyItem == null) {
          await HistoryProvider.insert(History("ss$seasonId", data.result.title,
              true, DateTime.now().millisecondsSinceEpoch));
        } else {
          historyItem.datetime = DateTime.now().millisecondsSinceEpoch;
          await HistoryProvider.update(historyItem);
        }
      } else {
        Fluttertoast.showToast(
            msg: data.message, toastLength: Toast.LENGTH_LONG);
      }
    } catch (e) {
      Fluttertoast.showToast(msg: "读取出错", toastLength: Toast.LENGTH_LONG);
    } finally {
      pr.hide();
    }
  }

  void loadVideo(int avid) async {
    pr.update(message: "读取数据中...");
    pr.show();
    try {
      var result = await http.get(Api.videoDetail(avid));
      var data = VideoInfo.fromJson(jsonDecode(result.body));
      if (data.code == 0) {
        var favorite = await FavoriteProvider.getItem("av$avid");
        setState(() {
          _videoInfo = data.data;
          _seasonInfo = null;
          isParsed = true;
          isFavorite = favorite != null;
        });
        var historyItem = await HistoryProvider.getItem("av$avid");
        if (historyItem == null) {
          await HistoryProvider.insert(History("av$avid", data.data.title, true,
              DateTime.now().millisecondsSinceEpoch));
        } else {
          historyItem.datetime = DateTime.now().millisecondsSinceEpoch;
          await HistoryProvider.update(historyItem);
        }
      } else {
        Fluttertoast.showToast(
            msg: data.message, toastLength: Toast.LENGTH_LONG);
      }
    } catch (e) {
      Fluttertoast.showToast(msg: "读取出错", toastLength: Toast.LENGTH_LONG);
    } finally {
      pr.hide();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Padding(
          child: TextField(
            controller: _controller,
            textInputAction: TextInputAction.search,
            decoration: InputDecoration(
              fillColor: Colors.transparent,
              filled: false,
              hintText: '输入哔哩哔哩视频地址',
              prefixIcon: Icon(Icons.search),
            ),
            onSubmitted: (e) => parse(),
          ),
          padding: EdgeInsets.all(8),
        ),
        Expanded(
          child: Offstage(
            offstage: !isParsed,
            child: isSeason ? getSeasonWidget() : getVideoWidget(),
          ),
        )
      ],
    );
  }

  Widget getSeasonWidget() {
    return RefreshIndicator(
      onRefresh: parse,
      child: SingleChildScrollView(
          child: Column(
        children: <Widget>[
          Container(
            padding: EdgeInsets.all(8),
            child: Row(
              children: <Widget>[
                _seasonInfo != null
                    ? Image(
                        image: NetworkImage(_seasonInfo.cover),
                        height: 120,
                      )
                    : SizedBox(),
                SizedBox(
                  width: 8.0,
                ),
                Expanded(
                  child: Container(
                    height: 120,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: <Widget>[
                        Text(_seasonInfo != null ? _seasonInfo.title : ""),
                        SizedBox(
                          height: 4.0,
                        ),
                        Text(
                          "评分：${_seasonInfo != null && _seasonInfo.rating != null ? _seasonInfo.rating.score ?? "没有评分" : "没有评分"}",
                          style: TextStyle(color: Colors.grey),
                        ),
                        SizedBox(
                          height: 4.0,
                        ),
                        Text(
                          _seasonInfo != null ? _seasonInfo.newest_ep.desc : "",
                          style: TextStyle(color: Colors.grey),
                        ),
                        SizedBox(
                          height: 4.0,
                        ),
                        Text(
                          _seasonInfo != null && _seasonInfo.payment != null
                              ? _seasonInfo.payment.tip
                              : "",
                          style: TextStyle(color: Colors.grey),
                        ),
                      ],
                    ),
                  ),
                ),
                AnimatedSwitcher(
                    duration: Duration(milliseconds: 300),
                    transitionBuilder: (child, animation) =>
                        ScaleTransition(child: child, scale: animation),
                    child: IconButton(
                      key: ValueKey(isFavorite.toString()),
                      onPressed: setFavorite,
                      icon: !isFavorite
                          ? Icon(Icons.favorite_border)
                          : Icon(
                              Icons.favorite,
                              color: Theme.of(context).accentColor,
                            ),
                    ))
              ],
            ),
          ),
          _seasonInfo != null
              ? ListView.builder(
                  shrinkWrap: true,
                  physics: ScrollPhysics(),
                  itemCount: _seasonInfo.episodes.length,
                  itemBuilder: (context, index) {
                    return ListTile(
                      onTap: () => clickEpisode(
                          _seasonInfo, _seasonInfo.episodes[index]),
                      title: Text(
                          "${_seasonInfo.episodes[index].index} ${_seasonInfo.episodes[index].index_title}"),
                      trailing: Text(
                        _seasonInfo.episodes[index].badge ?? "",
                        style: TextStyle(color: Theme.of(context).accentColor),
                      ),
                      subtitle: Text(checkExist(true, _seasonInfo.season_id,
                              _seasonInfo.episodes[index].ep_id)
                          ? "已存在"
                          : "未下载"),
                    );
                  },
                )
              : Text("")
        ],
      )),
    );
  }

  Widget getVideoWidget() {
    return RefreshIndicator(
      onRefresh: parse,
      child: SingleChildScrollView(
          child: Column(
        children: <Widget>[
          Container(
            padding: EdgeInsets.all(8),
            child: Row(
              children: <Widget>[
                _videoInfo != null
                    ? Image(
                        image: NetworkImage(_videoInfo.pic),
                        height: 80,
                      )
                    : SizedBox(),
                SizedBox(
                  width: 8.0,
                ),
                Expanded(
                  child: Container(
                    height: 100,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: <Widget>[
                        Text(_videoInfo != null ? _videoInfo.title : "",
                            maxLines: 2, overflow: TextOverflow.ellipsis),
                        SizedBox(
                          height: 4.0,
                        ),
                        Text(
                          "${_videoInfo != null ? _videoInfo.tname : ""}",
                          style: TextStyle(color: Colors.grey),
                        ),
                        SizedBox(
                          height: 4.0,
                        ),
                        Text(
                          _videoInfo != null ? _videoInfo.owner.name : "",
                          style: TextStyle(color: Colors.grey),
                        )
                      ],
                    ),
                  ),
                ),
                AnimatedSwitcher(
                    duration: Duration(milliseconds: 300),
                    transitionBuilder: (child, animation) =>
                        ScaleTransition(child: child, scale: animation),
                    child: IconButton(
                      key: ValueKey(isFavorite.toString()),
                      onPressed: setFavorite,
                      icon: !isFavorite
                          ? Icon(Icons.favorite_border)
                          : Icon(
                              Icons.favorite,
                              color: Theme.of(context).accentColor,
                            ),
                    ))
              ],
            ),
          ),
          _videoInfo != null
              ? ListView.builder(
                  shrinkWrap: true,
                  physics: ScrollPhysics(),
                  itemCount: _videoInfo.pages.length,
                  itemBuilder: (context, index) {
                    return ListTile(
                      onTap: () =>
                          clickPart(_videoInfo, _videoInfo.pages[index]),
                      title: Text(
                          "${_videoInfo.pages[index].page} ${_videoInfo.pages[index].part}"),
                      subtitle: Text(checkExist(false, _videoInfo.aid,
                              _videoInfo.pages[index].page)
                          ? "已存在"
                          : "未下载"),
                    );
                  },
                )
              : Text("")
        ],
      )),
    );
  }

  void setFavorite() async {
    var id = "ss$seasonId";
    if (!isSeason) {
      id = "av$avid";
    }
    var title = isSeason ? _seasonInfo.title : _videoInfo.title;
    var cover = isSeason ? _seasonInfo.cover : _videoInfo.pic;
    if (!isFavorite) {
      FavoriteProvider.insert(Favorite(id, title, isSeason, cover));
      setState(() {
        isFavorite = true;
      });
    } else {
      FavoriteProvider.delete(id);
      setState(() {
        isFavorite = false;
      });
    }
  }

  void clickEpisode(SeasonInfoResult seasonInfo, Episodes item) async {
    try {
      //检查权限
      if (!await Utils.checkPermission()) {
        Fluttertoast.showToast(msg: "兄弟,没权限我下载不了啊T_T");
        return;
      }

      //检查是否存在文件
      var exist = checkExist(true, seasonInfo.season_id, item.ep_id);
      if (exist &&
          !await Utils.showAlertDialogAsync(
              context, Text("文件已存在"), Text("文件已经存在，是否覆盖重新下载?"))) {
        return;
      }
      //检查是否登录和需要大会员
      var userInfo = Provider.of<AppUserInfo>(context).userInfo;
      if (item.episode_status != 2 && (userInfo == null || !userInfo.isVip)) {
        Fluttertoast.showToast(msg: "大会员才能下载哦");
        return;
      }
      pr.update(message: "读取视频地址...");
      pr.show();
      //获取首选清晰度
      var qn = Provider.of<AppSettings>(context).quality;

      //读取下载地址
      var playUrlData = await PlayUrlHelper.getSeasonPlayUrl(
          seasonInfo, item, qn,
          userInfo: userInfo);
      if (!playUrlData.success) {
        Fluttertoast.showToast(msg: playUrlData.message);
        return;
      }
      pr.update(message: "创建文件夹...");
      //创建剧集文件夹写入entry.json和danmaku.xml
      var path_episode = Provider.of<AppSettings>(context).downPath +
          "/Android/Data/" +
          Provider.of<AppSettings>(context).appType +
          "/download/s_${seasonInfo.season_id}/${item.ep_id}";
      //创建文件夹
      var dir_episode = await Directory(path_episode).create(recursive: true);
      //创建entry.json
      var entry_json = SeasonEntryJson.create(
          playUrlData.data.format == "dash", qn, seasonInfo, item);
      //创建entry.json
      await File(dir_episode.path + "/entry.json")
          .writeAsString(entry_json.toString(), mode: FileMode.write);
      pr.update(message: "下载弹幕...");
      //创建danmaku.xml
      await File(dir_episode.path + "/danmaku.xml")
          .writeAsString(await getDanmu(item.cid), mode: FileMode.write);

      //创建清晰度命名的文件夹写入index.json
      var dir_video = await Directory(path_episode + "/" + entry_json.type_tag)
          .create(recursive: true);
      pr.update(message: "准备下载...");
      //写入index.json
      if (playUrlData.data.format == "dash") {
        var index_json = DashIndexJson(video: [
          Video(
              id: qn,
              base_url: playUrlData.data.urls[0].url,
              bandwidth: playUrlData.data.urls[0].bandwidth,
              codecid: playUrlData.data.urls[0].codecid,
              size: playUrlData.data.urls[0].size,
              md5: "")
        ], audio: [
          Audio(
              id: qn,
              base_url: playUrlData.data.urls[1].url,
              bandwidth: playUrlData.data.urls[1].bandwidth,
              codecid: playUrlData.data.urls[1].codecid,
              size: playUrlData.data.urls[1].size,
              md5: "")
        ]).toString();
        await File(dir_video.path + "/index.json")
            .writeAsString(index_json.toString(), mode: FileMode.write);
        await down(playUrlData.data, true, dir_video.path);
      } else {
        var index_json = FlvIndexJson(
            from: item.from,
            quality: qn,
            type_tag: entry_json.type_tag,
            description: qn.toString(),
            is_stub: false,
            psedo_bitrate: 0,
            parse_timestamp_milli: DateTime.now().millisecondsSinceEpoch,
            available_period_milli: 0,
            local_proxy_type: 0,
            user_agent: "Bilibili Freedoooooom/MarkII",
            is_downloaded: true,
            is_resolved: true,
            time_length: item.duration,
            marlin_token: "",
            video_codec_id: playUrlData.data.video_codec_id,
            video_project: true,
            player_codec_config_list: [
              Player_codec_config_list(
                  use_ijk_media_codec: false, player: "IJK_PLAYER"),
              Player_codec_config_list(
                  use_ijk_media_codec: false, player: "ANDROID_PLAYER"),
            ],
            segment_list: []);
        for (var item in playUrlData.data.urls) {
          index_json.segment_list.add(Flv_Segment_list(
              url: item.url,
              duration: item.length,
              bytes: item.size,
              meta_url: "",
              ahead: "",
              vhead: "",
              md5: "",
              backup_urls: []));
        }
        await File(dir_video.path + "/index.json")
            .writeAsString(index_json.toString(), mode: FileMode.write);
        await down(playUrlData.data, false, dir_video.path);
      }

    } catch (e) {
      Fluttertoast.showToast(msg: "创建下载时出错");
    } finally {
      if( pr.isShowing())pr.hide();
    }
  }

  void clickPart(VideoInfoData videoInfo, Pages item) async {
    try {
      //检查是否存在文件
      var exist = checkExist(false, videoInfo.aid, item.page);
      if (exist &&
          !await Utils.showAlertDialogAsync(
              context, Text("文件已存在"), Text("文件已经存在，是否覆盖重新下载?"))) {
        return;
      }
      pr.update(message: "读取视频地址...");
      pr.show();
      var userInfo = Provider.of<AppUserInfo>(context).userInfo;
      //获取首选清晰度
      var qn = Provider.of<AppSettings>(context).quality;

      //读取下载地址
      var playUrlData = await PlayUrlHelper.getVideoPlayUrl(videoInfo, item, qn,
          userInfo: userInfo);
      if (!playUrlData.success) {
        Fluttertoast.showToast(msg: playUrlData.message);
        return;
      }
      pr.update(message: "创建文件夹...");
      //创建剧集文件夹写入entry.json和danmaku.xml
      var path_episode = Provider.of<AppSettings>(context).downPath +
          "/Android/Data/" +
          Provider.of<AppSettings>(context).appType +
          "/download/${videoInfo.aid}/${item.page}";
      //创建文件夹
      var dir_episode = await Directory(path_episode).create(recursive: true);
      //创建entry.json
      var entry_json = VideoEntryJson.create(
          playUrlData.data.format == "dash", qn, videoInfo, item);
      //创建entry.json
      await File(dir_episode.path + "/entry.json")
          .writeAsString(entry_json.toString(), mode: FileMode.write);
      //创建danmaku.xml
      pr.update(message: "下载弹幕...");
      await File(dir_episode.path + "/danmaku.xml")
          .writeAsString(await getDanmu(item.cid), mode: FileMode.write);
      //创建清晰度命名的文件夹写入index.json
      var dir_video = await Directory(path_episode + "/" + entry_json.type_tag)
          .create(recursive: true);
      pr.update(message: "准备下载...");
      //写入index.json
      if (playUrlData.data.format == "dash") {
        var index_json = DashIndexJson(video: [
          Video(
              id: qn,
              base_url: playUrlData.data.urls[0].url,
              bandwidth: playUrlData.data.urls[0].bandwidth,
              codecid: playUrlData.data.urls[0].codecid,
              size: playUrlData.data.urls[0].size,
              md5: "")
        ], audio: [
          Audio(
              id: qn,
              base_url: playUrlData.data.urls[1].url,
              bandwidth: playUrlData.data.urls[1].bandwidth,
              codecid: playUrlData.data.urls[1].codecid,
              size: playUrlData.data.urls[1].size,
              md5: "")
        ]).toString();
        await File(dir_video.path + "/index.json")
            .writeAsString(index_json.toString(), mode: FileMode.write);
        await down(playUrlData.data, true, dir_video.path);
      } else {
        var index_json = FlvIndexJson(
            from: item.from,
            quality: qn,
            type_tag: entry_json.type_tag,
            description: qn.toString(),
            is_stub: false,
            psedo_bitrate: 0,
            parse_timestamp_milli: DateTime.now().millisecondsSinceEpoch,
            available_period_milli: 0,
            local_proxy_type: 0,
            user_agent: "Bilibili Freedoooooom/MarkII",
            is_downloaded: true,
            is_resolved: true,
            time_length: item.duration,
            marlin_token: "",
            video_codec_id: playUrlData.data.video_codec_id,
            video_project: true,
            player_codec_config_list: [
              Player_codec_config_list(
                  use_ijk_media_codec: false, player: "IJK_PLAYER"),
              Player_codec_config_list(
                  use_ijk_media_codec: false, player: "ANDROID_PLAYER"),
            ],
            segment_list: []);
        for (var item in playUrlData.data.urls) {
          index_json.segment_list.add(Flv_Segment_list(
              url: item.url,
              duration: item.length,
              bytes: item.size,
              meta_url: "",
              ahead: "",
              vhead: "",
              md5: "",
              backup_urls: []));
        }
        await File(dir_video.path + "/index.json")
            .writeAsString(index_json.toString(), mode: FileMode.write);
        await down(playUrlData.data, false, dir_video.path);
      }

     
    } catch (e) {
      Fluttertoast.showToast(msg: "创建下载时出错");
    } finally {
     if( pr.isShowing())pr.hide();
    }
  }

  Future down(PlayUrlInfo playUrlData, bool isDash, String path) async {
    var use = Provider.of<AppSettings>(context).useOtherDownloader;
    if (!use) {
      if (isDash) {
        for (var item in playUrlData.urls) {
          await startDownload(
              path, item.isAudio ? "audio.m4s" : "video.m4s", item.url);
        }
      } else {
        int i = 0;
        for (var item in playUrlData.urls) {
          await startDownload(path, "$i.blv", item.url);
          i++;
        }
        
      }
       Fluttertoast.showToast(msg: "开始下载");
    } else {
      List<DownInfoItem> items=[];
       if (isDash) {
        for (var item in playUrlData.urls) {
         items.add(DownInfoItem(item.url, item.isAudio ? "audio.m4s" : "video.m4s"));
        }
      } else {
        int i = 0;
        for (var item in playUrlData.urls) {
           items.add(DownInfoItem(item.url,"$i.blv"));
          i++;
        }
      }
      DownInfo downInfo=DownInfo(path,"Bilibili Freedoooooom/MarkII",items);
      pr.hide();
      await Navigator.push(context,MaterialPageRoute(
        builder: (_)=>DownloadInfoPage(downInfo)
      ));
    }
  }

  Future startDownload(String path, String filename, String url) async {
    var taskid = await FlutterDownloader.enqueue(
      url: url,
      savedDir: path,
      fileName: filename,
      headers: {"User-Agent": "Bilibili Freedoooooom/MarkII"},
      showNotification: true,
      openFileFromNotification: false,
    );
    Utils.eventBus_startDown.fire(taskid);
  }

  bool checkExist(bool isSeason, int _id, int _cid) {
    String id = isSeason ? "s_$_id" : _id.toString();
    var path = Provider.of<AppSettings>(context).downPath +
        "/Android/Data/" +
        Provider.of<AppSettings>(context).appType +
        "/download/$id/$_cid";
    var dir = Directory(path);
    return dir.existsSync();
  }

  Future<String> getDanmu(int cid) async {
    try {
      var result = await http.get(Api.danmu(cid));
      var danmuStr = utf8.decode(result.bodyBytes);
      return danmuStr;
    } catch (e) {
      return "";
    }
  }
}
