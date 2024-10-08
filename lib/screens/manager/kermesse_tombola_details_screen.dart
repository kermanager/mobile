import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:kermanager/api/api_response.dart';
import 'package:kermanager/data/tombola_details_response.dart';
import 'package:kermanager/router/manager/routes.dart';
import 'package:kermanager/services/tombola_service.dart';
import 'package:kermanager/theme/theme_color.dart';
import 'package:kermanager/theme/theme_font.dart';
import 'package:kermanager/theme/theme_size.dart';
import 'package:kermanager/utils/snackbar.dart';
import 'package:kermanager/widgets/button.dart';
import 'package:kermanager/widgets/details_future_builder.dart';
import 'package:kermanager/widgets/icon_box.dart';
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
      throw Exception(response.error!);
    }
    return response.data!;
  }

  Future<void> _end() async {
    ApiResponse<Null> response =
        await _tombolaService.end(tombolaId: widget.tombolaId);
    if (response.error != null) {
      SnackBarUtils.showCustomSnackBar(
        context,
        response.error!,
        SnackBarVariant.error,
      );
    } else {
      SnackBarUtils.showCustomSnackBar(
        context,
        'Tombola terminée avec succès',
        SnackBarVariant.success,
      );
      _refresh();
    }
  }

  void _refresh() {
    setState(() {});
  }

  void _showBottomSheet() {
    showModalBottomSheet(
      context: context,
      builder: (context) {
        return Container(
          width: double.infinity,
          padding: const EdgeInsets.only(
            top: ThemeSize.s24,
            left: ThemeSize.s16,
            right: ThemeSize.s16,
            bottom: ThemeSize.s48,
          ),
          decoration: const BoxDecoration(
            color: ThemeColor.white,
            borderRadius: BorderRadius.vertical(
              top: Radius.circular(ThemeSize.s16),
            ),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const IconBox(
                icon: Icons.warning,
                isLarge: true,
              ),
              const SizedBox(height: ThemeSize.s16),
              const Text(
                "Êtes-vous sûr de vouloir terminer la tombola ?",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: ThemeSize.s18,
                  fontWeight: ThemeFontWeight.medium,
                  color: ThemeColor.black,
                ),
              ),
              const SizedBox(height: ThemeSize.s32),
              Button(
                label: "Terminer la tombola",
                onTap: () {
                  context.pop();
                  _end();
                },
              )
            ],
          ),
        );
      },
    );
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
                        onTap: _showBottomSheet,
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
