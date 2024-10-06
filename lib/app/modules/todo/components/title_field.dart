import 'package:flutter/material.dart';

class TitleField extends StatelessWidget {
  const TitleField({
    super.key,
    required this.title,
    required this.onSubmitted,
  });

  final TextEditingController title;
  final void Function(String) onSubmitted;

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: title,
      style: Theme.of(context).textTheme.titleLarge,
      decoration: const InputDecoration(
        border: InputBorder.none,
        hintText: 'Title',
      ),
      textCapitalization: TextCapitalization.sentences,
      onSubmitted: onSubmitted,
    );
  }
}
