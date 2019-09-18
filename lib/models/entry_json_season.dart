import 'dart:convert' show json;

import 'package:flutter_bilidown/models/season_model.dart';

class SeasonEntryJson {
  int _media_type = 1;
  int get media_type => _media_type;
  set media_type(value) {
    _media_type = value;
  }

  bool _has_dash_audio = false;
  bool get has_dash_audio => _has_dash_audio;
  set has_dash_audio(value) {
    _has_dash_audio = value;
  }

  bool _is_completed = true;
  bool get is_completed => _is_completed;
  set is_completed(value) {
    _is_completed = value;
  }

  int _total_bytes = 0;
  int get total_bytes => _total_bytes;
  set total_bytes(value) {
    _total_bytes = value;
  }

  int _downloaded_bytes = 0;
  int get downloaded_bytes => _downloaded_bytes;
  set downloaded_bytes(value) {
    _downloaded_bytes = value;
  }

  String _title;
  String get title => _title;
  set title(value) {
    _title = value;
  }

  String _type_tag;
  String get type_tag => _type_tag;
  set type_tag(value) {
    _type_tag = value;
  }

  String _cover;
  String get cover => _cover;
  set cover(value) {
    _cover = value;
  }

  int _prefered_video_quality = 80;
  int get prefered_video_quality => _prefered_video_quality;
  set prefered_video_quality(value) {
    _prefered_video_quality = value;
  }

  int _guessed_total_bytes;
  int get guessed_total_bytes => _guessed_total_bytes;
  set guessed_total_bytes(value) {
    _guessed_total_bytes = value;
  }

  int _total_time_milli;
  int get total_time_milli => _total_time_milli;
  set total_time_milli(value) {
    _total_time_milli = value;
  }

  int _danmaku_count;
  int get danmaku_count => _danmaku_count;
  set danmaku_count(value) {
    _danmaku_count = value;
  }

  int _time_update_stamp;
  int get time_update_stamp => _time_update_stamp;
  set time_update_stamp(value) {
    _time_update_stamp = value;
  }

  int _time_create_stamp;
  int get time_create_stamp => _time_create_stamp;
  set time_create_stamp(value) {
    _time_create_stamp = value;
  }

  String _season_id;
  String get season_id => _season_id;
  set season_id(value) {
    _season_id = value;
  }

  Source _source;
  Source get source => _source;
  set source(value) {
    _source = value;
  }

  Ep _ep;
  Ep get ep => _ep;
  set ep(value) {
    _ep = value;
  }

  SeasonEntryJson();
  factory SeasonEntryJson.create(
      bool isDash, int qn, SeasonInfoResult seasonInfo, Episodes episode) {
    var data = SeasonEntryJson();
    if (isDash) {
      data.media_type = 2;
      data.has_dash_audio = true;
      data.type_tag = qn.toString();
    } else {
      switch (qn) {
        case 112:
          data.type_tag = "lua.hdflv2.bb2api.bd";
          break;
        case 80:
          data.type_tag = "lua.flv.bb2api.80";
          break;
        case 64:
          data.type_tag = "lua.flv720.bb2api.64";
          break;
        case 32:
          data.type_tag = "lua.flv480.bb2api.32";
          break;
        case 16:
          data.type_tag = "lua.mp4.bb2api.16";
          break;
        default:
          data.type_tag = "lua.flv.bb2api.80";
          break;
      }
    }
    data.prefered_video_quality = qn;
    data.title = seasonInfo.title;
    data.cover = seasonInfo.cover;
    data.total_time_milli =episode.duration;
    data.danmaku_count = 0;
    data.guessed_total_bytes=0;
    data.time_update_stamp = DateTime.now().millisecondsSinceEpoch;
    data.time_create_stamp= DateTime.now().millisecondsSinceEpoch;
    data.season_id=seasonInfo.season_id.toString();
    data.source=Source(av_id: episode.aid,cid: episode.cid,website: episode.from);
    data.ep=Ep(av_id: episode.aid,page: episode.page,danmaku: episode.cid,cover: episode.cover,episode_id: episode.ep_id,index: episode.index,index_title: episode.index_title,from: episode.from,season_type: seasonInfo.season_type,width: 0,height: 0,rotate: 0);
    return data;
  }

 

  Map<String, dynamic> toJson() => {
        'media_type': _media_type,
        'has_dash_audio': _has_dash_audio,
        'is_completed': _is_completed,
        'total_bytes': _total_bytes,
        'downloaded_bytes': _downloaded_bytes,
        'title': _title,
        'type_tag': _type_tag,
        'cover': _cover,
        'prefered_video_quality': _prefered_video_quality,
        'guessed_total_bytes': _guessed_total_bytes,
        'total_time_milli': _total_time_milli,
        'danmaku_count': _danmaku_count,
        'time_update_stamp': _time_update_stamp,
        'time_create_stamp': _time_create_stamp,
        'season_id': _season_id,
        'source': _source,
        'ep': _ep,
      };

  @override
  String toString() {
    return json.encode(this);
  }
}

class Source {
  int _av_id;
  int get av_id => _av_id;
  set av_id(value) {
    _av_id = value;
  }

  int _cid;
  int get cid => _cid;
  set cid(value) {
    _cid = value;
  }

  String _website;
  String get website => _website;
  set website(value) {
    _website = value;
  }

  Source({
    int av_id,
    int cid,
    String website,
  })  : _av_id = av_id,
        _cid = cid,
        _website = website;
  factory Source.fromJson(jsonRes) => jsonRes == null
      ? null
      : Source(
          av_id: jsonRes['av_id'],
          cid: jsonRes['cid'],
          website: jsonRes['website'],
        );
  Map<String, dynamic> toJson() => {
        'av_id': _av_id,
        'cid': _cid,
        'website': _website,
      };

  @override
  String toString() {
    return json.encode(this);
  }
}

class Ep {
  int _av_id;
  int get av_id => _av_id;
  set av_id(value) {
    _av_id = value;
  }

  int _page;
  int get page => _page;
  set page(value) {
    _page = value;
  }

  int _danmaku;
  int get danmaku => _danmaku;
  set danmaku(value) {
    _danmaku = value;
  }

  String _cover;
  String get cover => _cover;
  set cover(value) {
    _cover = value;
  }

  int _episode_id;
  int get episode_id => _episode_id;
  set episode_id(value) {
    _episode_id = value;
  }

  String _index;
  String get index => _index;
  set index(value) {
    _index = value;
  }

  String _index_title;
  String get index_title => _index_title;
  set index_title(value) {
    _index_title = value;
  }

  String _from;
  String get from => _from;
  set from(value) {
    _from = value;
  }

  int _season_type;
  int get season_type => _season_type;
  set season_type(value) {
    _season_type = value;
  }

  int _width = 0;
  int get width => _width;
  set width(value) {
    _width = value;
  }

  int _height = 0;
  int get height => _height;
  set height(value) {
    _height = value;
  }

  int _rotate = 0;
  int get rotate => _rotate;
  set rotate(value) {
    _rotate = value;
  }

  Ep({
    int av_id,
    int page,
    int danmaku,
    String cover,
    int episode_id,
    String index,
    String index_title,
    String from,
    int season_type,
    int width,
    int height,
    int rotate,
  })  : _av_id = av_id,
        _page = page,
        _danmaku = danmaku,
        _cover = cover,
        _episode_id = episode_id,
        _index = index,
        _index_title = index_title,
        _from = from,
        _season_type = season_type,
        _width = width,
        _height = height,
        _rotate = rotate;
  factory Ep.fromJson(jsonRes) => jsonRes == null
      ? null
      : Ep(
          av_id: jsonRes['av_id'],
          page: jsonRes['page'],
          danmaku: jsonRes['danmaku'],
          cover: jsonRes['cover'],
          episode_id: jsonRes['episode_id'],
          index: jsonRes['index'],
          index_title: jsonRes['index_title'],
          from: jsonRes['from'],
          season_type: jsonRes['season_type'],
          width: jsonRes['width'],
          height: jsonRes['height'],
          rotate: jsonRes['rotate'],
        );
  Map<String, dynamic> toJson() => {
        'av_id': _av_id,
        'page': _page,
        'danmaku': _danmaku,
        'cover': _cover,
        'episode_id': _episode_id,
        'index': _index,
        'index_title': _index_title,
        'from': _from,
        'season_type': _season_type,
        'width': _width,
        'height': _height,
        'rotate': _rotate,
      };

  @override
  String toString() {
    return json.encode(this);
  }
}
