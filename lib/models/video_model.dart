import 'dart:convert' show json;

class VideoInfo {
  int code;
  String message;
  int ttl;
  VideoInfoData data;

  VideoInfo({
    this.code,
    this.message,
    this.ttl,
    this.data,
  });

  factory VideoInfo.fromJson(jsonRes) => jsonRes == null
      ? null
      : VideoInfo(
          code: jsonRes['code'],
          message: jsonRes['message'],
          ttl: jsonRes['ttl'],
          data: VideoInfoData.fromJson(jsonRes['data']),
        );
  Map<String, dynamic> toJson() => {
        'code': code,
        'message': message,
        'ttl': ttl,
        'data': data,
      };

  @override
  String toString() {
    return json.encode(this);
  }
}

class VideoInfoData {
  int aid;
  int videos;
  int tid;
  String tname;
  int copyright;
  String pic;
  String title;
  int pubdate;
  int ctime;
  String desc;
  int state;
  int attribute;
  int duration;
  Rights rights;
  Owner owner;
  Stat stat;
  int cid;
  Dimension dimension;
  bool no_cache;
  List<Pages> pages;
  Subtitle subtitle;

  VideoInfoData({
    this.aid,
    this.videos,
    this.tid,
    this.tname,
    this.copyright,
    this.pic,
    this.title,
    this.pubdate,
    this.ctime,
    this.desc,
    this.state,
    this.attribute,
    this.duration,
    this.rights,
    this.owner,
    this.stat,
    this.cid,
    this.dimension,
    this.no_cache,
    this.pages,
    this.subtitle,
  });

  factory VideoInfoData.fromJson(jsonRes) {
    if (jsonRes == null) return null;
    List<Pages> pages = jsonRes['pages'] is List ? [] : null;
    if (pages != null) {
      for (var item in jsonRes['pages']) {
        if (item != null) {
          pages.add(Pages.fromJson(item));
        }
      }
    }

    return VideoInfoData(
      aid: jsonRes['aid'],
      videos: jsonRes['videos'],
      tid: jsonRes['tid'],
      tname: jsonRes['tname'],
      copyright: jsonRes['copyright'],
      pic: jsonRes['pic'],
      title: jsonRes['title'],
      pubdate: jsonRes['pubdate'],
      ctime: jsonRes['ctime'],
      desc: jsonRes['desc'],
      state: jsonRes['state'],
      attribute: jsonRes['attribute'],
      duration: jsonRes['duration'],
      rights: Rights.fromJson(jsonRes['rights']),
      owner: Owner.fromJson(jsonRes['owner']),
      stat: Stat.fromJson(jsonRes['stat']),
      cid: jsonRes['cid'],
      dimension: Dimension.fromJson(jsonRes['dimension']),
      no_cache: jsonRes['no_cache'],
      pages: pages,
      subtitle: Subtitle.fromJson(jsonRes['subtitle']),
    );
  }
  Map<String, dynamic> toJson() => {
        'aid': aid,
        'videos': videos,
        'tid': tid,
        'tname': tname,
        'copyright': copyright,
        'pic': pic,
        'title': title,
        'pubdate': pubdate,
        'ctime': ctime,
        'desc': desc,
        'state': state,
        'attribute': attribute,
        'duration': duration,
        'rights': rights,
        'owner': owner,
        'stat': stat,
        'cid': cid,
        'dimension': dimension,
        'no_cache': no_cache,
        'pages': pages,
        'subtitle': subtitle,
      };

  @override
  String toString() {
    return json.encode(this);
  }
}

class Rights {
  int bp;
  int elec;
  int download;
  int movie;
  int pay;
  int hd5;
  int no_reprint;
  int autoplay;
  int ugc_pay;
  int is_cooperation;
  int ugc_pay_preview;

  Rights({
    this.bp,
    this.elec,
    this.download,
    this.movie,
    this.pay,
    this.hd5,
    this.no_reprint,
    this.autoplay,
    this.ugc_pay,
    this.is_cooperation,
    this.ugc_pay_preview,
  });

  factory Rights.fromJson(jsonRes) => jsonRes == null
      ? null
      : Rights(
          bp: jsonRes['bp'],
          elec: jsonRes['elec'],
          download: jsonRes['download'],
          movie: jsonRes['movie'],
          pay: jsonRes['pay'],
          hd5: jsonRes['hd5'],
          no_reprint: jsonRes['no_reprint'],
          autoplay: jsonRes['autoplay'],
          ugc_pay: jsonRes['ugc_pay'],
          is_cooperation: jsonRes['is_cooperation'],
          ugc_pay_preview: jsonRes['ugc_pay_preview'],
        );
  Map<String, dynamic> toJson() => {
        'bp': bp,
        'elec': elec,
        'download': download,
        'movie': movie,
        'pay': pay,
        'hd5': hd5,
        'no_reprint': no_reprint,
        'autoplay': autoplay,
        'ugc_pay': ugc_pay,
        'is_cooperation': is_cooperation,
        'ugc_pay_preview': ugc_pay_preview,
      };

  @override
  String toString() {
    return json.encode(this);
  }
}

class Owner {
  int mid;
  String name;
  String face;

  Owner({
    this.mid,
    this.name,
    this.face,
  });

  factory Owner.fromJson(jsonRes) => jsonRes == null
      ? null
      : Owner(
          mid: jsonRes['mid'],
          name: jsonRes['name'],
          face: jsonRes['face'],
        );
  Map<String, dynamic> toJson() => {
        'mid': mid,
        'name': name,
        'face': face,
      };

  @override
  String toString() {
    return json.encode(this);
  }
}

class Stat {
  int aid;
  int view;
  int danmaku;
  int reply;
  int favorite;
  int coin;
  int share;
  int now_rank;
  int his_rank;
  int like;
  int dislike;

  Stat({
    this.aid,
    this.view,
    this.danmaku,
    this.reply,
    this.favorite,
    this.coin,
    this.share,
    this.now_rank,
    this.his_rank,
    this.like,
    this.dislike,
  });

  factory Stat.fromJson(jsonRes) => jsonRes == null
      ? null
      : Stat(
          aid: jsonRes['aid'],
          view: jsonRes['view'],
          danmaku: jsonRes['danmaku'],
          reply: jsonRes['reply'],
          favorite: jsonRes['favorite'],
          coin: jsonRes['coin'],
          share: jsonRes['share'],
          now_rank: jsonRes['now_rank'],
          his_rank: jsonRes['his_rank'],
          like: jsonRes['like'],
          dislike: jsonRes['dislike'],
        );
  Map<String, dynamic> toJson() => {
        'aid': aid,
        'view': view,
        'danmaku': danmaku,
        'reply': reply,
        'favorite': favorite,
        'coin': coin,
        'share': share,
        'now_rank': now_rank,
        'his_rank': his_rank,
        'like': like,
        'dislike': dislike,
      };

  @override
  String toString() {
    return json.encode(this);
  }
}

class Dimension {
  int width;
  int height;
  int rotate;

  Dimension({
    this.width,
    this.height,
    this.rotate,
  });

  factory Dimension.fromJson(jsonRes) => jsonRes == null
      ? null
      : Dimension(
          width: jsonRes['width'],
          height: jsonRes['height'],
          rotate: jsonRes['rotate'],
        );
  Map<String, dynamic> toJson() => {
        'width': width,
        'height': height,
        'rotate': rotate,
      };

  @override
  String toString() {
    return json.encode(this);
  }
}

class Pages {
  int cid;
  int page;
  String from;
  String part;
  int duration;
  String vid;
  String weblink;
  Dimension dimension;
  Pages({
    this.cid,
    this.page,
    this.from,
    this.part,
    this.duration,
    this.vid,
    this.weblink,
    this.dimension,
  });

  factory Pages.fromJson(jsonRes) => jsonRes == null
      ? null
      : Pages(
          cid: jsonRes['cid'],
          page: jsonRes['page'],
          from: jsonRes['from'],
          part: jsonRes['part'],
          duration: jsonRes['duration'],
          vid: jsonRes['vid'],
          weblink: jsonRes['weblink'],
          dimension: Dimension.fromJson(jsonRes['dimension']),
        );
  Map<String, dynamic> toJson() => {
        'cid': cid,
        'page': page,
        'from': from,
        'part': part,
        'duration': duration,
        'vid': vid,
        'weblink': weblink,
        'dimension': dimension,
      };

  @override
  String toString() {
    return json.encode(this);
  }
}

class Subtitle {
  bool allow_submit;
  List<Object> list;

  Subtitle({
    this.allow_submit,
    this.list,
  });

  factory Subtitle.fromJson(jsonRes) {
    if (jsonRes == null) return null;
    List<Object> list = jsonRes['list'] is List ? [] : null;
    if (list != null) {
      for (var item in jsonRes['list']) {
        if (item != null) {
          list.add(item);
        }
      }
    }

    return Subtitle(
      allow_submit: jsonRes['allow_submit'],
      list: list,
    );
  }
  Map<String, dynamic> toJson() => {
        'allow_submit': allow_submit,
        'list': list,
      };

  @override
  String toString() {
    return json.encode(this);
  }
}
