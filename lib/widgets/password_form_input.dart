import 'package:flutter/material.dart';
import 'package:kermanager/widgets/form_input.dart';
import 'package:kermanager/widgets/link_button.dart';

class PasswordFormInput extends StatefulWidget {
  final String? defaultValue;
  final String hintText;
  final IconData? icon;
  final TextEditingController controller;
  final String? Function(String?)? validator;

  const PasswordFormInput({
    super.key,
    required this.hintText,
    required this.controller,
    this.icon,
    this.defaultValue,
    this.validator,
  });

  @override
  State<PasswordFormInput> createState() => _PasswordFormInputState();
}

class _PasswordFormInputState extends State<PasswordFormInput> {
  bool isObscureText = true;

  void _toggleObscureText() {
    setState(() {
      isObscureText = !isObscureText;
    });
  }

  @override
  Widget build(BuildContext context) {
    return FormInput(
      validator: widget.validator,
      hintText: widget.hintText,
      keyboardType: TextInputType.visiblePassword,
      controller: widget.controller,
      isObscureText: isObscureText,
      icon: widget.icon,
      suffix: LinkButton(
        label: isObscureText ? 'Afficher' : 'Masquer',
        onTap: _toggleObscureText,
      ),
      defaultValue: widget.defaultValue,
    );
  }
}
