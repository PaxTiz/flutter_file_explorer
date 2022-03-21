import 'dart:io';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../constants.dart';
import '../../core/constants/colors.dart';
import '../../stores/directory_store.dart';
import '../modals/custom_modal.dart';
import '../shared/custom_button.dart';
import '../shared/custom_input.dart';

class CreateFileModal extends StatefulWidget {
  @override
  createState() => _CreateFileModal();
}

class _CreateFileModal extends State<CreateFileModal> {
  final _controller = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  String? _error;

  void _createFile(BuildContext context, Directory currentDir) {
    if (_formKey.currentState!.validate()) {
      final fullName = currentDir.path + '/${_controller.text}';
      try {
        context.read<DirectoryStore>().createFile(fullName);
        Navigator.of(context).pop();
      } on FileSystemException catch (e) {
        setState(() => _error = e.message);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final _currentDir = context.read<DirectoryStore>().currentDir;

    return CustomModal(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Create a file in ${_currentDir.path}',
            style: Theme.of(context).textTheme.headline6!.copyWith(
                  fontSize: 15,
                ),
          ),
          verticalSpacing,
          Material(
            color: dark0,
            child: Form(
              key: _formKey,
              child: CustomInput(
                controller: _controller,
                error: _error,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'The file name cannot be empty';
                  }
                  return null;
                },
              ),
            ),
          ),
          verticalSpacing,
          Row(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              const Spacer(),
              ErrorButton(
                onPressed: () => Navigator.of(context).pop(),
                text: 'Cancel',
              ),
              horizontalSpacing,
              SuccessButton(
                onPressed: () => _createFile(context, _currentDir),
                text: 'Create',
              ),
            ],
          ),
        ],
      ),
    );
  }
}
