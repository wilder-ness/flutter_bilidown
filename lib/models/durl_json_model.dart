import 'dart:convert';

class DurlJsonModel {
  List<String> _backup_url;
  List<String> get backup_url => _backup_url;
  set backup_url(value)  {
    _backup_url = value;
  }

  int _length;
  int get length => _length;
  set length(value)  {
    _length = value;
  }

  int _order;
  int get order => _order;
  set order(value)  {
    _order = value;
  }

  int _size;
  int get size => _size;
  set size(value)  {
    _size = value;
  }

  String _url;
  String get url => _url;
  set url(value)  {
    _url = value;
  }

  String _vhead;
  String get vhead => _vhead;
  set vhead(value)  {
    _vhead = value;
  }


    DurlJsonModel({
List<String> backup_url,
int length,
int order,
int size,
String url,
String vhead,
}):_backup_url=backup_url,_length=length,_order=order,_size=size,_url=url,_vhead=vhead;
  factory DurlJsonModel.fromJson(jsonRes){ if(jsonRes == null) return null;
    List<String> backup_url = jsonRes['backup_url'] is List ? []: null; 
    if(backup_url!=null) {
 for (var item in jsonRes['backup_url']) { if (item != null) { backup_url.add(item);  }
    }
    }


return DurlJsonModel( backup_url:backup_url,
    length : jsonRes['length'],
    order : jsonRes['order'],
    size : jsonRes['size'],
    url : jsonRes['url'],
    vhead : jsonRes['vhead'],
);}
  Map<String, dynamic> toJson() => {
        'backup_url': _backup_url,
        'length': _length,
        'order': _order,
        'size': _size,
        'url': _url,
        'vhead': _vhead,
};

  @override
String  toString() {
    return json.encode(this);
  }
}
