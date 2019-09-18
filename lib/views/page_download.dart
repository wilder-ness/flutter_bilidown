import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bilidown/app/api.dart';
import 'package:flutter_bilidown/app/folder_picker.dart';
import 'package:flutter_bilidown/app/utils.dart';
import 'package:flutter_bilidown/models/season_model.dart';
import 'package:flutter_downloader/flutter_downloader.dart';
import 'package:path_provider/path_provider.dart';

class DownloadPage extends StatefulWidget {
  DownloadPage({Key key}) : super(key: key);

  _DownloadPageState createState() => _DownloadPageState();
}

class _DownloadPageState extends State<DownloadPage> {
  String _taskid;
  String _content = "";
  List<DownloadItemDisplay> _downloadList = [];
  @override
  void initState() {
    super.initState();
    Utils.eventBus_startDown.on<String>().listen((data){
      loadTasks();
    });
    loadTasks();
    FlutterDownloader.registerCallback((id, status, progress) {
      setState(() {
        var item = _downloadList.firstWhere((x) => x.taskId == id,orElse: ()=>null);
        if(item!=null){
          if(status==DownloadTaskStatus.complete){
              _downloadList.remove(item);
          }
         else{
            item.progress=progress;
            item.status=status;
         }
        }
      });
    });
  }

  void loadTasks() async {
    var list = await FlutterDownloader.loadTasks();
    setState(() {
     _downloadList.clear();
      _downloadList= list.where((x) =>
              x.status == DownloadTaskStatus.enqueued ||
              x.status == DownloadTaskStatus.failed ||
              x.status == DownloadTaskStatus.paused ||
              x.status == DownloadTaskStatus.running).map<DownloadItemDisplay>((item)=>DownloadItemDisplay(
            taskId: item.taskId,
            savedDir: item.savedDir,
            status: item.status,
            progress: item.progress,
            filename: item.filename,
            url: item.url,
            title: ""
          )).toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView.builder(
        itemCount: _downloadList.length,
        itemBuilder: (ctx, i) => ListTile(
          title: Text(_downloadList[i].filename??""),
          subtitle: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
                LinearProgressIndicator(
                  value:
                      _downloadList[i].progress.toDouble() / 100),
              Text(statusToString(_downloadList[i].status) +
                  "/" +
                  _downloadList[i].progress.toString()+"%")
            
            ],
          ),
          onLongPress: (){
            Utils.showAlertDialog(context, Text("取消任务"), Text("确定要取消此任务吗？"),
              onCancelTaped: ()=>Navigator.pop(context),
              onOkTaped: () async{
                Navigator.pop(context);
                FlutterDownloader.remove(taskId:_downloadList[i].taskId,shouldDeleteContent: true);
                loadTasks();
              }
            );

          },
          trailing: statusIconButton(_downloadList[i].taskId,_downloadList[i].status),
        ),
      ),
      // floatingActionButton: FloatingActionButton(
      //   child: Icon(Icons.file_download),
      //   onPressed: doTestDownload,
      // ),
    );
  }

  void doTestDownload() async {
    var path = await getExternalStorageDirectory();
    
    // print(Api.sign("https://api.bilibili.com/pgc/player/api/playurl?access_key=020a887341f1b459fac80d12de309391&aid=9630292&appkey=1d8b6e7d45233436&build=5442100&buvid=ECQcLE59G39Ifx0uUmBSYFJjU2RUY1VnVytXinfoc&cid=15915981&device=android&expire=1571150544&fnval=16&fnver=0&fourk=1&mid=7251681&mobi_app=android&module=bangumi&npcybs=0&otype=json&platform=android&qn=32&season_type=1&session=f18e350b0949b22c644a6f206a9cf11f&track_path=0&ts=1568642407",Api.android_appsecret));
    // print(path);
    _taskid = await FlutterDownloader.enqueue(
      url:
          'http://upos-hz-mirrorks3u.acgvideo.com/upgcxcode/76/47/14324776/14324776-1-80.flv?e=ig8euxZM2rNcNbKj7zUVhoMM7buBhwdEto8g5X10ugNcXBlqNCNEto8g5gNvNE3DN0B5tZlqNxTEto8BTrNvN05fqx6S5ahE9IMvXBvE2ENvNCImNEVEK9GVqJIwqa80WXIekXRE9IB5QK==&deadline=1568725723&gen=playurl&nbs=1&oi=3400791421&os=kodou&platform=android&trid=6f4e3a939bb14ffaa256056355c2ef18&uipk=5&upsig=2af295d168e5d12146471ede74be874f&uparams=e,deadline,gen,nbs,oi,os,platform,trid,uipk&mid=92074961',
      savedDir: path.path,
      fileName: "14324776",
      headers: {"User-Agent": "Bilibili Freedoooooom/MarkII"},
      showNotification:
          true, // show download progress in status bar (for Android)
      openFileFromNotification:
          false, // click on notification to open downloaded file (for Android)
    );
  }

  IconButton statusIconButton(String taskId, DownloadTaskStatus status) {
    var icon = Icon(Icons.file_download);
    if (status == DownloadTaskStatus.failed) {
      icon = Icon(Icons.refresh);
    } else if (status == DownloadTaskStatus.paused) {
      icon = Icon(Icons.file_download);
    } else if (status == DownloadTaskStatus.enqueued) {
      icon = Icon(Icons.file_download);
    } else if (status == DownloadTaskStatus.running) {
      icon = Icon(Icons.pause);
    }

    return IconButton(
      icon: icon,
      onPressed: () async{
        if (status == DownloadTaskStatus.failed) {
          await FlutterDownloader.retry(taskId: taskId);
          loadTasks();
        } else if (status == DownloadTaskStatus.paused) {
          await FlutterDownloader.resume(taskId: taskId);
        } else if (status == DownloadTaskStatus.enqueued) {
          await FlutterDownloader.resume(taskId: taskId);
        } else if (status == DownloadTaskStatus.running) {
          await FlutterDownloader.pause(taskId: taskId);
        }
      },
    );
  }

  String statusToString(DownloadTaskStatus status) {
    if (status == DownloadTaskStatus.canceled) {
      return "已取消";
    } else if (status == DownloadTaskStatus.complete) {
      return "已完成";
    } else if (status == DownloadTaskStatus.enqueued) {
      return "队列中";
    } else if (status == DownloadTaskStatus.failed) {
      return "下载失败";
    } else if (status == DownloadTaskStatus.paused) {
      return "暂停中";
    } else if (status == DownloadTaskStatus.running) {
      return "下载中";
    } else {
      return "未知";
    }
  }
}
class DownloadItemDisplay{
    DownloadItemDisplay({
 taskId,
String savedDir,
DownloadTaskStatus status,
int progress,
String filename,
String url,
String title,
}):_taskId=taskId,_savedDir=savedDir,_status=status,_progress=progress,_filename=filename,_url=url,_title=title;

  String _taskId;
  String get taskId => _taskId;
  set taskId(value)  {
    _taskId = value;
  }

  String _savedDir;
  String get savedDir => _savedDir;
  set savedDir(value)  {
    _savedDir = value;
  }

  DownloadTaskStatus _status;
  DownloadTaskStatus get status => _status;
  set status(value)  {
    _status = value;
  }

  int _progress;
  int get progress => _progress;
  set progress(value)  {
    _progress = value;
  }

  String _filename;
  String get filename => _filename;
  set filename(value)  {
    _filename = value;
  }

  String _url;
  String get url => _url;
  set url(value)  {
    _url = value;
  }

  String _title;
  String get title => _title;
  set title(value)  {
    _title = value;
  }


}