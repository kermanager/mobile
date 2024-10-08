import 'package:flutter/material.dart';
import 'package:kermanager/data/stand_list_response.dart';
import 'package:kermanager/theme/theme_color.dart';
import 'package:kermanager/theme/theme_font.dart';
import 'package:kermanager/theme/theme_size.dart';
import 'package:kermanager/widgets/icon_box.dart';

class StandCard extends StatefulWidget {
  final StandListItem stand;
  final VoidCallback onTap;

  const StandCard({
    super.key,
    required this.stand,
    required this.onTap,
  });

  @override
  State<StandCard> createState() => _StandCardState();
}

class _StandCardState extends State<StandCard> {
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
              IconBox(
                icon: widget.stand.type == "CONSUMPTION"
                    ? Icons.fastfood
                    : Icons.sports_esports,
                isLarge: true,
              ),
              const SizedBox(width: ThemeSize.s16),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.stand.name,
                    style: const TextStyle(
                      fontSize: ThemeFontSize.s16,
                      fontWeight: ThemeFontWeight.medium,
                      color: ThemeColor.black,
                    ),
                  ),
                  const SizedBox(height: ThemeSize.s4),
                  Row(
                    children: [
                      Text(
                        "${widget.stand.price.toString()} jeton • ${widget.stand.stock.toString()} pièce",
                        style: const TextStyle(
                          fontSize: ThemeFontSize.s12,
                          fontWeight: ThemeFontWeight.regular,
                          color: ThemeColor.gray400,
                        ),
                      ),
                    ],
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
