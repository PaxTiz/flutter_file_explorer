import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../utils/path.dart';

class FileExplorerItem extends StatelessWidget {
  final FileSystemEntity fsEntity;
  const FileExplorerItem({required this.fsEntity});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Image.asset(
          'assets/images/icons/${fsEntity is Directory ? "folder" : "file"}.png',
          // width: 80,
          fit: BoxFit.cover,
        ),
        Text(
          fileOrDirectoryName(fsEntity),
          textAlign: TextAlign.center,
          style: Theme.of(context).textTheme.headline6,
        )
      ],
    );
  }
}
