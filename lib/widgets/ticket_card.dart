import 'package:flutter/material.dart';
import 'package:kermanager/data/ticket_list_response.dart';
import 'package:kermanager/theme/theme_color.dart';
import 'package:kermanager/theme/theme_font.dart';
import 'package:kermanager/theme/theme_size.dart';
import 'package:kermanager/widgets/icon_box.dart';

class TicketCard extends StatefulWidget {
  final TicketListItem ticket;
  final VoidCallback onTap;
  final bool? isMinus;

  const TicketCard({
    super.key,
    required this.ticket,
    required this.onTap,
    this.isMinus = false,
  });

  @override
  State<TicketCard> createState() => _TicketCardState();
}

class _TicketCardState extends State<TicketCard> {
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
                icon: Icons.confirmation_num,
                isLarge: true,
              ),
              const SizedBox(width: ThemeSize.s16),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.ticket.user.name,
                    style: const TextStyle(
                      fontSize: ThemeFontSize.s16,
                      fontWeight: ThemeFontWeight.medium,
                      color: ThemeColor.black,
                    ),
                  ),
                  const SizedBox(height: ThemeSize.s4),
                  Text(
                    widget.ticket.formattedCreatedAt,
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
                "${widget.isMinus! ? "-" : "+"} ${widget.ticket.tombola.price.toString()}",
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
