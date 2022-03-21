import 'package:flutter/material.dart';

import '../constants/colors.dart';

void showCustomDialog(BuildContext context, Widget content) {
  showDialog(
    context: context,
    barrierDismissible: true,
    barrierColor: dark2.withOpacity(.9),
    builder: (_) => content,
  );
}
