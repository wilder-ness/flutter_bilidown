import 'dart:convert' show json;

class UserProfile {
  int code;
  String message;
  int ttl;
  UserProfileData data;

    UserProfile({
this.code,
this.message,
this.ttl,
this.data,
    });


  factory UserProfile.fromJson(jsonRes)=>jsonRes == null? null:UserProfile(    code : jsonRes['code'],
    message : jsonRes['message'],
    ttl : jsonRes['ttl'],
    data : UserProfileData.fromJson(jsonRes['data']),
);
  Map<String, dynamic> toJson() => {
        'code': code,
        'message': message,
        'ttl': ttl,
        'data': data,
};

  @override
String  toString() {
    return json.encode(this);
  }
}
class UserProfileData {
  int mid;
  String name;
  String sex;
  String face;
  String sign;
  int rank;
  int level;
  int jointime;
  int moral;
  int silence;
  String birthday;
  int coins;
  bool fans_badge;
  Official official;
  Vip vip;
  bool is_followed;
  String top_photo;
  Object theme;
  Object sys_notice;

    UserProfileData({
this.mid,
this.name,
this.sex,
this.face,
this.sign,
this.rank,
this.level,
this.jointime,
this.moral,
this.silence,
this.birthday,
this.coins,
this.fans_badge,
this.official,
this.vip,
this.is_followed,
this.top_photo,
this.theme,
this.sys_notice,
    });


  factory UserProfileData.fromJson(jsonRes)=>jsonRes == null? null:UserProfileData(    mid : jsonRes['mid'],
    name : jsonRes['name'],
    sex : jsonRes['sex'],
    face : jsonRes['face'],
    sign : jsonRes['sign'],
    rank : jsonRes['rank'],
    level : jsonRes['level'],
    jointime : jsonRes['jointime'],
    moral : jsonRes['moral'],
    silence : jsonRes['silence'],
    birthday : jsonRes['birthday'],
    coins : jsonRes['coins'],
    fans_badge : jsonRes['fans_badge'],
    official : Official.fromJson(jsonRes['official']),
    vip : Vip.fromJson(jsonRes['vip']),
    is_followed : jsonRes['is_followed'],
    top_photo : jsonRes['top_photo'],
    theme : jsonRes['theme'],
    sys_notice : jsonRes['sys_notice'],
);
  Map<String, dynamic> toJson() => {
        'mid': mid,
        'name': name,
        'sex': sex,
        'face': face,
        'sign': sign,
        'rank': rank,
        'level': level,
        'jointime': jointime,
        'moral': moral,
        'silence': silence,
        'birthday': birthday,
        'coins': coins,
        'fans_badge': fans_badge,
        'official': official,
        'vip': vip,
        'is_followed': is_followed,
        'top_photo': top_photo,
        'theme': theme,
        'sys_notice': sys_notice,
};

  @override
String  toString() {
    return json.encode(this);
  }
}
class Official {
  int role;
  String title;
  String desc;

    Official({
this.role,
this.title,
this.desc,
    });


  factory Official.fromJson(jsonRes)=>jsonRes == null? null:Official(    role : jsonRes['role'],
    title : jsonRes['title'],
    desc : jsonRes['desc'],
);
  Map<String, dynamic> toJson() => {
        'role': role,
        'title': title,
        'desc': desc,
};

  @override
String  toString() {
    return json.encode(this);
  }
}

class Vip {
  int type;
  int status;
  int theme_type;

    Vip({
this.type,
this.status,
this.theme_type,
    });


  factory Vip.fromJson(jsonRes)=>jsonRes == null? null:Vip(    type : jsonRes['type'],
    status : jsonRes['status'],
    theme_type : jsonRes['theme_type'],
);
  Map<String, dynamic> toJson() => {
        'type': type,
        'status': status,
        'theme_type': theme_type,
};

  @override
String  toString() {
    return json.encode(this);
  }
}



