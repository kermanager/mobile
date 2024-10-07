import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:kermanager/theme/theme_color.dart';
import 'package:kermanager/theme/theme_font.dart';
import 'package:kermanager/theme/theme_size.dart';

class FormInput extends StatefulWidget {
  final String? defaultValue;
  final String hintText;
  final TextInputType keyboardType;
  final bool? isObscureText;
  final IconData? icon;
  final Widget? suffix;
  final TextEditingController controller;
  final int? maxLines;
  final List<TextInputFormatter>? inputFormatters;

  const FormInput({
    super.key,
    required this.hintText,
    required this.keyboardType,
    this.isObscureText,
    this.icon,
    this.suffix,
    required this.controller,
    this.defaultValue,
    this.maxLines,
    this.inputFormatters,
  });

  @override
  State<FormInput> createState() => _FormInputState();
}

class _FormInputState extends State<FormInput> {
  @override
  Widget build(BuildContext context) {
    if (widget.defaultValue != null && widget.controller.text.isEmpty) {
      widget.controller.text = widget.defaultValue!;
    }

    return TextFormField(
      controller: widget.controller,
      maxLines: widget.maxLines ?? 1,
      style: const TextStyle(
        fontSize: ThemeFontSize.s16,
        fontWeight: ThemeFontWeight.medium,
        color: ThemeColor.black,
      ),
      decoration: InputDecoration(
        contentPadding: const EdgeInsets.symmetric(
          horizontal: ThemeSize.s16,
          vertical: ThemeSize.s20,
        ),
        filled: true,
        fillColor: ThemeColor.gray100,
        enabledBorder: OutlineInputBorder(
          borderSide: const BorderSide(
            color: ThemeColor.gray200,
            width: ThemeSize.s2,
          ),
          borderRadius: BorderRadius.circular(ThemeSize.s12),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: const BorderSide(
            color: ThemeColor.primary,
            width: ThemeSize.s2,
          ),
          borderRadius: BorderRadius.circular(ThemeSize.s12),
        ),
        hintText: widget.hintText,
        hintStyle: const TextStyle(
          fontSize: ThemeFontSize.s16,
          fontWeight: ThemeFontWeight.medium,
          color: ThemeColor.gray300,
        ),
        prefixIcon: widget.icon != null
            ? Padding(
                padding: const EdgeInsets.only(
                  left: ThemeSize.s16,
                  right: ThemeSize.s16,
                ),
                child: Icon(
                  widget.icon,
                  color: ThemeColor.gray400,
                ),
              )
            : null,
        suffixIcon: widget.suffix != null
            ? Padding(
                padding: const EdgeInsets.only(
                  left: ThemeSize.s16,
                  right: ThemeSize.s16,
                ),
                child: widget.suffix,
              )
            : null,
      ),
      obscureText: widget.isObscureText ?? false,
      keyboardType: widget.keyboardType,
      inputFormatters: widget.inputFormatters,
    );
  }
}
