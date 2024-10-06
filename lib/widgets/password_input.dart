import 'package:flutter/material.dart';

class PasswordInput extends StatefulWidget {
  final String? hintText;
  final TextEditingController controller;

  const PasswordInput({
    super.key,
    this.hintText,
    required this.controller,
  });

  @override
  State<PasswordInput> createState() => _PasswordInputState();
}

class _PasswordInputState extends State<PasswordInput> {
  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: widget.controller,
      decoration: InputDecoration(
        hintText: widget.hintText ?? '',
      ),
      obscureText: true,
      keyboardType: TextInputType.visiblePassword,
    );
  }
}
