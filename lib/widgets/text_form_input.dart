import 'package:flutter/material.dart';
import 'package:kermanager/widgets/form_input.dart';

class TextFormInput extends StatefulWidget {
  final String? defaultValue;
  final String hintText;
  final TextInputType keyboardType;
  final IconData? icon;
  final Widget? suffix;
  final TextEditingController controller;

  const TextFormInput({
    super.key,
    required this.hintText,
    required this.keyboardType,
    required this.controller,
    this.icon,
    this.suffix,
    this.defaultValue,
  });

  @override
  State<TextFormInput> createState() => _TextFormInputState();
}

class _TextFormInputState extends State<TextFormInput> {
  @override
  Widget build(BuildContext context) {
    return FormInput(
      hintText: widget.hintText,
      keyboardType: widget.keyboardType,
      controller: widget.controller,
      icon: widget.icon,
      suffix: widget.suffix,
      defaultValue: widget.defaultValue,
    );
  }
}
