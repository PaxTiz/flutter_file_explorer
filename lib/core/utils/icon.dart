import 'dart:io';

String fileIcon(String path) {
  if (FileSystemEntity.isDirectorySync(path)) {
    return 'folder.png';
  }
  return 'file.png';
}
