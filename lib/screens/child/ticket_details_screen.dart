import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:kermanager/api/api_response.dart';
import 'package:kermanager/data/ticket_details_response.dart';
import 'package:kermanager/services/ticket_service.dart';
import 'package:kermanager/theme/theme_color.dart';
import 'package:kermanager/theme/theme_font.dart';
import 'package:kermanager/theme/theme_size.dart';
import 'package:kermanager/widgets/details_future_builder.dart';
import 'package:kermanager/widgets/screen_special.dart';
import 'package:kermanager/widgets/ticket_clipper.dart';

class TicketDetailsScreen extends StatefulWidget {
  final int ticketId;

  const TicketDetailsScreen({
    super.key,
    required this.ticketId,
  });

  @override
  State<TicketDetailsScreen> createState() => _TicketDetailsScreenState();
}

class _TicketDetailsScreenState extends State<TicketDetailsScreen> {
  final TicketService _ticketService = TicketService();

  Future<TicketDetailsResponse> _get() async {
    ApiResponse<TicketDetailsResponse> response = await _ticketService.details(
      ticketId: widget.ticketId,
    );
    if (response.error != null) {
      throw Exception(response.error!);
    }
    return response.data!;
  }

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double safeAreaHeight = MediaQuery.paddingOf(context).top;
    double appBarHeight = ThemeSize.s56;
    double bottomBarHeight = ThemeSize.s80;
    double paddingsHeight = ThemeSize.s16 * 2;
    double safeHeight = screenHeight -
        appBarHeight -
        bottomBarHeight -
        paddingsHeight -
        safeAreaHeight;

    return ScreenSpecial(
      appBar: AppBar(),
      children: [
        DetailsFutureBuilder<TicketDetailsResponse>(
          future: _get,
          builder: (context, data) {
            return ClipPath(
              clipper: TicketClipper(),
              child: Container(
                color: ThemeColor.primary,
                height: safeHeight,
                width: double.infinity,
                padding: const EdgeInsets.all(ThemeSize.s24),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          data.user.name,
                          style: const TextStyle(
                            fontSize: ThemeSize.s32,
                            fontWeight: FontWeight.bold,
                            color: ThemeColor.white,
                          ),
                        ),
                        data.isWinner
                            ? const Icon(
                                Icons.emoji_events,
                                size: 40,
                                color: Color(0xFFffeaa7),
                              )
                            : const SizedBox(),
                      ],
                    ),
                    const SizedBox(height: ThemeSize.s8),
                    Text(
                      "${data.tombola.price.toString()}.00 €",
                      style: const TextStyle(
                        fontSize: ThemeSize.s28,
                        fontWeight: ThemeFontWeight.semiBold,
                        color: ThemeColor.white,
                      ),
                    ),
                    const SizedBox(height: ThemeSize.s16),
                    Text(
                      "Kermesse : ${data.kermesse.name}",
                      style: const TextStyle(
                        fontSize: ThemeSize.s20,
                        fontWeight: ThemeFontWeight.medium,
                        color: ThemeColor.white,
                      ),
                    ),
                    const SizedBox(height: ThemeSize.s2),
                    Text(
                      "Tombola : ${data.tombola.name}",
                      style: const TextStyle(
                        fontSize: ThemeSize.s20,
                        fontWeight: ThemeFontWeight.medium,
                        color: ThemeColor.white,
                      ),
                    ),
                    const Spacer(),
                    SizedBox(
                      width: double.infinity,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SvgPicture.asset(
                            'assets/images/qr-code.svg',
                            semanticsLabel: 'QR Code',
                            width: 300,
                            height: 300,
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ],
    );
  }
}
