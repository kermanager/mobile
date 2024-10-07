import 'package:flutter/material.dart';
import 'package:kermanager/theme/theme_color.dart';
import 'package:kermanager/theme/theme_font.dart';
import 'package:kermanager/theme/theme_size.dart';

class StatusLabel extends StatefulWidget {
  final String status;

  const StatusLabel({
    super.key,
    required this.status,
  });

  @override
  State<StatusLabel> createState() => _StatusLabelState();
}

class _StatusLabelState extends State<StatusLabel> {
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          width: ThemeSize.s18,
          height: ThemeSize.s18,
          decoration: BoxDecoration(
            color: widget.status == 'STARTED'
                ? ThemeColor.primary
                : ThemeColor.red200,
            borderRadius: BorderRadius.circular(ThemeSize.s18),
          ),
        ),
        const SizedBox(width: ThemeSize.s8),
        Text(
          widget.status == 'STARTED' ? 'En cours' : 'Terminée',
          style: const TextStyle(
            fontSize: ThemeFontSize.s14,
            fontWeight: ThemeFontWeight.regular,
            color: ThemeColor.gray400,
          ),
        )
      ],
    );
  }
}
