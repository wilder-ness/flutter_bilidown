import 'dart:convert' show json;

import 'package:flutter_bilidown/models/video_model.dart';

class VideoEntryJson {
  int _media_type;
  int get media_type => _media_type;
  set media_type(value)  {
    _media_type = value;
  }

  bool _has_dash_audio=true;
  bool get has_dash_audio => _has_dash_audio;
  set has_dash_audio(value)  {
    _has_dash_audio = value;
  }

  bool _is_completed=true;
  bool get is_completed => _is_completed;
  set is_completed(value)  {
    _is_completed = value;
  }

  int _total_bytes=0;
  int get total_bytes => _total_bytes;
  set total_bytes(value)  {
    _total_bytes = value;
  }

  int _downloaded_bytes=0;
  int get downloaded_bytes => _downloaded_bytes;
  set downloaded_bytes(value)  {
    _downloaded_bytes = value;
  }

  String _title;
  String get title => _title;
  set title(value)  {
    _title = value;
  }

  String _type_tag;
  String get type_tag => _type_tag;
  set type_tag(value)  {
    _type_tag = value;
  }

  String _cover;
  String get cover => _cover;
  set cover(value)  {
    _cover = value;
  }

  int _prefered_video_quality;
  int get prefered_video_quality => _prefered_video_quality;
  set prefered_video_quality(value)  {
    _prefered_video_quality = value;
  }

  int _guessed_total_bytes;
  int get guessed_total_bytes => _guessed_total_bytes;
  set guessed_total_bytes(value)  {
    _guessed_total_bytes = value;
  }

  int _total_time_milli;
  int get total_time_milli => _total_time_milli;
  set total_time_milli(value)  {
    _total_time_milli = value;
  }

  int _danmaku_count;
  int get danmaku_count => _danmaku_count;
  set danmaku_count(value)  {
    _danmaku_count = value;
  }

  int _time_update_stamp;
  int get time_update_stamp => _time_update_stamp;
  set time_update_stamp(value)  {
    _time_update_stamp = value;
  }

  int _time_create_stamp;
  int get time_create_stamp => _time_create_stamp;
  set time_create_stamp(value)  {
    _time_create_stamp = value;
  }

  int _avid;
  int get avid => _avid;
  set avid(value)  {
    _avid = value;
  }

  int _spid=0;
  int get spid => _spid;
  set spid(value)  {
    _spid = value;
  }

  int _seasion_id=0;
  int get seasion_id => _seasion_id;
  set seasion_id(value)  {
    _seasion_id = value;
  }

  Page_data _page_data;
  Page_data get page_data => _page_data;
  set page_data(value)  {
    _page_data = value;
  }


   VideoEntryJson();
  factory VideoEntryJson.create(
      bool isDash, int qn, VideoInfoData videoInfo, Pages episode) {
    var data = VideoEntryJson();
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
    data.title = videoInfo.title;
    data.cover = videoInfo.pic;
    data.total_time_milli = episode.duration*1000;
    data.danmaku_count = 0;
    data.guessed_total_bytes=0;
    data.time_update_stamp = DateTime.now().millisecondsSinceEpoch;
    data.time_create_stamp= DateTime.now().millisecondsSinceEpoch;
    data.avid=videoInfo.aid;
    data.page_data=Page_data(cid: episode.cid,page: episode.page,from: episode.from,part: episode.part,vid: episode.vid,has_alias: false,width: 0,height: 0,rotate: 0,tid: videoInfo.tid);
   
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
        'avid': _avid,
        'spid': _spid,
        'seasion_id': _seasion_id,
        'page_data': _page_data,
};

  @override
String  toString() {
    return json.encode(this);
  }
}
class Page_data {
  int _cid;
  int get cid => _cid;
  set cid(value)  {
    _cid = value;
  }

  int _page;
  int get page => _page;
  set page(value)  {
    _page = value;
  }

  String _from;
  String get from => _from;
  set from(value)  {
    _from = value;
  }

  String _part;
  String get part => _part;
  set part(value)  {
    _part = value;
  }

  String _vid;
  String get vid => _vid;
  set vid(value)  {
    _vid = value;
  }

  bool _has_alias;
  bool get has_alias => _has_alias;
  set has_alias(value)  {
    _has_alias = value;
  }

  int _tid;
  int get tid => _tid;
  set tid(value)  {
    _tid = value;
  }

  int _width;
  int get width => _width;
  set width(value)  {
    _width = value;
  }

  int _height;
  int get height => _height;
  set height(value)  {
    _height = value;
  }

  int _rotate;
  int get rotate => _rotate;
  set rotate(value)  {
    _rotate = value;
  }


    Page_data({
int cid,
int page,
String from,
String part,
String vid,
bool has_alias,
int tid,
int width,
int height,
int rotate,
}):_cid=cid,_page=page,_from=from,_part=part,_vid=vid,_has_alias=has_alias,_tid=tid,_width=width,_height=height,_rotate=rotate;
  factory Page_data.fromJson(jsonRes)=>jsonRes == null? null:Page_data(    cid : jsonRes['cid'],
    page : jsonRes['page'],
    from : jsonRes['from'],
    part : jsonRes['part'],
    vid : jsonRes['vid'],
    has_alias : jsonRes['has_alias'],
    tid : jsonRes['tid'],
    width : jsonRes['width'],
    height : jsonRes['height'],
    rotate : jsonRes['rotate'],
);
  Map<String, dynamic> toJson() => {
        'cid': _cid,
        'page': _page,
        'from': _from,
        'part': _part,
        'vid': _vid,
        'has_alias': _has_alias,
        'tid': _tid,
        'width': _width,
        'height': _height,
        'rotate': _rotate,
};

  @override
String  toString() {
    return json.encode(this);
  }
}


