import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:kermanager/theme/theme_color.dart';
import 'package:kermanager/theme/theme_font.dart';
import 'package:kermanager/theme/theme_size.dart';
import 'package:kermanager/widgets/form_input.dart';

class CreditFormInput extends StatefulWidget {
  final String? defaultValue;
  final String hintText;
  final IconData? icon;
  final Widget? suffix;
  final TextEditingController controller;

  const CreditFormInput({
    super.key,
    required this.hintText,
    required this.controller,
    this.icon,
    this.suffix,
    this.defaultValue,
  });

  @override
  State<CreditFormInput> createState() => _CreditFormInputState();
}

class _CreditFormInputState extends State<CreditFormInput> {
  @override
  Widget build(BuildContext context) {
    return FormInput(
      hintText: widget.hintText,
      keyboardType: TextInputType.number,
      controller: widget.controller,
      icon: widget.icon,
      suffix: const Padding(
        padding: EdgeInsets.symmetric(vertical: ThemeSize.s12),
        child: Text(
          'Jetons',
          style: TextStyle(
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
