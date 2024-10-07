import 'package:flutter/material.dart';
import 'package:kermanager/theme/theme_color.dart';
import 'package:kermanager/theme/theme_font.dart';
import 'package:kermanager/theme/theme_size.dart';

class Avatar extends StatefulWidget {
  const Avatar({super.key});

  @override
  State<Avatar> createState() => _AvatarState();
}

class _AvatarState extends State<Avatar> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: ThemeColor.gray100,
        border: Border.all(color: ThemeColor.gray200),
        borderRadius: BorderRadius.circular(12),
      ),
      padding: const EdgeInsets.all(ThemeSize.s16),
      child: const Icon(
        Icons.face,
        color: ThemeColor.primary,
        size: ThemeFontSize.s32,
      ),
    );
  }
}
