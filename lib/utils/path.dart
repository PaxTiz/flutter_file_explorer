import 'dart:io';

String fileOrDirectoryName(FileSystemEntity directory) {
  final paths = directory.path.split(Platform.pathSeparator);
  return paths.last;
}
