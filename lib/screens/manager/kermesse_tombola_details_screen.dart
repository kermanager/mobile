import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:kermanager/api/api_response.dart';
import 'package:kermanager/data/tombola_details_response.dart';
import 'package:kermanager/router/manager/routes.dart';
import 'package:kermanager/services/tombola_service.dart';
import 'package:kermanager/theme/theme_color.dart';
import 'package:kermanager/theme/theme_font.dart';
import 'package:kermanager/theme/theme_size.dart';
import 'package:kermanager/widgets/button.dart';
import 'package:kermanager/widgets/details_future_builder.dart';
import 'package:kermanager/widgets/screen.dart';
import 'package:kermanager/widgets/status_label.dart';

class KermesseTombolaDetailsScreen extends StatefulWidget {
  final int kermesseId;
  final int tombolaId;

  const KermesseTombolaDetailsScreen({
    super.key,
    required this.kermesseId,
    required this.tombolaId,
  });

  @override
  State<KermesseTombolaDetailsScreen> createState() =>
      _KermesseTombolaDetailsScreenState();
}

class _KermesseTombolaDetailsScreenState
    extends State<KermesseTombolaDetailsScreen> {
  final TombolaService _tombolaService = TombolaService();

  Future<TombolaDetailsResponse> _get() async {
    ApiResponse<TombolaDetailsResponse> response =
        await _tombolaService.details(
      tombolaId: widget.tombolaId,
    );
    if (response.error != null) {
      throw Exception(response.errorMessage);
    }
    return response.data!;
  }

  Future<void> _end() async {
    ApiResponse<Null> response =
        await _tombolaService.end(tombolaId: widget.tombolaId);
    if (response.error != null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(response.errorMessage),
        ),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Tombola ended successfully'),
        ),
      );
      _refresh();
    }
  }

  void _refresh() {
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Screen(
      appBar: AppBar(
        actions: [
          IconButton(
            onPressed: () {
              context.push(
                ManagerRoutes.kermesseTombolaEdit,
                extra: {
                  "kermesseId": widget.kermesseId,
                  "tombolaId": widget.tombolaId,
                },
              );
            },
            icon: const Icon(Icons.edit),
          ),
        ],
      ),
      children: [
        DetailsFutureBuilder<TombolaDetailsResponse>(
          future: _get,
          builder: (context, data) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  data.name,
                  style: const TextStyle(
                    fontSize: ThemeSize.s24,
                    fontWeight: ThemeFontWeight.medium,
                    color: ThemeColor.black,
                  ),
                ),
                const SizedBox(height: ThemeSize.s16),
                StatusLabel(status: data.status),
                const SizedBox(height: ThemeSize.s16),
                Row(
                  children: [
                    const Text(
                      "Récompense:",
                      style: TextStyle(
                        fontSize: ThemeSize.s16,
                        fontWeight: ThemeFontWeight.regular,
                        color: ThemeColor.gray400,
                      ),
                    ),
                    const SizedBox(width: ThemeSize.s8),
                    Text(
                      data.gift,
                      style: const TextStyle(
                        fontSize: ThemeSize.s16,
                        fontWeight: ThemeFontWeight.medium,
                        color: ThemeColor.black,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: ThemeSize.s16),
                Row(
                  children: [
                    const Text(
                      "Prix du ticket:",
                      style: TextStyle(
                        fontSize: ThemeSize.s16,
                        fontWeight: ThemeFontWeight.regular,
                        color: ThemeColor.gray400,
                      ),
                    ),
                    const SizedBox(width: ThemeSize.s8),
                    Text(
                      "${data.price.toString()} jetons",
                      style: const TextStyle(
                        fontSize: ThemeSize.s16,
                        fontWeight: ThemeFontWeight.medium,
                        color: ThemeColor.black,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: ThemeSize.s28),
                data.status == "STARTED"
                    ? Button(
                        label: "Terminer la tombola",
                        onTap: _end,
                      )
                    : const SizedBox.shrink(),
              ],
            );
          },
        ),
      ],
    );
  }
}
