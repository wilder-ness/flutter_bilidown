import 'package:sqflite/sqflite.dart';

final String tableFavorite = 'favorite';
final String favoriteColumnId = '_id';
final String favoriteColumnTitle = 'title';
final String favoriteColumnIsSeason = 'isSeason';
final String favoriteColumnCover = 'cover';

class Favorite {
  String id;
  String title;
  bool isSeason;
  String cover;

  Map<String, dynamic> toMap() {
    var map = <String, dynamic>{
     favoriteColumnId:id,
      favoriteColumnTitle: title,
      favoriteColumnIsSeason: isSeason == true ? 1 : 0,
      favoriteColumnCover:cover
    };
    return map;
  }

  Favorite(this.id,this.title,this.isSeason,this.cover);

  Favorite.fromMap(Map<String, dynamic> map) {
    id = map[favoriteColumnId];
    title = map[favoriteColumnTitle];
    isSeason = map[favoriteColumnIsSeason] == 1;
    cover= map[favoriteColumnCover];
  }
}

 class FavoriteProvider {
  static Database db;


  static Future<Favorite> insert(Favorite item) async {
   await db.insert(tableFavorite, item.toMap());
    return item;
  }

  static Future<Favorite> getItem(String id) async {
    List<Map> maps = await db.query(tableFavorite,
        columns: [favoriteColumnId, favoriteColumnTitle, favoriteColumnIsSeason,favoriteColumnCover],
        where: '$favoriteColumnId = ?',
        whereArgs: [id]);
    if (maps.length > 0) {
      return Favorite.fromMap(maps.first);
    }
    return null;
  }
   static Future<int> clear() async {
    return await db.delete(tableFavorite);
  }

 static Future<List<Favorite>> getItems() async {
    List<Favorite> maps = (await db.query(tableFavorite)).map<Favorite>((x)=>Favorite.fromMap(x)).toList();
    return maps;
  }
  
 static Future<int> delete(String id) async {
    return await db.delete(tableFavorite, where: '$favoriteColumnId = ?', whereArgs: [id]);
  }

  static Future<int> update(Favorite item) async {
    return await db.update(tableFavorite, item.toMap(),
        where: '$favoriteColumnId = ?', whereArgs: [item.id]);
  }

  static Future close() async => db.close();
}