import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';

import '../../core/stores/directory_store.dart';
import 'sidebar_group_item.dart';

class SidebarGroupList extends StatelessWidget {
  final String title;
  final Map<String, FileSystemEntity> items;

  const SidebarGroupList({
    required this.title,
    required this.items,
  });

  @override
  Widget build(BuildContext context) {
    final currentItem = context.watch<DirectoryStore>().currentDir;

    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(
              left: 8,
              right: 8,
              bottom: 8,
            ),
            child: Text(
              title,
              style: const TextStyle(
                color: CupertinoColors.inactiveGray,
                fontSize: 12,
              ),
            ),
          ),
          ...items.keys
              .map(
                (d) => SidebarGroupItem(
                  name: d,
                  item: items[d]!,
                  selectedItem: currentItem,
                ),
              )
              .toList()
        ],
      ),
    );
  }
}
