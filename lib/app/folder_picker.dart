import 'dart:io';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:path/path.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

/// The action to be executed after the folder is picked
typedef Future<void> AfterPickedAction(BuildContext context, Directory folder);

class _FolderPickerState extends State<FolderPicker> {
  _FolderPickerState({@required this.action, @required this.rootDirectory}) {
    _currentDirectory ??= rootDirectory;
  }

  final AfterPickedAction action;
  final Directory rootDirectory;

  Directory _currentDirectory;

  List<ListTile> _getDirs(BuildContext context) {
    var tiles = <ListTile>[];
    List<Directory> dirs = ls(_currentDirectory);
    dirs.forEach((dir) {
      tiles.add(ListTile(
          leading: IconButton(
              icon: const Icon(Icons.folder, color: Colors.yellow),
              onPressed: () => setState(() => _currentDirectory = dir)),
          title: GestureDetector(
              onTap: () => setState(() => _currentDirectory = dir),
              child: Text(basename(dir.path))),
          trailing: IconButton(
              icon: const Icon(Icons.done),
              onPressed: () {
                if(dir.path=="/storage/emulated"){dir=Directory("/storage/emulated/0");}
                Navigator.of(context).pop();
                action(context, dir);
              })));
    });
    return tiles;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: (_currentDirectory == rootDirectory)
            ? _getDirs(context)
            : [
                GestureDetector(
                  child: ListTile(
                    leading: const Icon(Icons.arrow_upward),
                    title: const Text("..", textScaleFactor: 1.5 )
                  ),
                  onTap: () => setState(
                      () => _currentDirectory = _currentDirectory.parent),
                )
              ]
          ..addAll(_getDirs(context)),
      ),
    );
  }

  List<Directory> ls(Directory dir) {
    try {
      if(dir.path=="/storage/emulated"){
      dir=Directory("/storage/emulated/0");
    }
    List<FileSystemEntity> content = dir.listSync()
      ..sort((a, b) => a.path.compareTo(b.path));
    var dirs = <Directory>[];
    content.forEach((item) {
      if (item is Directory) dirs.add(Directory(item.path));
    });
    return dirs;
    } catch (e) {
      Fluttertoast.showToast(msg: "读取目录失败", toastLength: Toast.LENGTH_SHORT);
      return [];
    }
    
  }
}

/// The folder picker page
class FolderPicker extends StatefulWidget {
  /// Main constructor
  FolderPicker({@required this.action, @required this.rootDirectory});

  /// The action to execute after the file is picked
  final AfterPickedAction action;

  /// The directory to start browsing from
  final Directory rootDirectory;

  @override
  _FolderPickerState createState() =>
      _FolderPickerState(action: action, rootDirectory: rootDirectory);
}
