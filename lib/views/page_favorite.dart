import 'package:flutter/material.dart';
import 'package:flutter_bilidown/app/utils.dart';
import 'package:flutter_bilidown/sql/favorite.dart';
import 'package:flutter_bilidown/sql/history.dart';
import 'package:fluttertoast/fluttertoast.dart';

class FavoritePage extends StatefulWidget {
  FavoritePage({Key key}) : super(key: key);

  _FavoritePageState createState() => _FavoritePageState();
}

class _FavoritePageState extends State<FavoritePage> {
  List<Favorite> _list=[];
  @override
  void initState() { 
    super.initState();
    loadFavorite();
  }
  void loadFavorite() async{
    var data=await FavoriteProvider.getItems();
    setState(() {
       _list=data;
    });
   
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:AppBar(
        title: Text("我的收藏"),
      ),
      body: ListView.builder(
        itemCount: _list.length,
        itemBuilder: (context,i)=>ListTile(
          onTap: (){
            Utils.eventBus_openId.fire(_list[i].id);
            Navigator.pop<String>(context);
          },
          title: Text(_list[i].title),
          subtitle: Text(_list[i].id),
        ),
      ),
    );
  }
}