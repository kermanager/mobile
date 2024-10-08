import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:kermanager/api/api_response.dart';
import 'package:kermanager/data/kermesse_details_response.dart';
import 'package:kermanager/router/manager/routes.dart';
import 'package:kermanager/services/kermesse_service.dart';
import 'package:kermanager/theme/theme_color.dart';
import 'package:kermanager/theme/theme_font.dart';
import 'package:kermanager/theme/theme_size.dart';
import 'package:kermanager/widgets/button.dart';
import 'package:kermanager/widgets/details_future_builder.dart';
import 'package:kermanager/widgets/icon_box.dart';
import 'package:kermanager/widgets/link_arrow.dart';
import 'package:kermanager/widgets/screen.dart';
import 'package:kermanager/widgets/stats.dart';
import 'package:kermanager/widgets/status_label.dart';

class KermesseDetailsScreen extends StatefulWidget {
  final int kermesseId;

  const KermesseDetailsScreen({
    super.key,
    required this.kermesseId,
  });

  @override
  State<KermesseDetailsScreen> createState() => _KermesseDetailsScreenState();
}

class _KermesseDetailsScreenState extends State<KermesseDetailsScreen> {
  final KermesseService _kermesseService = KermesseService();

  Future<KermesseDetailsResponse> _get() async {
    ApiResponse<KermesseDetailsResponse> response =
        await _kermesseService.details(
      kermesseId: widget.kermesseId,
    );
    if (response.error != null) {
      throw Exception(response.error!);
    }
    return response.data!;
  }

  Future<void> _end() async {
    ApiResponse<Null> response =
        await _kermesseService.end(id: widget.kermesseId);
    if (response.error != null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(response.error!),
        ),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Kermesse terminée avec succès'),
        ),
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
                "Êtes-vous sûr de vouloir terminer la kermesse ?",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: ThemeSize.s18,
                  fontWeight: ThemeFontWeight.medium,
                  color: ThemeColor.black,
                ),
              ),
              const SizedBox(height: ThemeSize.s32),
              Button(
                label: "Terminer la kermesse",
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
            icon: const Icon(Icons.edit),
            onPressed: () {
              context.push(
                ManagerRoutes.kermesseEdit,
                extra: {
                  "kermesseId": widget.kermesseId,
                },
              );
            },
          ),
        ],
      ),
      children: [
        DetailsFutureBuilder<KermesseDetailsResponse>(
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
                Text(
                  data.description,
                  style: const TextStyle(
                    fontSize: ThemeSize.s16,
                    fontWeight: ThemeFontWeight.medium,
                    color: ThemeColor.gray400,
                  ),
                ),
                const SizedBox(height: ThemeSize.s24),
                Row(
                  children: [
                    Expanded(
                      child: Stats(
                        label: "Stands (en jetons)",
                        value: data.interactionIncome,
                      ),
                    ),
                    const SizedBox(width: ThemeSize.s8),
                    Expanded(
                      child: Stats(
                        label: "Tombolas (en jetons)",
                        value: data.tombolaIncome,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: ThemeSize.s24),
                Column(
                  children: [
                    LinkArrow(
                      label: "Participants",
                      count: data.userCount,
                      onTap: () {
                        context.push(
                          ManagerRoutes.kermesseUserList,
                          extra: {
                            "kermesseId": data.id,
                          },
                        );
                      },
                    ),
                    const SizedBox(height: ThemeSize.s8),
                    LinkArrow(
                      label: "Stands",
                      count: data.standCount,
                      onTap: () {
                        context.push(
                          ManagerRoutes.kermesseStandList,
                          extra: {
                            "kermesseId": data.id,
                          },
                        );
                      },
                    ),
                    const SizedBox(height: ThemeSize.s8),
                    LinkArrow(
                      label: "Tombolas",
                      count: data.tombolaCount,
                      onTap: () {
                        context.push(
                          ManagerRoutes.kermesseTombolaList,
                          extra: {
                            "kermesseId": data.id,
                          },
                        );
                      },
                    ),
                    const SizedBox(height: ThemeSize.s8),
                    LinkArrow(
                      label: "Interactions",
                      count: data.interactionCount,
                      onTap: () {
                        context.push(
                          ManagerRoutes.kermesseInteractionList,
                          extra: {
                            "kermesseId": data.id,
                          },
                        );
                      },
                    ),
                  ],
                ),
                const SizedBox(height: ThemeSize.s28),
                data.status == "STARTED"
                    ? Button(
                        label: "Terminer la kermesse",
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
