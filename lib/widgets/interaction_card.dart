import 'package:flutter/material.dart';
import 'package:kermanager/data/interaction_list_response.dart';
import 'package:kermanager/theme/theme_color.dart';
import 'package:kermanager/theme/theme_font.dart';
import 'package:kermanager/theme/theme_size.dart';
import 'package:kermanager/widgets/icon_box.dart';

class InteractionCard extends StatefulWidget {
  final InteractionListItem interaction;
  final VoidCallback onTap;
  final bool? isMinus;

  const InteractionCard({
    super.key,
    required this.interaction,
    required this.onTap,
    this.isMinus = false,
  });

  @override
  State<InteractionCard> createState() => _InteractionCardState();
}

class _InteractionCardState extends State<InteractionCard> {
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
                icon: widget.interaction.type == "CONSUMPTION"
                    ? Icons.fastfood
                    : Icons.sports_esports,
                isLarge: true,
              ),
              const SizedBox(width: ThemeSize.s16),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.interaction.user.name,
                    style: const TextStyle(
                      fontSize: ThemeFontSize.s16,
                      fontWeight: ThemeFontWeight.medium,
                      color: ThemeColor.black,
                    ),
                  ),
                  const SizedBox(height: ThemeSize.s4),
                  Text(
                    widget.interaction.formattedCreatedAt,
                    style: const TextStyle(
                      fontSize: ThemeFontSize.s12,
                      fontWeight: ThemeFontWeight.regular,
                      color: ThemeColor.gray400,
                    ),
                  ),
                ],
              ),
              const Spacer(),
              Text(
                "${widget.isMinus! ? "-" : "+"} ${widget.interaction.credit.toString()}",
                style: TextStyle(
                  fontSize: ThemeFontSize.s18,
                  fontWeight: ThemeFontWeight.semiBold,
                  color:
                      widget.isMinus! ? ThemeColor.red200 : ThemeColor.primary,
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: ThemeSize.s16),
      ],
    );
  }
}
