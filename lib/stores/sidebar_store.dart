import 'dart:io';

import 'package:flutter/cupertino.dart';

import '../utils/path.dart';

class SidebarStore extends ChangeNotifier {
  late final String _userDirectory;

  Map<String, FileSystemEntity> _favorites = {};
  Map<String, FileSystemEntity> _icloud = {};

  SidebarStore() {
    final userDirectory = Platform.environment['HOME'];

    if (userDirectory == null) {
      throw Exception('Cannot find user home directory');
    }

    _userDirectory = userDirectory;
    _favorites = {
      'Documents': Directory(userDirectory + '/Documents'),
      fileOrDirectoryName(Directory(userDirectory)): Directory(userDirectory),
      'Applications': Directory(userDirectory + '/Applications'),
      'Desktop': Directory(userDirectory + '/Desktop'),
      'Downloads': Directory(userDirectory + '/Downloads'),
      'Pictures': Directory(userDirectory + '/Pictures'),
    };
    _icloud = {
      'Pages': Directory(_userDirectory +
          '/Library/Mobile Documents/com~apple~Pages/Documents'),
      'Keynote': Directory(_userDirectory +
          '/Library/Mobile Documents/com~apple~Keynote/Documents'),
      'Numbers': Directory(_userDirectory +
          '/Library/Mobile Documents/com~apple~Numbers/Documents'),
      'Preview': Directory(_userDirectory +
          '/Library/Mobile Documents/com~apple~Preview/Documents')
    };
  }

  Map<String, Map<String, FileSystemEntity>> get items => {
        'Favorites': _favorites,
        'iCloud': _icloud,
      };
}
