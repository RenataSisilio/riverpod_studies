import 'package:flutter/material.dart';

import '../../../core/utils/validator.dart';

class PasswordField extends StatelessWidget {
  const PasswordField({
    super.key,
    required this.controller,
    this.onSubmitted,
    this.originalValueToMatch,
  });

  factory PasswordField.confirm({
    Key? key,
    VoidCallback? onSubmitted,
    required TextEditingController originalValueToMatch,
  }) =>
      PasswordField(
        key: key,
        controller: TextEditingController(),
        onSubmitted: onSubmitted,
        originalValueToMatch: originalValueToMatch,
      );

  final TextEditingController controller;
  final VoidCallback? onSubmitted;

  final TextEditingController? originalValueToMatch;

  @override
  Widget build(BuildContext context) {
    final passwordVisibility = ValueNotifier(false);
    return ValueListenableBuilder(
      valueListenable: passwordVisibility,
      builder: (context, value, child) {
        return TextFormField(
          controller: controller,
          obscureText: !value,
          decoration: InputDecoration(
            hintText:
                originalValueToMatch == null ? 'Password' : 'Confirm password',
            prefixIcon: const Icon(Icons.lock_rounded),
            suffixIcon: IconButton(
              onPressed: () => passwordVisibility.value = !value,
              icon: Icon(value
                  ? Icons.visibility_rounded
                  : Icons.visibility_off_rounded),
            ),
            border: const OutlineInputBorder(borderSide: BorderSide.none),
            filled: true,
          ),
          textInputAction:
              onSubmitted == null ? TextInputAction.next : TextInputAction.done,
          validator: originalValueToMatch == null
              ? Validator.requiredField
              : (value) =>
                  Validator.matchPassword(value, originalValueToMatch!.text),
          onFieldSubmitted: (_) {
            onSubmitted == null ? null : onSubmitted!();
          },
        );
      },
    );
  }
}
