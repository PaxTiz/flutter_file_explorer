import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../components/modals/create_directory_modal.dart';
import '../../components/modals/create_file_modal.dart';
import '../../constants.dart';
import '../../stores/directory_store.dart';
import '../../utils/path.dart';

class CustomAppBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    const double iconSize = 24;
    final currentDirectory = context.watch<DirectoryStore>().currentDir;

    void _createFolder(BuildContext context) {
      showDialog(
        context: context,
        barrierDismissible: true,
        builder: (_) => CreateDirectoryModal(),
      );
    }

    void _createFile(BuildContext context) {
      showDialog(
        context: context,
        barrierDismissible: true,
        builder: (_) => CreateFileModal(),
      );
    }

    return Padding(
      padding: const EdgeInsets.all(16),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const Icon(CupertinoIcons.chevron_left, size: iconSize),
          horizontalSpacing,
          const Icon(CupertinoIcons.chevron_right, size: iconSize),
          horizontalSpacing,
          Text(
            fileOrDirectoryName(currentDirectory),
            style:
                Theme.of(context).textTheme.headline6!.copyWith(fontSize: 15),
          ),
          horizontalSpacing,
          const Spacer(),
          horizontalSpacing,
          GestureDetector(
            onTap: () => _createFile(context),
            child: const Icon(CupertinoIcons.doc_text, size: iconSize),
          ),
          horizontalSpacing,
          GestureDetector(
            onTap: () => _createFolder(context),
            child: const Icon(CupertinoIcons.folder_badge_plus, size: iconSize),
          ),
          horizontalSpacing,
          const Icon(CupertinoIcons.search, size: iconSize),
        ],
      ),
    );
  }
}
