import 'dart:io';

import 'package:flutter/cupertino.dart';

import '../utils/path.dart';

class DirectoryStore extends ChangeNotifier {
  late Directory _currentFolder;
  String? _selectedItem;

  DirectoryStore() {
    final userDirectory = Platform.environment['HOME'];
    if (userDirectory == null) {
      throw Exception('Cannot find home user directory');
    }

    _currentFolder = Directory(userDirectory);
  }

  Iterable<FileSystemEntity> children(
      {bool hidden = false, withDirectories = false}) {
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

  void createDirectory(String name) {
    final dir = Directory(name);
    if (dir.existsSync()) {
      throw FileSystemException(
          'Directory ${fileOrDirectoryName(dir)} already exists');
    }

    dir.createSync(recursive: true);
    _currentFolder = dir;
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
    notifyListeners();
  }

  String? get selectedItem => _selectedItem;
  set selectedItem(String? fs) {
    _selectedItem = fs;
    notifyListeners();
  }
}
