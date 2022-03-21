import 'dart:io';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../core/constants/colors.dart';
import '../../stores/directory_store.dart';

class SidebarGroupItem extends StatelessWidget {
  final String name;
  final FileSystemEntity item;
  final FileSystemEntity selectedItem;

  const SidebarGroupItem({
    required this.name,
    required this.item,
    required this.selectedItem,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () =>
          context.read<DirectoryStore>().currentFolder = Directory(item.path),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 8),
        width: double.infinity,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          color: item.path == selectedItem.path ? dark2 : Colors.transparent,
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 8),
          child: Text(
            name,
            style: TextStyle(
              fontSize: 13,
              color: Theme.of(context).textTheme.headline6!.color,
            ),
          ),
        ),
      ),
    );
  }
}
