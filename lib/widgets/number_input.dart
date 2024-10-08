import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class NumberInput extends StatefulWidget {
  final String? hintText;
  final String? defaultValue;
  final TextEditingController controller;

  const NumberInput({
    super.key,
    this.hintText,
    this.defaultValue,
    required this.controller,
  });

  @override
  State<NumberInput> createState() => _NumberInputState();
}

class _NumberInputState extends State<NumberInput> {
  @override
  Widget build(BuildContext context) {
    if (widget.defaultValue != null && widget.controller.text.isEmpty) {
      widget.controller.text = widget.defaultValue!;
    }

    return TextField(
      controller: widget.controller,
      decoration: InputDecoration(
        hintText: widget.hintText ?? '',
      ),
      keyboardType: TextInputType.number,
      inputFormatters: [
        FilteringTextInputFormatter.digitsOnly,
      ],
    );
  }
}
