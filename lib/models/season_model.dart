import 'dart:convert' show json;

class SeasonInfo {
  int code;
  String message;
  SeasonInfoResult result;

    SeasonInfo({
this.code,
this.message,
this.result,
    });


  factory SeasonInfo.fromJson(jsonRes)=>jsonRes == null? null:SeasonInfo(    code : jsonRes['code'],
    message : jsonRes['message'],
    result : SeasonInfoResult.fromJson(jsonRes['result']),
);
  Map<String, dynamic> toJson() => {
        'code': code,
        'message': message,
        'result': result,
};

  @override
String  toString() {
    return json.encode(this);
  }
}
class SeasonInfoResult {
  String actors;
  String alias;
  List<Areas> areas;
  String cover;
  List<Episodes> episodes;
  String evaluate;
  int is_paster_ads;
  String jp_title;
  String link;
  int media_id;
  int mode;
  Newest_ep newest_ep;
  String paster_text;
  Payment payment;
  Publish publish;
  Rating rating;
  Rights rights;
  int season_id;
  int season_status;
  String season_title;
  int season_type;
  List<Seasons> seasons;
  String series_title;
  String square_cover;
  String staff;
  Stat stat;
  List<String> style;
  String title;
  int total_ep;
  Up_info up_info;

    SeasonInfoResult({
this.actors,
this.alias,
this.areas,
this.cover,
this.episodes,
this.evaluate,
this.is_paster_ads,
this.jp_title,
this.link,
this.media_id,
this.mode,
this.newest_ep,
this.paster_text,
this.payment,
this.publish,
this.rating,
this.rights,
this.season_id,
this.season_status,
this.season_title,
this.season_type,
this.seasons,
this.series_title,
this.square_cover,
this.staff,
this.stat,
this.style,
this.title,
this.total_ep,
this.up_info,
    });


  factory SeasonInfoResult.fromJson(jsonRes){ if(jsonRes == null) return null;
    List<Areas> areas = jsonRes['areas'] is List ? []: null; 
    if(areas!=null) {
 for (var item in jsonRes['areas']) { if (item != null) { areas.add(Areas.fromJson(item));  }
    }
    }


    List<Episodes> episodes = jsonRes['episodes'] is List ? []: null; 
    if(episodes!=null) {
 for (var item in jsonRes['episodes']) { if (item != null) { episodes.add(Episodes.fromJson(item));  }
    }
    }


    List<Seasons> seasons = jsonRes['seasons'] is List ? []: null; 
    if(seasons!=null) {
 for (var item in jsonRes['seasons']) { if (item != null) { seasons.add(Seasons.fromJson(item));  }
    }
    }


    List<String> style = jsonRes['style'] is List ? []: null; 
    if(style!=null) {
 for (var item in jsonRes['style']) { if (item != null) { style.add(item);  }
    }
    }


return SeasonInfoResult(    actors : jsonRes['actors'],
    alias : jsonRes['alias'],
 areas:areas,
    cover : jsonRes['cover'],
 episodes:episodes,
    evaluate : jsonRes['evaluate'],
    is_paster_ads : jsonRes['is_paster_ads'],
    jp_title : jsonRes['jp_title'],
    link : jsonRes['link'],
    media_id : jsonRes['media_id'],
    mode : jsonRes['mode'],
    newest_ep : Newest_ep.fromJson(jsonRes['newest_ep']),
    paster_text : jsonRes['paster_text'],
    payment : Payment.fromJson(jsonRes['payment']),
    publish : Publish.fromJson(jsonRes['publish']),
    rating : Rating.fromJson(jsonRes['rating']),
    rights : Rights.fromJson(jsonRes['rights']),
    season_id : jsonRes['season_id'],
    season_status : jsonRes['season_status'],
    season_title : jsonRes['season_title'],
    season_type : jsonRes['season_type'],
 seasons:seasons,
    series_title : jsonRes['series_title'],
    square_cover : jsonRes['square_cover'],
    staff : jsonRes['staff'],
    stat : Stat.fromJson(jsonRes['stat']),
 style:style,
    title : jsonRes['title'],
    total_ep : jsonRes['total_ep'],
    up_info : Up_info.fromJson(jsonRes['up_info']),
);}
  Map<String, dynamic> toJson() => {
        'actors': actors,
        'alias': alias,
        'areas': areas,
        'cover': cover,
        'episodes': episodes,
        'evaluate': evaluate,
        'is_paster_ads': is_paster_ads,
        'jp_title': jp_title,
        'link': link,
        'media_id': media_id,
        'mode': mode,
        'newest_ep': newest_ep,
        'paster_text': paster_text,
        'payment': payment,
        'publish': publish,
        'rating': rating,
        'rights': rights,
        'season_id': season_id,
        'season_status': season_status,
        'season_title': season_title,
        'season_type': season_type,
        'seasons': seasons,
        'series_title': series_title,
        'square_cover': square_cover,
        'staff': staff,
        'stat': stat,
        'style': style,
        'title': title,
        'total_ep': total_ep,
        'up_info': up_info,
};

  @override
String  toString() {
    return json.encode(this);
  }
}
class Areas {
  int id;
  String name;

    Areas({
this.id,
this.name,
    });


  factory Areas.fromJson(jsonRes)=>jsonRes == null? null:Areas(    id : jsonRes['id'],
    name : jsonRes['name'],
);
  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
};

  @override
String  toString() {
    return json.encode(this);
  }
}

class Episodes {
  int aid;
  int cid;
  String cover;
  String badge;
  int duration;
  int ep_id;
  int episode_status;
  String from;
  String index;
  String index_title;
  int mid;
  int page;
  String pub_real_time;
  int section_id;
  int section_type;
  String vid;
    Episodes({
this.aid,
this.cid,
this.cover,
this.duration,
this.badge,
this.ep_id,
this.episode_status,
this.from,
this.index,
this.index_title,
this.mid,
this.page,
this.pub_real_time,
this.section_id,
this.section_type,
this.vid,
    });


  factory Episodes.fromJson(jsonRes)=>jsonRes == null? null:Episodes(    aid : jsonRes['aid'],
    cid : jsonRes['cid'],
    badge:  jsonRes['badge'],
    cover : jsonRes['cover'],
    duration : jsonRes['duration'],
    ep_id : jsonRes['ep_id'],
    episode_status : jsonRes['episode_status'],
    from : jsonRes['from'],
    index : jsonRes['index'],
    index_title : jsonRes['index_title'],
    mid : jsonRes['mid'],
    page : jsonRes['page'],
    pub_real_time : jsonRes['pub_real_time'],
    section_id : jsonRes['section_id'],
    section_type : jsonRes['section_type'],
    vid : jsonRes['vid'],
);
  Map<String, dynamic> toJson() => {
        'aid': aid,
        'cid': cid,
        'cover': cover,
        'duration': duration,
        'ep_id': ep_id,
        'episode_status': episode_status,
        'from': from,
        'index': index,
        'index_title': index_title,
        'mid': mid,
        'page': page,
        'pub_real_time': pub_real_time,
        'section_id': section_id,
        'section_type': section_type,
        'vid': vid,
};

  @override
String  toString() {
    return json.encode(this);
  }
}

class Newest_ep {
  String desc;
  int id;
  String index;
  int is_new;
  String pub_real_time;

    Newest_ep({
this.desc,
this.id,
this.index,
this.is_new,
this.pub_real_time,
    });


  factory Newest_ep.fromJson(jsonRes)=>jsonRes == null? null:Newest_ep(    desc : jsonRes['desc'],
    id : jsonRes['id'],
    index : jsonRes['index'],
    is_new : jsonRes['is_new'],
    pub_real_time : jsonRes['pub_real_time'],
);
  Map<String, dynamic> toJson() => {
        'desc': desc,
        'id': id,
        'index': index,
        'is_new': is_new,
        'pub_real_time': pub_real_time,
};

  @override
String  toString() {
    return json.encode(this);
  }
}

class Payment {
  int discount;
  Pay_type pay_type;
  String price;
  String promotion;
  String tip;
  int vip_discount;
  String vip_first_promotion;
  String vip_first_switch;
  String vip_promotion;

    Payment({
this.discount,
this.pay_type,
this.price,
this.promotion,
this.tip,
this.vip_discount,
this.vip_first_promotion,
this.vip_first_switch,
this.vip_promotion,
    });


  factory Payment.fromJson(jsonRes)=>jsonRes == null? null:Payment(    discount : jsonRes['discount'],
    pay_type : Pay_type.fromJson(jsonRes['pay_type']),
    price : jsonRes['price'],
    promotion : jsonRes['promotion'],
    tip : jsonRes['tip'],
    vip_discount : jsonRes['vip_discount'],
    vip_first_promotion : jsonRes['vip_first_promotion'],
    vip_first_switch : jsonRes['vip_first_switch'],
    vip_promotion : jsonRes['vip_promotion'],
);
  Map<String, dynamic> toJson() => {
        'discount': discount,
        'pay_type': pay_type,
        'price': price,
        'promotion': promotion,
        'tip': tip,
        'vip_discount': vip_discount,
        'vip_first_promotion': vip_first_promotion,
        'vip_first_switch': vip_first_switch,
        'vip_promotion': vip_promotion,
};

  @override
String  toString() {
    return json.encode(this);
  }
}
class Pay_type {
  int allow_discount;
  int allow_pack;
  int allow_ticket;
  int allow_time_limit;
  int allow_vip_discount;

    Pay_type({
this.allow_discount,
this.allow_pack,
this.allow_ticket,
this.allow_time_limit,
this.allow_vip_discount,
    });


  factory Pay_type.fromJson(jsonRes)=>jsonRes == null? null:Pay_type(    allow_discount : jsonRes['allow_discount'],
    allow_pack : jsonRes['allow_pack'],
    allow_ticket : jsonRes['allow_ticket'],
    allow_time_limit : jsonRes['allow_time_limit'],
    allow_vip_discount : jsonRes['allow_vip_discount'],
);
  Map<String, dynamic> toJson() => {
        'allow_discount': allow_discount,
        'allow_pack': allow_pack,
        'allow_ticket': allow_ticket,
        'allow_time_limit': allow_time_limit,
        'allow_vip_discount': allow_vip_discount,
};

  @override
String  toString() {
    return json.encode(this);
  }
}


class Publish {
  int is_finish;
  int is_started;
  String pub_time;
  String pub_time_show;
  int weekday;

    Publish({
this.is_finish,
this.is_started,
this.pub_time,
this.pub_time_show,
this.weekday,
    });


  factory Publish.fromJson(jsonRes)=>jsonRes == null? null:Publish(    is_finish : jsonRes['is_finish'],
    is_started : jsonRes['is_started'],
    pub_time : jsonRes['pub_time'],
    pub_time_show : jsonRes['pub_time_show'],
    weekday : jsonRes['weekday'],
);
  Map<String, dynamic> toJson() => {
        'is_finish': is_finish,
        'is_started': is_started,
        'pub_time': pub_time,
        'pub_time_show': pub_time_show,
        'weekday': weekday,
};

  @override
String  toString() {
    return json.encode(this);
  }
}

class Rating {
  int count;
  double score;

    Rating({
this.count,
this.score,
    });


  factory Rating.fromJson(jsonRes)=>jsonRes == null? null:Rating(    count : jsonRes['count'],
    score : jsonRes['score'],
);
  Map<String, dynamic> toJson() => {
        'count': count,
        'score': score,
};

  @override
String  toString() {
    return json.encode(this);
  }
}

class Rights {
  int allow_bp;
  int allow_bp_rank;
  int allow_download;
  int allow_review;
  int can_watch;
  String copyright;
  int is_preview;
  int watch_platform;

    Rights({
this.allow_bp,
this.allow_bp_rank,
this.allow_download,
this.allow_review,
this.can_watch,
this.copyright,
this.is_preview,
this.watch_platform,
    });


  factory Rights.fromJson(jsonRes)=>jsonRes == null? null:Rights(    allow_bp : jsonRes['allow_bp'],
    allow_bp_rank : jsonRes['allow_bp_rank'],
    allow_download : jsonRes['allow_download'],
    allow_review : jsonRes['allow_review'],
    can_watch : jsonRes['can_watch'],
    copyright : jsonRes['copyright'],
    is_preview : jsonRes['is_preview'],
    watch_platform : jsonRes['watch_platform'],
);
  Map<String, dynamic> toJson() => {
        'allow_bp': allow_bp,
        'allow_bp_rank': allow_bp_rank,
        'allow_download': allow_download,
        'allow_review': allow_review,
        'can_watch': can_watch,
        'copyright': copyright,
        'is_preview': is_preview,
        'watch_platform': watch_platform,
};

  @override
String  toString() {
    return json.encode(this);
  }
}

class Seasons {
  String badge;
  int badge_type;
  String cover;
  int media_id;
  New_ep new_ep;
  int season_id;
  String season_title;
  int season_type;
  Stat stat;
  String title;

    Seasons({
this.badge,
this.badge_type,
this.cover,
this.media_id,
this.new_ep,
this.season_id,
this.season_title,
this.season_type,
this.stat,
this.title,
    });


  factory Seasons.fromJson(jsonRes)=>jsonRes == null? null:Seasons(    badge : jsonRes['badge'],
    badge_type : jsonRes['badge_type'],
    cover : jsonRes['cover'],
    media_id : jsonRes['media_id'],
    new_ep : New_ep.fromJson(jsonRes['new_ep']),
    season_id : jsonRes['season_id'],
    season_title : jsonRes['season_title'],
    season_type : jsonRes['season_type'],
    stat : Stat.fromJson(jsonRes['stat']),
    title : jsonRes['title'],
);
  Map<String, dynamic> toJson() => {
        'badge': badge,
        'badge_type': badge_type,
        'cover': cover,
        'media_id': media_id,
        'new_ep': new_ep,
        'season_id': season_id,
        'season_title': season_title,
        'season_type': season_type,
        'stat': stat,
        'title': title,
};

  @override
String  toString() {
    return json.encode(this);
  }
}
class New_ep {
  String cover;
  int id;
  String index_show;

    New_ep({
this.cover,
this.id,
this.index_show,
    });


  factory New_ep.fromJson(jsonRes)=>jsonRes == null? null:New_ep(    cover : jsonRes['cover'],
    id : jsonRes['id'],
    index_show : jsonRes['index_show'],
);
  Map<String, dynamic> toJson() => {
        'cover': cover,
        'id': id,
        'index_show': index_show,
};

  @override
String  toString() {
    return json.encode(this);
  }
}


class Stat {
  int coins;
  int danmakus;
  int favorites;
  int reply;
  int share;
  int views;

    Stat({
this.coins,
this.danmakus,
this.favorites,
this.reply,
this.share,
this.views,
    });


  factory Stat.fromJson(jsonRes)=>jsonRes == null? null:Stat(    coins : jsonRes['coins'],
    danmakus : jsonRes['danmakus'],
    favorites : jsonRes['favorites'],
    reply : jsonRes['reply'],
    share : jsonRes['share'],
    views : jsonRes['views'],
);
  Map<String, dynamic> toJson() => {
        'coins': coins,
        'danmakus': danmakus,
        'favorites': favorites,
        'reply': reply,
        'share': share,
        'views': views,
};

  @override
String  toString() {
    return json.encode(this);
  }
}

class Up_info {
  String avatar;
  int follower;
  int is_vip;
  int mid;
  Pendant pendant;
  String uname;
  int verify_type;

    Up_info({
this.avatar,
this.follower,
this.is_vip,
this.mid,
this.pendant,
this.uname,
this.verify_type,
    });


  factory Up_info.fromJson(jsonRes)=>jsonRes == null? null:Up_info(    avatar : jsonRes['avatar'],
    follower : jsonRes['follower'],
    is_vip : jsonRes['is_vip'],
    mid : jsonRes['mid'],
    pendant : Pendant.fromJson(jsonRes['pendant']),
    uname : jsonRes['uname'],
    verify_type : jsonRes['verify_type'],
);
  Map<String, dynamic> toJson() => {
        'avatar': avatar,
        'follower': follower,
        'is_vip': is_vip,
        'mid': mid,
        'pendant': pendant,
        'uname': uname,
        'verify_type': verify_type,
};

  @override
String  toString() {
    return json.encode(this);
  }
}
class Pendant {
  String image;
  String name;
  int pid;

    Pendant({
this.image,
this.name,
this.pid,
    });


  factory Pendant.fromJson(jsonRes)=>jsonRes == null? null:Pendant(    image : jsonRes['image'],
    name : jsonRes['name'],
    pid : jsonRes['pid'],
);
  Map<String, dynamic> toJson() => {
        'image': image,
        'name': name,
        'pid': pid,
};

  @override
String  toString() {
    return json.encode(this);
  }
}




