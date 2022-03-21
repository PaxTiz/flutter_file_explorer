import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../utils/icon.dart';
import '../../utils/path.dart';

class FileExplorerItem extends StatelessWidget {
  static const baseIconPath = 'assets/images/icons/';

  final FileSystemEntity fsEntity;
  const FileExplorerItem({required this.fsEntity});

  @override
  Widget build(BuildContext context) {
    final iconPath = fileIcon(fsEntity.path);
    return Column(
      children: [
        iconPath.endsWith('svg')
            ? SvgPicture.asset('$baseIconPath$iconPath', fit: BoxFit.cover)
            : Image.asset('$baseIconPath/$iconPath', fit: BoxFit.cover),
        Text(
          fileOrDirectoryName(fsEntity),
          textAlign: TextAlign.center,
          style: Theme.of(context).textTheme.headline6,
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
        ),
      ],
    );
  }
}
