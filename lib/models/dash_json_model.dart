import 'dart:convert' show json;

class DashJsonModel {
  int _duration;
  int get duration => _duration;
  set duration(value)  {
    _duration = value;
  }

  int _min_buffer_time;
  int get min_buffer_time => _min_buffer_time;
  set min_buffer_time(value)  {
    _min_buffer_time = value;
  }

  List<DashVideoModel> _video;
  List<DashVideoModel> get video => _video;
  set video(value)  {
    _video = value;
  }

  List<DashAudioModel> _audio;
  List<DashAudioModel> get audio => _audio;
  set audio(value)  {
    _audio = value;
  }


    DashJsonModel({
int duration,
int min_buffer_time,
List<DashVideoModel> video,
List<DashAudioModel> audio,
}):_duration=duration,_min_buffer_time=min_buffer_time,_video=video,_audio=audio;
  factory DashJsonModel.fromJson(jsonRes){ if(jsonRes == null) return null;
    List<DashVideoModel> video = jsonRes['video'] is List ? []: null; 
    if(video!=null) {
 for (var item in jsonRes['video']) { if (item != null) { video.add(DashVideoModel.fromJson(item));  }
    }
    }


    List<DashAudioModel> audio = jsonRes['audio'] is List ? []: null; 
    if(audio!=null) {
 for (var item in jsonRes['audio']) { if (item != null) { audio.add(DashAudioModel.fromJson(item));  }
    }
    }

//em..0会序列化成double...很无奈
return DashJsonModel(    duration : (jsonRes['duration'] is double)?(jsonRes['duration'] as double).toInt():jsonRes['duration'],
    min_buffer_time : (jsonRes['min_buffer_time'] is double)?(jsonRes['min_buffer_time'] as double).toInt():jsonRes['min_buffer_time'],
 video:video,
 audio:audio,
);}
  Map<String, dynamic> toJson() => {
        'duration': _duration,
        'min_buffer_time': _min_buffer_time,
        'video': _video,
        'audio': _audio,
};

  @override
String  toString() {
    return json.encode(this);
  }
}
class DashVideoModel {
  int _start_with_sap;
  int get start_with_sap => _start_with_sap;
  set start_with_sap(value)  {
    _start_with_sap = value;
  }

  int _bandwidth;
  int get bandwidth => _bandwidth;
  set bandwidth(value)  {
    _bandwidth = value;
  }

  String _sar;
  String get sar => _sar;
  set sar(value)  {
    _sar = value;
  }

  String _codecs;
  String get codecs => _codecs;
  set codecs(value)  {
    _codecs = value;
  }

  String _base_url;
  String get base_url => _base_url;
  set base_url(value)  {
    _base_url = value;
  }

  List<String> _backup_url;
  List<String> get backup_url => _backup_url;
  set backup_url(value)  {
    _backup_url = value;
  }

  String _frame_rate;
  String get frame_rate => _frame_rate;
  set frame_rate(value)  {
    _frame_rate = value;
  }

  int _codecid;
  int get codecid => _codecid;
  set codecid(value)  {
    _codecid = value;
  }

  int _size;
  int get size => _size;
  set size(value)  {
    _size = value;
  }

  String _mime_type;
  String get mime_type => _mime_type;
  set mime_type(value)  {
    _mime_type = value;
  }

  int _width;
  int get width => _width;
  set width(value)  {
    _width = value;
  }

  int _id;
  int get id => _id;
  set id(value)  {
    _id = value;
  }

  int _height;
  int get height => _height;
  set height(value)  {
    _height = value;
  }

  String _md5;
  String get md5 => _md5;
  set md5(value)  {
    _md5 = value;
  }


    DashVideoModel({
int start_with_sap,
int bandwidth,
String sar,
String codecs,
String base_url,
List<String> backup_url,
String frame_rate,
int codecid,
int size,
String mime_type,
int width,
int id,
int height,
String md5,
}):_start_with_sap=start_with_sap,_bandwidth=bandwidth,_sar=sar,_codecs=codecs,_base_url=base_url,_backup_url=backup_url,_frame_rate=frame_rate,_codecid=codecid,_size=size,_mime_type=mime_type,_width=width,_id=id,_height=height,_md5=md5;
  factory DashVideoModel.fromJson(jsonRes){ if(jsonRes == null) return null;
    List<String> backup_url = jsonRes['backup_url'] is List ? []: null; 
    if(backup_url!=null) {
 for (var item in jsonRes['backup_url']) { if (item != null) { backup_url.add(item);  }
    }
    }


return DashVideoModel(    start_with_sap : jsonRes['start_with_sap'],
    bandwidth : jsonRes['bandwidth'],
    sar : jsonRes['sar'],
    codecs : jsonRes['codecs'],
    base_url : jsonRes['base_url'],
 backup_url:backup_url,
    frame_rate : jsonRes['frame_rate'],
    codecid : jsonRes['codecid'],
    size : jsonRes['size'],
    mime_type : jsonRes['mime_type'],
    width : jsonRes['width'],
    id : jsonRes['id'],
    height : jsonRes['height'],
    md5 : jsonRes['md5'],
);}
  Map<String, dynamic> toJson() => {
        'start_with_sap': _start_with_sap,
        'bandwidth': _bandwidth,
        'sar': _sar,
        'codecs': _codecs,
        'base_url': _base_url,
        'backup_url': _backup_url,
        'frame_rate': _frame_rate,
        'codecid': _codecid,
        'size': _size,
        'mime_type': _mime_type,
        'width': _width,
        'id': _id,
        'height': _height,
        'md5': _md5,
};

  @override
String  toString() {
    return json.encode(this);
  }
}

class DashAudioModel {
  int _start_with_sap;
  int get start_with_sap => _start_with_sap;
  set start_with_sap(value)  {
    _start_with_sap = value;
  }

  int _bandwidth;
  int get bandwidth => _bandwidth;
  set bandwidth(value)  {
    _bandwidth = value;
  }

  String _sar;
  String get sar => _sar;
  set sar(value)  {
    _sar = value;
  }

  String _codecs;
  String get codecs => _codecs;
  set codecs(value)  {
    _codecs = value;
  }

  String _base_url;
  String get base_url => _base_url;
  set base_url(value)  {
    _base_url = value;
  }

  List<String> _backup_url;
  List<String> get backup_url => _backup_url;
  set backup_url(value)  {
    _backup_url = value;
  }

  String _frame_rate;
  String get frame_rate => _frame_rate;
  set frame_rate(value)  {
    _frame_rate = value;
  }

  int _codecid;
  int get codecid => _codecid;
  set codecid(value)  {
    _codecid = value;
  }

  int _size;
  int get size => _size;
  set size(value)  {
    _size = value;
  }

  String _mime_type;
  String get mime_type => _mime_type;
  set mime_type(value)  {
    _mime_type = value;
  }

  int _width;
  int get width => _width;
  set width(value)  {
    _width = value;
  }

  int _id;
  int get id => _id;
  set id(value)  {
    _id = value;
  }

  int _height;
  int get height => _height;
  set height(value)  {
    _height = value;
  }

  String _md5;
  String get md5 => _md5;
  set md5(value)  {
    _md5 = value;
  }


    DashAudioModel({
int start_with_sap,
int bandwidth,
String sar,
String codecs,
String base_url,
List<String> backup_url,
String frame_rate,
int codecid,
int size,
String mime_type,
int width,
int id,
int height,
String md5,
}):_start_with_sap=start_with_sap,_bandwidth=bandwidth,_sar=sar,_codecs=codecs,_base_url=base_url,_backup_url=backup_url,_frame_rate=frame_rate,_codecid=codecid,_size=size,_mime_type=mime_type,_width=width,_id=id,_height=height,_md5=md5;
  factory DashAudioModel.fromJson(jsonRes){ if(jsonRes == null) return null;
    List<String> backup_url = jsonRes['backup_url'] is List ? []: null; 
    if(backup_url!=null) {
 for (var item in jsonRes['backup_url']) { if (item != null) { backup_url.add(item);  }
    }
    }


return DashAudioModel(    start_with_sap : jsonRes['start_with_sap'],
    bandwidth : jsonRes['bandwidth'],
    sar : jsonRes['sar'],
    codecs : jsonRes['codecs'],
    base_url : jsonRes['base_url'],
 backup_url:backup_url,
    frame_rate : jsonRes['frame_rate'],
    codecid : jsonRes['codecid'],
    size : jsonRes['size'],
    mime_type : jsonRes['mime_type'],
    width : jsonRes['width'],
    id : jsonRes['id'],
    height : jsonRes['height'],
    md5 : jsonRes['md5'],
);}
  Map<String, dynamic> toJson() => {
        'start_with_sap': _start_with_sap,
        'bandwidth': _bandwidth,
        'sar': _sar,
        'codecs': _codecs,
        'base_url': _base_url,
        'backup_url': _backup_url,
        'frame_rate': _frame_rate,
        'codecid': _codecid,
        'size': _size,
        'mime_type': _mime_type,
        'width': _width,
        'id': _id,
        'height': _height,
        'md5': _md5,
};

  @override
String  toString() {
    return json.encode(this);
  }
}


