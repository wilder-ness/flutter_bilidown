import 'dart:convert' show json;

class VersionInfo {
  String _buildNumber;
  String get buildNumber => _buildNumber;
  set buildNumber(value)  {
    _buildNumber = value;
  }

  String _version;
  String get version => _version;
  set version(value)  {
    _version = value;
  }

  String _titile;
  String get titile => _titile;
  set titile(value)  {
    _titile = value;
  }

  String _message;
  String get message => _message;
  set message(value)  {
    _message = value;
  }

  String _url;
  String get url => _url;
  set url(value)  {
    _url = value;
  }


    VersionInfo({
String buildNumber,
String version,
String titile,
String message,
String url,
}):_buildNumber=buildNumber,_version=version,_titile=titile,_message=message,_url=url;
  factory VersionInfo.fromJson(jsonRes)=>jsonRes == null? null:VersionInfo(    buildNumber : jsonRes['buildNumber'],
    version : jsonRes['version'],
    titile : jsonRes['titile'],
    message : jsonRes['message'],
    url : jsonRes['url'],
);
  Map<String, dynamic> toJson() => {
        'buildNumber': _buildNumber,
        'version': _version,
        'titile': _titile,
        'message': _message,
        'url': _url,
};
  @override
String  toString() {
    return json.encode(this);
  }
}

