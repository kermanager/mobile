import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:kermanager/api/api_response.dart';
import 'package:kermanager/data/kermesse_details_response.dart';
import 'package:kermanager/router/child/routes.dart';
import 'package:kermanager/services/kermesse_service.dart';
import 'package:kermanager/theme/theme_color.dart';
import 'package:kermanager/theme/theme_font.dart';
import 'package:kermanager/theme/theme_size.dart';
import 'package:kermanager/widgets/details_future_builder.dart';
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
      throw Exception(response.errorMessage);
    }
    return response.data!;
  }

  @override
  Widget build(BuildContext context) {
    return Screen(
      appBar: AppBar(),
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
                        label: "Points gagnés",
                        value: data.points,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: ThemeSize.s24),
                Column(
                  children: [
                    LinkArrow(
                      label: "Stands",
                      count: data.standCount,
                      onTap: () {
                        context.push(
                          ChildRoutes.kermesseStandList,
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
                          ChildRoutes.kermesseTombolaList,
                          extra: {
                            "kermesseId": data.id,
                          },
                        );
                      },
                    ),
                    const SizedBox(height: ThemeSize.s8),
                    LinkArrow(
                      label: "Mes interactions",
                      count: data.interactionCount,
                      onTap: () {
                        context.push(
                          ChildRoutes.kermesseInteractionList,
                          extra: {
                            "kermesseId": data.id,
                          },
                        );
                      },
                    ),
                  ],
                ),
              ],
            );
          },
        ),
      ],
    );
  }
}
