import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../components/modals/create_directory_modal.dart';
import '../../components/modals/create_file_modal.dart';
import '../../constants.dart';
import '../../core/stores/directory_store.dart';
import '../../core/utils/dialogs.dart';
import '../../core/utils/path.dart';

class CustomAppBar extends StatelessWidget {
  void _createFolder(BuildContext context) {
    showCustomDialog(context, CreateDirectoryModal());
  }

  void _createFile(BuildContext context) {
    showCustomDialog(context, CreateFileModal());
  }

  void _moveHistoryPrevious(BuildContext context) {
    context.read<DirectoryStore>().moveHistoryPrevious();
  }

  void _moveHistoryNext(BuildContext context) {
    context.read<DirectoryStore>().moveHistoryNext();
  }

  @override
  Widget build(BuildContext context) {
    const double iconSize = 24;
    final currentDirectory = context.watch<DirectoryStore>().currentDir;
    final canMovePrevious = context.watch<DirectoryStore>().canMovePrevious;
    final canMoveNext = context.watch<DirectoryStore>().canMoveNext;

    return Padding(
      padding: const EdgeInsets.all(16),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          GestureDetector(
            onTap: () => _moveHistoryPrevious(context),
            child: Icon(
              FluentIcons.chevron_left_16_filled,
              color: canMovePrevious ? Colors.white : Colors.grey.shade600,
              size: iconSize,
            ),
          ),
          horizontalSpacing,
          GestureDetector(
            onTap: () => _moveHistoryNext(context),
            child: Icon(
              FluentIcons.chevron_right_16_filled,
              color: canMoveNext ? Colors.white : Colors.grey.shade600,
              size: iconSize,
            ),
          ),
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
            child: const Icon(
              FluentIcons.document_add_16_regular,
              size: iconSize,
            ),
          ),
          horizontalSpacing,
          GestureDetector(
            onTap: () => _createFolder(context),
            child: const Icon(
              FluentIcons.folder_add_16_regular,
              size: iconSize,
            ),
          ),
          horizontalSpacing,
          const Icon(FluentIcons.search_16_regular, size: iconSize),
        ],
      ),
    );
  }
}
