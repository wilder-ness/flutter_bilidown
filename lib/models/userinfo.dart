import 'dart:convert' show json;

class UserInfo {
  String name;
  String access_key;
  String expired_time;
  String photo;
  int mid;
  bool isVip;
    UserInfo({
this.name,
this.access_key,
this.expired_time,
this.photo,
this.mid,
this.isVip
    });


  factory UserInfo.fromJson(jsonRes)=>jsonRes == null? null:UserInfo(    name : jsonRes['name'],
    access_key : jsonRes['access_key'],
    expired_time : jsonRes['expired_time'],
    photo : jsonRes['photo'],
    mid : jsonRes['mid'],
    isVip : jsonRes['isVip'],
);
  Map<String, dynamic> toJson() => {
        'name': name,
        'access_key': access_key,
        'expired_time': expired_time,
        'photo': photo,
        'mid': mid,
        'isVip':isVip
};

  @override
String  toString() {
    return json.encode(this);
  }
}

