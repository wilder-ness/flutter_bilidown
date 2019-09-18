import 'package:sqflite/sqflite.dart';

final String tableHistory = 'history';
final String historyColumnId = '_id';
final String historyColumnTitle = 'title';
final String historyColumnIsSeason = 'isSeason';
final String historyColumnTime = 'datetime';

class History {
  String id;
  String title;
  bool isSeason;
  int datetime;

  Map<String, dynamic> toMap() {
    var map = <String, dynamic>{
      historyColumnId:id,
      historyColumnTitle: title,
      historyColumnIsSeason: isSeason == true ? 1 : 0,
      historyColumnTime:datetime
    };
    // if (id != null) {
    //   map[historyColumnId] = id;
    // }
    return map;
  }

  History(this.id,this.title,this.isSeason,this.datetime);

  History.fromMap(Map<String, dynamic> map) {
    id = map[historyColumnId];
    title = map[historyColumnTitle];
    isSeason = map[historyColumnIsSeason] == 1;
    datetime= map[historyColumnTime];
  }
}

 class HistoryProvider {
  static Database db;


  static Future<History> insert(History item) async {
    await db.insert(tableHistory, item.toMap());
    
    return item;
  }

  static Future<History> getItem(String id) async {
    
    List<Map> maps = await db.query(tableHistory,
        columns: [historyColumnId, historyColumnTitle, historyColumnIsSeason,historyColumnTime],
        where: '$historyColumnId = ?',
        whereArgs: [id]);
    if (maps.length > 0) {
      return History.fromMap(maps.first);
    }
    return null;
  }

  static Future<int> clear() async {
    return await db.delete(tableHistory);
  }

 static Future<List<History>> getItems() async {
    List<History> maps = (await db.query(tableHistory)).map<History>((x)=>History.fromMap(x)).toList();
    return maps;
  }

 static Future<int> delete(String id) async {
    return await db.delete(tableHistory, where: '$historyColumnId = ?', whereArgs: [id]);
  }

  static Future<int> update(History item) async {
    return await db.update(tableHistory, item.toMap(),
        where: '$historyColumnId = ?', whereArgs: [item.id]);
  }

  static Future close() async => db.close();
}