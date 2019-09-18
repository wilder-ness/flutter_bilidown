import 'dart:convert' show json;

class PlayUrlInfo{
  PlayUrlInfo();


  int _time_length = 1;
  int get time_length => _time_length;
  set time_length(value) {
    _time_length = value;
  }
  int _video_codec_id=7;
  int get video_codec_id => _video_codec_id;
  set video_codec_id(value) {
    _video_codec_id = value;
  }

  String _format;//FLV or DASH
  String get format => _format;
  set format(value) {
    _format = value;
  }

  List<PlayUrlItem> _urls;
  List<PlayUrlItem> get urls => _urls;
  set urls(List<PlayUrlItem> value) {
    _urls = value;
  }
  
}
class PlayUrlItem{
    PlayUrlItem();
    int _size;
    int get size => _size;
    set size(value)  {
      _size = value;
    }
     int _length;
    int get length => _length;
    set length(value)  {
      _length = value;
    }

    String _url;
    String get url => _url;
    set url(value)  {
      _url = value;
    }

     int _order;
    int get order => _order;
    set order(value)  {
      _order = value;
    }
      int _codecid=7;
  int get codecid => _codecid;
  set codecid(value)  {
    _codecid = value;
  }

    int _bandwidth;
  int get bandwidth => _bandwidth;
  set bandwidth(value)  {
    _bandwidth = value;
  }

  bool _isAudio=false;
    bool get isAudio => _isAudio;
    set isAudio(value)  {
      _isAudio = value;
    }
}