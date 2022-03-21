import 'package:flutter/material.dart';

import '../../core/constants/colors.dart';

class CustomInput extends StatelessWidget {
  final TextEditingController controller;
  final String? error;
  final String? Function(String?) validator;

  const CustomInput({
    required this.controller,
    required this.error,
    required this.validator,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      decoration: InputDecoration(
        filled: true,
        fillColor: dark2,
        errorText: error,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: BorderSide.none,
        ),
      ),
      style: const TextStyle(color: gray2),
      validator: validator,
    );
  }
}
