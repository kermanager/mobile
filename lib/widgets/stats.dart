import 'package:flutter/material.dart';
import 'package:kermanager/theme/theme_color.dart';
import 'package:kermanager/theme/theme_font.dart';
import 'package:kermanager/theme/theme_size.dart';

class Stats extends StatefulWidget {
  final String label;
  final int value;

  const Stats({
    super.key,
    required this.label,
    required this.value,
  });

  @override
  State<Stats> createState() => _StatsState();
}

class _StatsState extends State<Stats> {
  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(ThemeSize.s12),
      child: Container(
        color: ThemeColor.gray100,
        padding: const EdgeInsets.symmetric(
          horizontal: ThemeSize.s16,
          vertical: ThemeSize.s12,
        ),
        child: Column(
          children: [
            Text(
              widget.value.toString(),
              style: const TextStyle(
                fontSize: ThemeFontSize.s24,
                fontWeight: FontWeight.bold,
                color: ThemeColor.black,
              ),
            ),
            const SizedBox(height: ThemeSize.s4),
            Text(
              widget.label,
              style: const TextStyle(
                fontSize: ThemeFontSize.s12,
                fontWeight: FontWeight.normal,
                color: ThemeColor.gray400,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
