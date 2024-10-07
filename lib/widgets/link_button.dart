import 'package:flutter/material.dart';
import 'package:kermanager/theme/theme_color.dart';
import 'package:kermanager/theme/theme_font.dart';

class LinkButton extends StatefulWidget {
  final String label;
  final VoidCallback onTap;

  const LinkButton({
    super.key,
    required this.label,
    required this.onTap,
  });

  @override
  State<LinkButton> createState() => _LinkButtonState();
}

class _LinkButtonState extends State<LinkButton> {
  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: widget.onTap,
      style: ButtonStyle(
        minimumSize: WidgetStateProperty.all(Size.zero),
        padding: WidgetStateProperty.all(EdgeInsets.zero),
        tapTargetSize: MaterialTapTargetSize.shrinkWrap,
      ),
      child: Text(
        widget.label,
        style: const TextStyle(
          fontSize: ThemeFontSize.s16,
          fontWeight: ThemeFontWeight.semiBold,
          color: ThemeColor.primary,
        ),
      ),
    );
  }
}
