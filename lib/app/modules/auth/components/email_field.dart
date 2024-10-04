import 'package:flutter/material.dart';

import '../../../core/utils/validator.dart';

class EmailField extends StatelessWidget {
  const EmailField({super.key, required this.controller, this.onSubmitted});

  final TextEditingController controller;
  final void Function(String?)? onSubmitted;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      autocorrect: false,
      keyboardType: TextInputType.emailAddress,
      decoration: const InputDecoration(
        hintText: 'Email',
        prefixIcon: Icon(Icons.mail_rounded),
        border: OutlineInputBorder(borderSide: BorderSide.none),
        filled: true,
      ),
      textInputAction: TextInputAction.next,
      validator: Validator.requiredField,
      onFieldSubmitted: onSubmitted,
    );
  }
}
