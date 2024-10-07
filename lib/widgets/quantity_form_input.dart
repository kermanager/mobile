import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:kermanager/theme/theme_color.dart';
import 'package:kermanager/theme/theme_font.dart';
import 'package:kermanager/theme/theme_size.dart';

class QuantityFormInput extends StatefulWidget {
  final int defaultValue;
  final TextEditingController controller;

  const QuantityFormInput({
    super.key,
    required this.controller,
    required this.defaultValue,
  });

  @override
  State<QuantityFormInput> createState() => _QuantityFormInputState();
}

class _QuantityFormInputState extends State<QuantityFormInput> {
  void _increment() {
    final value = int.parse(widget.controller.text);
    widget.controller.text = (value + 1).toString();
  }

  void _decrement() {
    final value = int.parse(widget.controller.text);
    if (value > 1) {
      widget.controller.text = (value - 1).toString();
    }
  }

  @override
  Widget build(BuildContext context) {
    if (widget.controller.text.isEmpty) {
      widget.controller.text = widget.defaultValue.toString();
    }

    return TextFormField(
      controller: widget.controller,
      textAlign: TextAlign.center,
      readOnly: true,
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
        hintStyle: const TextStyle(
          fontSize: ThemeFontSize.s16,
          fontWeight: ThemeFontWeight.medium,
          color: ThemeColor.gray300,
        ),
        prefixIcon: GestureDetector(
          onTap: _decrement,
          child: const Padding(
            padding: EdgeInsets.only(
              left: ThemeSize.s16,
              right: ThemeSize.s16,
            ),
            child: Icon(
              Icons.remove,
              color: ThemeColor.gray400,
            ),
          ),
        ),
        suffixIcon: GestureDetector(
          onTap: _increment,
          child: const Padding(
            padding: EdgeInsets.only(
              left: ThemeSize.s16,
              right: ThemeSize.s16,
            ),
            child: Icon(
              Icons.add,
              color: ThemeColor.gray400,
            ),
          ),
        ),
      ),
      keyboardType: TextInputType.number,
      inputFormatters: [
        FilteringTextInputFormatter.digitsOnly,
      ],
    );
  }
}
