import 'dart:io';

import 'package:flutter/cupertino.dart';

import '../utils/path.dart';

class DirectoryStore extends ChangeNotifier {
  late Directory _currentFolder;
  String? _selectedItem;
  final List<String> _history = [];
  int _historyIndex = 0;

  DirectoryStore() {
    final userDirectory = Platform.environment['HOME'];
    if (userDirectory == null) {
      throw Exception('Cannot find home user directory');
    }

    _currentFolder = Directory(userDirectory);
    _history.add(userDirectory);
  }

  Iterable<FileSystemEntity> children({
    bool hidden = false,
    withDirectories = false,
  }) {
    if (!withDirectories && !hidden) {
      return _currentFolder
          .listSync()
          .where((e) => !fileOrDirectoryName(e).startsWith('.') && e is File);
    }
    if (!withDirectories && hidden) {
      return _currentFolder.listSync().whereType<File>();
    }
    if (withDirectories && !hidden) {
      return _currentFolder
          .listSync()
          .where((e) => !fileOrDirectoryName(e).startsWith('.'));
    }

    return _currentFolder.listSync();
  }

  // TODO; Handle case when user go to another directory after go back
  bool get canMovePrevious => _historyIndex > 0;
  bool get canMoveNext => _historyIndex < _history.length - 1;

  void moveHistoryPrevious() {
    if (_historyIndex > 0) {
      _historyIndex -= 1;
      _currentFolder = Directory(_history[_historyIndex]);
      notifyListeners();
    }
  }

  void moveHistoryNext() {
    if (_historyIndex < _history.length - 1) {
      _historyIndex += 1;
      _currentFolder = Directory(_history[_historyIndex]);
      notifyListeners();
    }
  }

  void createDirectory(String name) {
    final dir = Directory(name);
    if (dir.existsSync()) {
      throw FileSystemException(
          'Directory ${fileOrDirectoryName(dir)} already exists');
    }

    dir.createSync(recursive: true);
    _currentFolder = dir;
    _history.add(dir.path);
    _historyIndex += 1;
    notifyListeners();
  }

  void createFile(String name) {
    final file = File(name);
    if (file.existsSync()) {
      throw FileSystemException(
          'File ${fileOrDirectoryName(file)} already exists');
    }

    file.createSync(recursive: true);
    notifyListeners();
  }

  Directory get currentDir => _currentFolder;
  set currentFolder(Directory directory) {
    _currentFolder = directory;
    _history.add(directory.path);
    _historyIndex += 1;
    notifyListeners();
  }

  String? get selectedItem => _selectedItem;
  set selectedItem(String? fs) {
    _selectedItem = fs;
    notifyListeners();
  }
}
