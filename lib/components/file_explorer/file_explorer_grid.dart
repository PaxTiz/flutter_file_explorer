import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../core/constants/colors.dart';
import '../../stores/directory_store.dart';
import 'file_explorer_grid_item.dart';

class FileExplorerGrid extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final _children =
        context.watch<DirectoryStore>().children(withDirectories: true);
    final _selectedItem = context.watch<DirectoryStore>().selectedItem;

    var _gridRowItemsCount = (MediaQuery.of(context).size.width / 120);
    var _gridRowItemsSize =
        (MediaQuery.of(context).size.width / _gridRowItemsCount);

    return Expanded(
      child: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Wrap(
          children: _children
              .map(
                (e) => GestureDetector(
                  onTap: () =>
                      context.read<DirectoryStore>().selectedItem = e.path,
                  onDoubleTap: () {
                    if (e is Directory) {
                      context.read<DirectoryStore>().currentFolder = e;
                    } else {
                      Process.run('open', [e.path]);
                    }
                  },
                  child: Container(
                    padding: const EdgeInsets.all(16),
                    width: _gridRowItemsSize,
                    decoration: BoxDecoration(
                      color: e.path == _selectedItem
                          ? MediaQuery.of(context).platformBrightness ==
                                  Brightness.dark
                              ? dark2
                              : CupertinoColors.lightBackgroundGray
                          : Colors.transparent,
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: FileExplorerItem(fsEntity: e),
                  ),
                ),
              )
              .toList(),
        ),
      ),
    );
  }
}
