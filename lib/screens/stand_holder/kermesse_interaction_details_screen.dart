import 'package:flutter/material.dart';
import 'package:kermanager/api/api_response.dart';
import 'package:kermanager/data/interaction_details_response.dart';
import 'package:kermanager/services/interaction_service.dart';
import 'package:kermanager/theme/theme_color.dart';
import 'package:kermanager/theme/theme_font.dart';
import 'package:kermanager/theme/theme_size.dart';
import 'package:kermanager/widgets/button.dart';
import 'package:kermanager/widgets/details_future_builder.dart';
import 'package:kermanager/widgets/form_column.dart';
import 'package:kermanager/widgets/icon_box.dart';
import 'package:kermanager/widgets/number_form_input.dart';
import 'package:kermanager/widgets/role_label.dart';
import 'package:kermanager/widgets/screen.dart';
import 'package:kermanager/widgets/status_label.dart';

class KermesseInteractionDetailsScreen extends StatefulWidget {
  final int kermesseId;
  final int interactionId;

  const KermesseInteractionDetailsScreen({
    super.key,
    required this.kermesseId,
    required this.interactionId,
  });

  @override
  State<KermesseInteractionDetailsScreen> createState() =>
      _KermesseInteractionDetailsScreenState();
}

class _KermesseInteractionDetailsScreenState
    extends State<KermesseInteractionDetailsScreen> {
  final _formKey = GlobalKey<FormState>();

  final InteractionService _interactionService = InteractionService();

  final TextEditingController _pointController = TextEditingController();

  Future<InteractionDetailsResponse> _get() async {
    ApiResponse<InteractionDetailsResponse> response =
        await _interactionService.details(
      interactionId: widget.interactionId,
    );
    if (response.error != null) {
      throw Exception(response.error!);
    }
    return response.data!;
  }

  Future<void> _end() async {
    if (_formKey.currentState!.validate()) {
      ApiResponse<Null> response = await _interactionService.end(
        interactionId: widget.interactionId,
        point: int.parse(_pointController.text),
      );
      if (response.error != null) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(response.error!),
          ),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Participation terminée avec succès'),
          ),
        );
        _refresh();
      }
    }
  }

  void _refresh() {
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Screen(
      appBar: AppBar(),
      children: [
        DetailsFutureBuilder<InteractionDetailsResponse>(
          future: _get,
          builder: (context, data) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    IconBox(
                      icon: data.type == "CONSUMPTION"
                          ? Icons.fastfood
                          : Icons.gamepad,
                      isLarge: true,
                    ),
                    Column(
                      children: [
                        Text(
                          "- ${data.credit.toString()} jeton",
                          style: const TextStyle(
                            fontSize: ThemeFontSize.s16,
                            fontWeight: ThemeFontWeight.semiBold,
                            color: ThemeColor.red200,
                          ),
                        ),
                        const SizedBox(height: ThemeSize.s4),
                        data.type == "ACTIVITY"
                            ? Text(
                                "+ ${data.point.toString()} point",
                                style: const TextStyle(
                                  fontSize: ThemeFontSize.s16,
                                  fontWeight: ThemeFontWeight.semiBold,
                                  color: ThemeColor.primary,
                                ),
                              )
                            : const SizedBox.shrink(),
                      ],
                    ),
                  ],
                ),
                const SizedBox(height: ThemeSize.s16),
                data.type == "ACTIVITY"
                    ? StatusLabel(status: data.status)
                    : const SizedBox.shrink(),
                const SizedBox(height: ThemeSize.s24),
                const Text(
                  "Utilisateur",
                  style: TextStyle(
                    fontSize: ThemeSize.s18,
                    fontWeight: ThemeFontWeight.medium,
                    color: ThemeColor.black,
                  ),
                ),
                const Divider(color: ThemeColor.gray200),
                const SizedBox(height: ThemeSize.s4),
                Row(
                  children: [
                    Text(
                      data.user.name,
                      style: const TextStyle(
                        fontSize: ThemeSize.s16,
                        fontWeight: ThemeFontWeight.medium,
                        color: ThemeColor.black,
                      ),
                    ),
                    const SizedBox(width: ThemeSize.s8),
                    RoleLabel(role: data.user.role),
                  ],
                ),
                const SizedBox(height: ThemeSize.s4),
                Text(
                  data.user.email,
                  style: const TextStyle(
                    fontSize: ThemeSize.s14,
                    fontWeight: ThemeFontWeight.medium,
                    color: ThemeColor.gray400,
                  ),
                ),
                const SizedBox(height: ThemeSize.s24),
                const Text(
                  "Stand",
                  style: TextStyle(
                    fontSize: ThemeSize.s18,
                    fontWeight: ThemeFontWeight.medium,
                    color: ThemeColor.black,
                  ),
                ),
                const Divider(color: ThemeColor.gray200),
                const SizedBox(height: ThemeSize.s4),
                Text(
                  data.stand.name,
                  style: const TextStyle(
                    fontSize: ThemeSize.s16,
                    fontWeight: ThemeFontWeight.medium,
                    color: ThemeColor.black,
                  ),
                ),
                const SizedBox(height: ThemeSize.s4),
                Text(
                  data.stand.description,
                  style: const TextStyle(
                    fontSize: ThemeSize.s14,
                    fontWeight: ThemeFontWeight.medium,
                    color: ThemeColor.gray400,
                  ),
                ),
                const SizedBox(height: ThemeSize.s24),
                data.type == "ACTIVITY" && data.status == "STARTED"
                    ? FormColumn(
                        formKey: _formKey,
                        children: [
                          NumberFormInput(
                            hintText: "Points gagnés",
                            unit: "point",
                            controller: _pointController,
                          ),
                          const SizedBox(height: ThemeSize.s8),
                          Button(
                            label: "Terminer et noter",
                            onTap: _end,
                          ),
                        ],
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
