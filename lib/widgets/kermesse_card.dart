import 'package:flutter/material.dart';
import 'package:kermanager/data/kermesse_list_response.dart';
import 'package:kermanager/theme/theme_color.dart';
import 'package:kermanager/theme/theme_font.dart';
import 'package:kermanager/theme/theme_size.dart';
import 'package:kermanager/widgets/icon_box.dart';
import 'package:kermanager/widgets/status_label.dart';

class KermesseCard extends StatefulWidget {
  final KermesseListItem kermesse;
  final VoidCallback onTap;

  const KermesseCard({
    super.key,
    required this.kermesse,
    required this.onTap,
  });

  @override
  State<KermesseCard> createState() => _KermesseCardState();
}

class _KermesseCardState extends State<KermesseCard> {
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
                icon: Icons.celebration,
                isLarge: true,
              ),
              const SizedBox(width: ThemeSize.s16),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.kermesse.name,
                    style: const TextStyle(
                      fontSize: ThemeFontSize.s16,
                      fontWeight: ThemeFontWeight.medium,
                      color: ThemeColor.black,
                    ),
                  ),
                  const SizedBox(height: ThemeSize.s4),
                  StatusLabel(
                    status: widget.kermesse.status,
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
