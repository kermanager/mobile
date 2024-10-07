import 'package:flutter/material.dart';
import 'package:kermanager/theme/theme_color.dart';
import 'package:kermanager/theme/theme_font.dart';
import 'package:kermanager/theme/theme_size.dart';

class IconBox extends StatefulWidget {
  final IconData icon;

  const IconBox({
    super.key,
    required this.icon,
  });

  @override
  State<IconBox> createState() => _IconBoxState();
}

class _IconBoxState extends State<IconBox> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: ThemeColor.gray100,
        border: Border.all(color: ThemeColor.gray200),
        borderRadius: BorderRadius.circular(ThemeSize.s12),
      ),
      padding: const EdgeInsets.all(ThemeSize.s12),
      child: Icon(
        widget.icon,
        color: ThemeColor.primary,
        size: ThemeFontSize.s24,
      ),
    );
  }
}
