import 'package:flutter/material.dart';
import 'package:kermanager/theme/theme_color.dart';
import 'package:kermanager/theme/theme_font.dart';
import 'package:kermanager/theme/theme_size.dart';

class IconBox extends StatefulWidget {
  final IconData icon;
  final bool? isLarge;

  const IconBox({
    super.key,
    required this.icon,
    this.isLarge = false,
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
      padding: EdgeInsets.all(
        widget.isLarge == true ? ThemeSize.s16 : ThemeSize.s12,
      ),
      child: Icon(
        widget.icon,
        color: ThemeColor.primary,
        size: ThemeFontSize.s24,
      ),
    );
  }
}
