import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../stores/sidebar_store.dart';
import 'sidebar_group_list.dart';

class Sidebar extends StatelessWidget {
  final double width;

  Sidebar({required this.width});

  @override
  Widget build(BuildContext context) {
    final sidebar = context.watch<SidebarStore>().items;

    return Container(
      color: Theme.of(context).backgroundColor,
      padding: const EdgeInsets.only(top: 32),
      width: width,
      child: ListView(
        controller: ScrollController(),
        physics: const BouncingScrollPhysics(),
        padding: const EdgeInsets.all(16),
        children: sidebar.keys
            .map((e) => SidebarGroupList(
                  title: e,
                  items: sidebar[e]!,
                ))
            .toList(),
      ),
    );
  }
}
