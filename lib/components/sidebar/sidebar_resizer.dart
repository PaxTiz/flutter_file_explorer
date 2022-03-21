import 'package:flutter/material.dart';

class SidebarResizer extends StatelessWidget {
  final ValueSetter<double> onResize;

  const SidebarResizer({required this.onResize});

  @override
  Widget build(BuildContext context) {
    const minWidth = 150;
    const maxWidth = 300;

    return MouseRegion(
      cursor: SystemMouseCursors.resizeColumn,
      child: GestureDetector(
        onHorizontalDragUpdate: (details) {
          final w = details.globalPosition.dx;
          if (w >= minWidth && w <= maxWidth) {
            onResize(w);
          }
        },
        child: Container(
          width: 3,
          color: Theme.of(context).backgroundColor,
        ),
      ),
    );
  }
}
