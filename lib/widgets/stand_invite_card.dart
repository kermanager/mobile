import 'package:flutter/material.dart';
import 'package:kermanager/data/stand_list_response.dart';
import 'package:kermanager/theme/theme_color.dart';
import 'package:kermanager/theme/theme_font.dart';
import 'package:kermanager/theme/theme_size.dart';
import 'package:kermanager/widgets/button_icon.dart';
import 'package:kermanager/widgets/icon_box.dart';

class StandInviteCard extends StatefulWidget {
  final StandListItem stand;
  final VoidCallback onTap;

  const StandInviteCard({
    super.key,
    required this.stand,
    required this.onTap,
  });

  @override
  State<StandInviteCard> createState() => _StandInviteCardState();
}

class _StandInviteCardState extends State<StandInviteCard> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            IconBox(
              icon: widget.stand.type == "CONSUMPTION"
                  ? Icons.fastfood
                  : Icons.gamepad,
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
            ButtonIcon(
              icon: Icons.send,
              onTap: widget.onTap,
            ),
          ],
        ),
        const SizedBox(height: ThemeSize.s16),
      ],
    );
  }
}
