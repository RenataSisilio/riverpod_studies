import 'package:flutter/material.dart';

class DescriptionField extends StatelessWidget {
  const DescriptionField({
    super.key,
    required this.description,
    required this.onSubmitted,
  });

  final TextEditingController description;
  final void Function(String) onSubmitted;

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: description,
      decoration: const InputDecoration(
        border: InputBorder.none,
        hintText: 'Description',
      ),
      textCapitalization: TextCapitalization.sentences,
      onSubmitted: onSubmitted,
    );
  }
}
