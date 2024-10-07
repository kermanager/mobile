import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:kermanager/theme/theme_color.dart';
import 'package:kermanager/theme/theme_font.dart';
import 'package:kermanager/theme/theme_size.dart';
import 'package:kermanager/widgets/form_input.dart';

class NumberFormInput extends StatefulWidget {
  final String? defaultValue;
  final String hintText;
  final IconData? icon;
  final Widget? suffix;
  final TextEditingController controller;
  final String unit;

  const NumberFormInput({
    super.key,
    required this.hintText,
    required this.controller,
    this.icon,
    this.suffix,
    this.defaultValue,
    required this.unit,
  });

  @override
  State<NumberFormInput> createState() => _NumberFormInputState();
}

class _NumberFormInputState extends State<NumberFormInput> {
  @override
  Widget build(BuildContext context) {
    return FormInput(
      hintText: widget.hintText,
      keyboardType: TextInputType.number,
      controller: widget.controller,
      icon: widget.icon,
      suffix: Padding(
        padding: const EdgeInsets.symmetric(vertical: ThemeSize.s12),
        child: Text(
          widget.unit,
          style: const TextStyle(
            fontSize: ThemeFontSize.s16,
            fontWeight: ThemeFontWeight.semiBold,
            color: ThemeColor.primary,
          ),
        ),
      ),
      defaultValue: widget.defaultValue,
      inputFormatters: [
        FilteringTextInputFormatter.digitsOnly,
      ],
    );
  }
}
