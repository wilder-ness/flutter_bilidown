import 'package:flutter/material.dart';
import 'package:flutter_bilidown/app/utils.dart';
import 'package:flutter_bilidown/sql/history.dart';
import 'package:fluttertoast/fluttertoast.dart';

class HistoryPage extends StatefulWidget {
  HistoryPage({Key key}) : super(key: key);

  _HistoryPageState createState() => _HistoryPageState();
}

class _HistoryPageState extends State<HistoryPage> {
  List<History> _list=[];
  @override
  void initState() { 
    super.initState();
    loadHistory();
  }
  void loadHistory() async{
    var data=await HistoryProvider.getItems();
    setState(() {
       _list=data;
    });
   
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:AppBar(
        title: Text("历史记录"),
        actions: <Widget>[
          IconButton(icon: Icon(Icons.delete),onPressed: () async{
            var results=await HistoryProvider.clear();
            Fluttertoast.showToast(msg: "已清除$results条数据");
            loadHistory();
          },)
        ],
      ),
      body: ListView.builder(
        itemCount: _list.length,
        itemBuilder: (context,i)=>ListTile(
          onTap: (){
           
            Utils.eventBus_openId.fire(_list[i].id);
            Navigator.pop<String>(context);
          },
          title: Text(_list[i].title),
          subtitle: Text(DateTime.fromMillisecondsSinceEpoch(_list[i].datetime).toString()),
        ),
      ),
    );
  }
}