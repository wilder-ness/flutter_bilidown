import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';

class DownloadInfoPage extends StatefulWidget {
  DownInfo downInfo;
  DownloadInfoPage(this.downInfo, {Key key}) : super(key: key);

  _DownloadInfoPageState createState() => _DownloadInfoPageState();
}

class _DownloadInfoPageState extends State<DownloadInfoPage> {
  TextEditingController _pathController;
  TextEditingController _uaController;
  @override
  void initState() {
    super.initState();
    _pathController = TextEditingController(text: widget.downInfo.dir);
    _uaController = TextEditingController(text: widget.downInfo.ua);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("下载信息"),
      ),
      body: SingleChildScrollView(
        child: Padding(
        padding: EdgeInsets.all(8),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Column(
              children: createWidgets(),
            ),
            SizedBox(
              height: 8,
            ),
            Text("保存位置:"),
            SizedBox(
              height: 8,
            ),
            Row(
              children: <Widget>[
                Expanded(
                  child: TextField(
                      controller: _pathController,
                      decoration: InputDecoration(
                        fillColor: Colors.transparent,
                        filled: false,
                        hintText: '保存位置',
                        prefixIcon: Icon(Icons.folder),
                      )),
                ),
                IconButton(
                  icon: Icon(Icons.content_copy),
                  onPressed:  ()async{
                    await Clipboard.setData(ClipboardData(text: _pathController.text));
                    Fluttertoast.showToast(msg: "已复制到剪切板");
                  },
                )
              ],
            ),
            SizedBox(
              height: 8,
            ),
            Text("标识(User-Agent):"),
            SizedBox(
              height: 8,
            ),
            Row(
              children: <Widget>[
                Expanded(
                  child: TextField(
                      controller: _uaController,
                      decoration: InputDecoration(
                        fillColor: Colors.transparent,
                        filled: false,
                        hintText: 'User-Agent',
                        prefixIcon: Icon(Icons.info),
                      )),
                ),
                IconButton(
                  icon: Icon(Icons.content_copy),
                  onPressed:  ()async{
                    await Clipboard.setData(ClipboardData(text: _uaController.text));
                    Fluttertoast.showToast(msg: "已复制到剪切板");
                  },
                )
              ],
            ),
            SizedBox(
              height: 8,
            ),
            Text("请复制以上信息到下载器中下载")
          ],
        ),
      ),
      ),
    );
  }

  List<Widget> createWidgets() {

    List<Widget> widgets = [];
    for (var item in widget.downInfo.items) {
      TextEditingController urlController=TextEditingController(text:item.url);
      TextEditingController nameController=TextEditingController(text:item.filename);
      widgets.add(Padding(
        padding: EdgeInsets.only(bottom: 8, top: 8),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text("下载文件:"),
            SizedBox(
              height: 8,
            ),
            Row(
              children: <Widget>[
                Expanded(
                  child: TextField(
                    controller: nameController,
                    decoration: InputDecoration(
                    fillColor: Colors.transparent,
                    filled: false,
                    hintText: '文件名',
                    prefixIcon: Icon(Icons.edit),
                  )),
                ),
                IconButton(
                  icon: Icon(Icons.content_copy),
                  onPressed: ()async{
                    await Clipboard.setData(ClipboardData(text: nameController.text));
                    Fluttertoast.showToast(msg: "已复制到剪切板");
                  },
                )
              ],
            ),
            SizedBox(
              height: 8,
            ),
            Row(
              children: <Widget>[
                Expanded(
                  child: TextField(
                    controller: urlController,
                      decoration: InputDecoration(
                    fillColor: Colors.transparent,
                    filled: false,
                    hintText: '视频地址',
                    prefixIcon: Icon(Icons.public),
                  )),
                ),
                IconButton(
                  icon: Icon(Icons.content_copy),
                  onPressed:  ()async{
                    await Clipboard.setData(ClipboardData(text: urlController.text));
                    Fluttertoast.showToast(msg: "已复制到剪切板");
                  },
                )
              ],
            )
          ],
        ),
      ));
    }
    return widgets;
  }
}

class DownInfo {
  String dir;
  String ua;
  List<DownInfoItem> items;
  DownInfo(this.dir, this.ua, this.items);
}

class DownInfoItem {
  String url;
  String filename;

  DownInfoItem(this.url, this.filename);
}
