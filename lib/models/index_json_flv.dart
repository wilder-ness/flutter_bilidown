//FLV视频类型的index.json

import 'dart:convert' show json;

class FlvIndexJson {
  String _from;
  String get from => _from;
  set from(value) {
    _from = value;
  }

  int _quality;
  int get quality => _quality;
  set quality(value) {
    _quality = value;
  }

  String _type_tag;
  String get type_tag => _type_tag;
  set type_tag(value) {
    _type_tag = value;
  }

  String _description;
  String get description => _description;
  set description(value) {
    _description = value;
  }

  bool _is_stub = false;
  bool get is_stub => _is_stub;
  set is_stub(value) {
    _is_stub = value;
  }

  int _psedo_bitrate = 0;
  int get psedo_bitrate => _psedo_bitrate;
  set psedo_bitrate(value) {
    _psedo_bitrate = value;
  }

  List<Flv_Segment_list> _segment_list;
  List<Flv_Segment_list> get segment_list => _segment_list;
  set segment_list(value) {
    _segment_list = value;
  }

  int _parse_timestamp_milli;
  int get parse_timestamp_milli => _parse_timestamp_milli;
  set parse_timestamp_milli(value) {
    _parse_timestamp_milli = value;
  }

  int _available_period_milli = 0;
  int get available_period_milli => _available_period_milli;
  set available_period_milli(value) {
    _available_period_milli = value;
  }

  int _local_proxy_type = 0;
  int get local_proxy_type => _local_proxy_type;
  set local_proxy_type(value) {
    _local_proxy_type = value;
  }

  String _user_agent = "Bilibili Freedoooooom/MarkII";
  String get user_agent => _user_agent;
  set user_agent(value) {
    _user_agent = value;
  }

  bool _is_downloaded = true;
  bool get is_downloaded => _is_downloaded;
  set is_downloaded(value) {
    _is_downloaded = value;
  }

  bool _is_resolved = true;
  bool get is_resolved => _is_resolved;
  set is_resolved(value) {
    _is_resolved = value;
  }

  List<Player_codec_config_list> _player_codec_config_list;
  List<Player_codec_config_list> get player_codec_config_list =>
      _player_codec_config_list;
  set player_codec_config_list(value) {
    _player_codec_config_list = value;
  }

  int _time_length;
  int get time_length => _time_length;
  set time_length(value) {
    _time_length = value;
  }

  String _marlin_token;
  String get marlin_token => _marlin_token;
  set marlin_token(value) {
    _marlin_token = value;
  }

  int _video_codec_id = 7;
  int get video_codec_id => _video_codec_id;
  set video_codec_id(value) {
    _video_codec_id = value;
  }

  bool _video_project = true;
  bool get video_project => _video_project;
  set video_project(value) {
    _video_project = value;
  }

  FlvIndexJson({
    String from,
    int quality,
    String type_tag,
    String description,
    bool is_stub,
    int psedo_bitrate,
    List<Flv_Segment_list> segment_list,
    int parse_timestamp_milli,
    int available_period_milli,
    int local_proxy_type,
    String user_agent,
    bool is_downloaded,
    bool is_resolved,
    List<Player_codec_config_list> player_codec_config_list,
    int time_length,
    String marlin_token,
    int video_codec_id,
    bool video_project,
  })  : _from = from,
        _quality = quality,
        _type_tag = type_tag,
        _description = description,
        _is_stub = is_stub,
        _psedo_bitrate = psedo_bitrate,
        _segment_list = segment_list,
        _parse_timestamp_milli = parse_timestamp_milli,
        _available_period_milli = available_period_milli,
        _local_proxy_type = local_proxy_type,
        _user_agent = user_agent,
        _is_downloaded = is_downloaded,
        _is_resolved = is_resolved,
        _player_codec_config_list = player_codec_config_list,
        _time_length = time_length,
        _marlin_token = marlin_token,
        _video_codec_id = video_codec_id,
        _video_project = video_project;
  factory FlvIndexJson.fromJson(jsonRes) {
    if (jsonRes == null) return null;
    List<Flv_Segment_list> segment_list =
        jsonRes['segment_list'] is List ? [] : null;
    if (segment_list != null) {
      for (var item in jsonRes['segment_list']) {
        if (item != null) {
          segment_list.add(Flv_Segment_list.fromJson(item));
        }
      }
    }

    List<Player_codec_config_list> player_codec_config_list =
        jsonRes['player_codec_config_list'] is List ? [] : null;
    if (player_codec_config_list != null) {
      for (var item in jsonRes['player_codec_config_list']) {
        if (item != null) {
          player_codec_config_list.add(Player_codec_config_list.fromJson(item));
        }
      }
    }

    return FlvIndexJson(
      from: jsonRes['from'],
      quality: jsonRes['quality'],
      type_tag: jsonRes['type_tag'],
      description: jsonRes['description'],
      is_stub: jsonRes['is_stub'],
      psedo_bitrate: jsonRes['psedo_bitrate'],
      segment_list: segment_list,
      parse_timestamp_milli: jsonRes['parse_timestamp_milli'],
      available_period_milli: jsonRes['available_period_milli'],
      local_proxy_type: jsonRes['local_proxy_type'],
      user_agent: jsonRes['user_agent'],
      is_downloaded: jsonRes['is_downloaded'],
      is_resolved: jsonRes['is_resolved'],
      player_codec_config_list: player_codec_config_list,
      time_length: jsonRes['time_length'],
      marlin_token: jsonRes['marlin_token'],
      video_codec_id: jsonRes['video_codec_id'],
      video_project: jsonRes['video_project'],
    );
  }
  Map<String, dynamic> toJson() => {
        'from': _from,
        'quality': _quality,
        'type_tag': _type_tag,
        'description': _description,
        'is_stub': _is_stub,
        'psedo_bitrate': _psedo_bitrate,
        'segment_list': _segment_list,
        'parse_timestamp_milli': _parse_timestamp_milli,
        'available_period_milli': _available_period_milli,
        'local_proxy_type': _local_proxy_type,
        'user_agent': _user_agent,
        'is_downloaded': _is_downloaded,
        'is_resolved': _is_resolved,
        'player_codec_config_list': _player_codec_config_list,
        'time_length': _time_length,
        'marlin_token': _marlin_token,
        'video_codec_id': _video_codec_id,
        'video_project': _video_project,
      };

  @override
  String toString() {
    return json.encode(this);
  }
}

class Flv_Segment_list {
  String _url;
  String get url => _url;
  set url(value) {
    _url = value;
  }

  int _duration;
  int get duration => _duration;
  set duration(value) {
    _duration = value;
  }

  int _bytes;
  int get bytes => _bytes;
  set bytes(value) {
    _bytes = value;
  }

  String _meta_url;
  String get meta_url => _meta_url;
  set meta_url(value) {
    _meta_url = value;
  }

  String _ahead;
  String get ahead => _ahead;
  set ahead(value) {
    _ahead = value;
  }

  String _vhead;
  String get vhead => _vhead;
  set vhead(value) {
    _vhead = value;
  }

  String _md5;
  String get md5 => _md5;
  set md5(value) {
    _md5 = value;
  }

  List<String> _backup_urls;
  List<String> get backup_urls => _backup_urls;
  set backup_urls(value) {
    _backup_urls = value;
  }

  Flv_Segment_list({
    String url,
    int duration,
    int bytes,
    String meta_url,
    String ahead,
    String vhead,
    String md5,
    List<String> backup_urls,
  })  : _url = url,
        _duration = duration,
        _bytes = bytes,
        _meta_url = meta_url,
        _ahead = ahead,
        _vhead = vhead,
        _md5 = md5,
        _backup_urls = backup_urls;
  factory Flv_Segment_list.fromJson(jsonRes) {
    if (jsonRes == null) return null;
    List<String> backup_urls = jsonRes['backup_urls'] is List ? [] : null;
    if (backup_urls != null) {
      for (var item in jsonRes['backup_urls']) {
        if (item != null) {
          backup_urls.add(item);
        }
      }
    }

    return Flv_Segment_list(
      url: jsonRes['url'],
      duration: jsonRes['duration'],
      bytes: jsonRes['bytes'],
      meta_url: jsonRes['meta_url'],
      ahead: jsonRes['ahead'],
      vhead: jsonRes['vhead'],
      md5: jsonRes['md5'],
      backup_urls: backup_urls,
    );
  }
  Map<String, dynamic> toJson() => {
        'url': _url,
        'duration': _duration,
        'bytes': _bytes,
        'meta_url': _meta_url,
        'ahead': _ahead,
        'vhead': _vhead,
        'md5': _md5,
        'backup_urls': _backup_urls,
      };

  @override
  String toString() {
    return json.encode(this);
  }
}

class Player_codec_config_list {
  bool _use_ijk_media_codec;
  bool get use_ijk_media_codec => _use_ijk_media_codec;
  set use_ijk_media_codec(value) {
    _use_ijk_media_codec = value;
  }

  String _player;
  String get player => _player;
  set player(value) {
    _player = value;
  }

  Player_codec_config_list({
    bool use_ijk_media_codec,
    String player,
  })  : _use_ijk_media_codec = use_ijk_media_codec,
        _player = player;
  factory Player_codec_config_list.fromJson(jsonRes) => jsonRes == null
      ? null
      : Player_codec_config_list(
          use_ijk_media_codec: jsonRes['use_ijk_media_codec'],
          player: jsonRes['player'],
        );
  Map<String, dynamic> toJson() => {
        'use_ijk_media_codec': _use_ijk_media_codec,
        'player': _player,
      };

  @override
  String toString() {
    return json.encode(this);
  }
}
