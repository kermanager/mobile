import 'package:flutter/material.dart';
import 'package:kermanager/data/tombola_list_response.dart';
import 'package:kermanager/theme/theme_color.dart';
import 'package:kermanager/theme/theme_font.dart';
import 'package:kermanager/theme/theme_size.dart';
import 'package:kermanager/widgets/icon_box.dart';
import 'package:kermanager/widgets/status_label.dart';

class TombolaCard extends StatefulWidget {
  final TombolaListItem tombola;
  final VoidCallback onTap;

  const TombolaCard({
    super.key,
    required this.tombola,
    required this.onTap,
  });

  @override
  State<TombolaCard> createState() => _TombolaCardState();
}

class _TombolaCardState extends State<TombolaCard> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        InkWell(
          onTap: widget.onTap,
          customBorder: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(ThemeSize.s12),
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const IconBox(
                icon: Icons.casino,
                isLarge: true,
              ),
              const SizedBox(width: ThemeSize.s16),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.tombola.name,
                    style: const TextStyle(
                      fontSize: ThemeFontSize.s16,
                      fontWeight: ThemeFontWeight.medium,
                      color: ThemeColor.black,
                    ),
                  ),
                  const SizedBox(height: ThemeSize.s4),
                  StatusLabel(
                    status: widget.tombola.status,
                    isSmall: true,
                  ),
                ],
              ),
              const Spacer(),
              const Icon(
                Icons.arrow_forward_ios,
                size: ThemeSize.s16,
                color: ThemeColor.gray300,
              ),
            ],
          ),
        ),
        const SizedBox(height: ThemeSize.s16),
      ],
    );
  }
}
