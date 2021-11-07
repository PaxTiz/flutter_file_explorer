import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../constants.dart';
import '../../stores/directory_store.dart';

class CreateDirectoryModal extends StatefulWidget {
  @override
  createState() => _CreateDirectoryModal();
}

class _CreateDirectoryModal extends State<CreateDirectoryModal> {
  final _controller = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  String? _error;

  void _createDirectory(BuildContext context, Directory currentDir) {
    if (_formKey.currentState!.validate()) {
      final fullName = currentDir.path + '/${_controller.text}';
      try {
        context.read<DirectoryStore>().createDirectory(fullName);
        Navigator.of(context).pop();
      } on FileSystemException catch (e) {
        setState(() => _error = e.message);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final _currentDir = context.read<DirectoryStore>().currentDir;

    return Center(
      child: Container(
        width: MediaQuery.of(context).size.width / 3,
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Theme.of(context).backgroundColor,
          borderRadius: BorderRadius.circular(8),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Create a directory in ${_currentDir.path}',
              style: Theme.of(context).textTheme.headline6!.copyWith(
                    fontSize: 15,
                  ),
            ),
            verticalSpacing,
            if (_error != null)
              Text(
                _error!,
                style: const TextStyle(color: CupertinoColors.destructiveRed),
              ),
            if (_error != null) verticalSpacing,
            Form(
              key: _formKey,
              child: CupertinoTextFormFieldRow(
                padding: EdgeInsets.zero,
                controller: _controller,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  color: Theme.of(context).scaffoldBackgroundColor,
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'The directory name cannot be empty';
                  }
                },
              ),
            ),
            verticalSpacing,
            Row(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                const Spacer(),
                TextButton.icon(
                  onPressed: () => Navigator.of(context).pop(),
                  icon: const Icon(
                    CupertinoIcons.xmark,
                    color: CupertinoColors.destructiveRed,
                  ),
                  label: const Text(
                    'Cancel',
                    style: TextStyle(
                      color: CupertinoColors.destructiveRed,
                    ),
                  ),
                  style: TextButton.styleFrom(
                    primary: CupertinoColors.destructiveRed,
                  ),
                ),
                horizontalSpacing,
                TextButton.icon(
                  onPressed: () => _createDirectory(context, _currentDir),
                  icon: const Icon(CupertinoIcons.plus),
                  label: const Text('Create'),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
