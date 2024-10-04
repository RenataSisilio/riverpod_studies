import 'package:flutter/material.dart';

import '../../../core/utils/validator.dart';

class UsernameField extends StatelessWidget {
  const UsernameField({super.key, required this.controller});

  final TextEditingController controller;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      keyboardType: TextInputType.name,
      textCapitalization: TextCapitalization.words,
      decoration: const InputDecoration(
        hintText: 'Name',
        prefixIcon: Icon(Icons.person_rounded),
        border: OutlineInputBorder(borderSide: BorderSide.none),
        filled: true,
      ),
      textInputAction: TextInputAction.next,
      validator: Validator.requiredField,
    );
  }
}
