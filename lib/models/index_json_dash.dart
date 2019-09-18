import 'dart:convert' show json;

class DashIndexJson {
  List<Video> _video;
  List<Video> get video => _video;
  set video(value)  {
    _video = value;
  }

  List<Audio> _audio;
  List<Audio> get audio => _audio;
  set audio(value)  {
    _audio = value;
  }


    DashIndexJson({
List<Video> video,
List<Audio> audio,
}):_video=video,_audio=audio;
  factory DashIndexJson.fromJson(jsonRes){ if(jsonRes == null) return null;
    List<Video> video = jsonRes['video'] is List ? []: null; 
    if(video!=null) {
 for (var item in jsonRes['video']) { if (item != null) { video.add(Video.fromJson(item));  }
    }
    }


    List<Audio> audio = jsonRes['audio'] is List ? []: null; 
    if(audio!=null) {
 for (var item in jsonRes['audio']) { if (item != null) { audio.add(Audio.fromJson(item));  }
    }
    }


return DashIndexJson( video:video,
 audio:audio,
);}
  Map<String, dynamic> toJson() => {
        'video': _video,
        'audio': _audio,
};

  @override
String  toString() {
    return json.encode(this);
  }
}
class Video {
  int _id;
  int get id => _id;
  set id(value)  {
    _id = value;
  }

  String _base_url;
  String get base_url => _base_url;
  set base_url(value)  {
    _base_url = value;
  }

  int _bandwidth;
  int get bandwidth => _bandwidth;
  set bandwidth(value)  {
    _bandwidth = value;
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

  String _md5;
  String get md5 => _md5;
  set md5(value)  {
    _md5 = value;
  }


    Video({
int id,
String base_url,
int bandwidth,
int codecid,
int size,
String md5,
}):_id=id,_base_url=base_url,_bandwidth=bandwidth,_codecid=codecid,_size=size,_md5=md5;
  factory Video.fromJson(jsonRes)=>jsonRes == null? null:Video(    id : jsonRes['id'],
    base_url : jsonRes['base_url'],
    bandwidth : jsonRes['bandwidth'],
    codecid : jsonRes['codecid'],
    size : jsonRes['size'],
    md5 : jsonRes['md5'],
);
  Map<String, dynamic> toJson() => {
        'id': _id,
        'base_url': _base_url,
        'bandwidth': _bandwidth,
        'codecid': _codecid,
        'size': _size,
        'md5': _md5,
};

  @override
String  toString() {
    return json.encode(this);
  }
}

class Audio {
  int _id;
  int get id => _id;
  set id(value)  {
    _id = value;
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

  int _bandwidth;
  int get bandwidth => _bandwidth;
  set bandwidth(value)  {
    _bandwidth = value;
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

  String _md5;
  String get md5 => _md5;
  set md5(value)  {
    _md5 = value;
  }


    Audio({
int id,
String base_url,
List<String> backup_url,
int bandwidth,
int codecid,
int size,
String md5,
}):_id=id,_base_url=base_url,_backup_url=backup_url,_bandwidth=bandwidth,_codecid=codecid,_size=size,_md5=md5;
  factory Audio.fromJson(jsonRes){ if(jsonRes == null) return null;
    List<String> backup_url = jsonRes['backup_url'] is List ? []: null; 
    if(backup_url!=null) {
 for (var item in jsonRes['backup_url']) { if (item != null) { backup_url.add(item);  }
    }
    }


return Audio(    id : jsonRes['id'],
    base_url : jsonRes['base_url'],
 backup_url:backup_url,
    bandwidth : jsonRes['bandwidth'],
    codecid : jsonRes['codecid'],
    size : jsonRes['size'],
    md5 : jsonRes['md5'],
);}
  Map<String, dynamic> toJson() => {
        'id': _id,
        'base_url': _base_url,
        'backup_url': _backup_url,
        'bandwidth': _bandwidth,
        'codecid': _codecid,
        'size': _size,
        'md5': _md5,
};

  @override
String  toString() {
    return json.encode(this);
  }
}


