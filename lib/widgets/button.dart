import 'package:flutter/material.dart';
import 'package:kermanager/theme/theme_color.dart';
import 'package:kermanager/theme/theme_font.dart';
import 'package:kermanager/theme/theme_size.dart';

class Button extends StatefulWidget {
  final String label;
  final VoidCallback onTap;
  final bool? isDisabled;

  const Button({
    super.key,
    required this.label,
    required this.onTap,
    this.isDisabled,
  });

  @override
  State<Button> createState() => _ButtonState();
}

class _ButtonState extends State<Button> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        onPressed: (widget.isDisabled ?? false) ? null : widget.onTap,
        style: ButtonStyle(
          padding: WidgetStateProperty.all<EdgeInsetsGeometry>(
            const EdgeInsets.symmetric(
              vertical: ThemeSize.s18,
            ),
          ),
          backgroundColor: WidgetStateProperty.resolveWith<Color>((states) {
            if (states.contains(WidgetState.pressed)) {
              return ThemeColor.secondary;
            }
            if (widget.isDisabled ?? false) {
              return ThemeColor.gray300;
            }
            return ThemeColor.primary;
          }),
          shape: WidgetStateProperty.all<RoundedRectangleBorder>(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(ThemeSize.s12),
            ),
          ),
        ),
        child: Text(
          widget.label,
          style: const TextStyle(
            fontSize: ThemeFontSize.s16,
            fontWeight: ThemeFontWeight.semiBold,
            color: ThemeColor.white,
          ),
        ),
      ),
    );
  }
}
