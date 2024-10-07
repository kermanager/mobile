import 'package:flutter/material.dart';
import 'package:kermanager/widgets/form_input.dart';

class TextAreaFormInput extends StatefulWidget {
  final String? defaultValue;
  final String hintText;
  final TextEditingController controller;
  final int? maxLines;

  const TextAreaFormInput({
    super.key,
    required this.hintText,
    required this.controller,
    this.defaultValue,
    this.maxLines,
  });

  @override
  State<TextAreaFormInput> createState() => _TextAreaFormInputState();
}

class _TextAreaFormInputState extends State<TextAreaFormInput> {
  @override
  Widget build(BuildContext context) {
    return FormInput(
      hintText: widget.hintText,
      keyboardType: TextInputType.multiline,
      controller: widget.controller,
      isObscureText: false,
      defaultValue: widget.defaultValue,
      maxLines: widget.maxLines ?? 4,
    );
  }
}
