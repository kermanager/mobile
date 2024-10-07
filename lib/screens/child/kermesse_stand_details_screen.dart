import 'package:flutter/material.dart';
import 'package:kermanager/api/api_response.dart';
import 'package:kermanager/data/stand_details_response.dart';
import 'package:kermanager/services/interaction_service.dart';
import 'package:kermanager/services/stand_service.dart';
import 'package:kermanager/theme/theme_color.dart';
import 'package:kermanager/theme/theme_font.dart';
import 'package:kermanager/theme/theme_size.dart';
import 'package:kermanager/widgets/button.dart';
import 'package:kermanager/widgets/details_future_builder.dart';
import 'package:kermanager/widgets/icon_box.dart';
import 'package:kermanager/widgets/number_input.dart';
import 'package:kermanager/widgets/screen.dart';

class KermesseStandDetailsScreen extends StatefulWidget {
  final int kermesseId;
  final int standId;

  const KermesseStandDetailsScreen({
    super.key,
    required this.kermesseId,
    required this.standId,
  });

  @override
  State<KermesseStandDetailsScreen> createState() =>
      _KermesseInteractionDetailsScreenState();
}

class _KermesseInteractionDetailsScreenState
    extends State<KermesseStandDetailsScreen> {
  final TextEditingController _quantityController = TextEditingController();

  final StandService _standService = StandService();
  final InteractionService _interactionService = InteractionService();

  Future<StandDetailsResponse> _get() async {
    ApiResponse<StandDetailsResponse> response = await _standService.details(
      standId: widget.standId,
    );
    if (response.error != null) {
      throw Exception(response.errorMessage);
    }
    return response.data!;
  }

  Future<void> _participate() async {
    ApiResponse<Null> response = await _interactionService.create(
      kermesseId: widget.kermesseId,
      standId: widget.standId,
      quantity: int.parse(_quantityController.text),
    );
    if (response.error != null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(response.errorMessage),
        ),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Participation successful'),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Screen(
      appBar: AppBar(),
      children: [
        DetailsFutureBuilder<StandDetailsResponse>(
          future: _get,
          builder: (context, data) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                IconBox(
                  icon: data.type == "CONSUMPTION"
                      ? Icons.fastfood
                      : Icons.gamepad,
                ),
                const SizedBox(height: ThemeSize.s16),
                Text(
                  data.name,
                  style: const TextStyle(
                    fontSize: ThemeSize.s24,
                    fontWeight: ThemeFontWeight.medium,
                    color: ThemeColor.black,
                  ),
                ),
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
                data.type == "CONSUMPTION"
                    ? Column(
                        children: [
                          Row(
                            children: [
                              const Icon(
                                Icons.inventory,
                                color: ThemeColor.gray400,
                                size: ThemeSize.s24,
                              ),
                              const SizedBox(width: ThemeSize.s16),
                              Text(
                                "${data.stock.toString()} pièces",
                                style: const TextStyle(
                                  fontSize: ThemeSize.s16,
                                  fontWeight: ThemeFontWeight.medium,
                                  color: ThemeColor.black,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: ThemeSize.s16),
                        ],
                      )
                    : const SizedBox.shrink(),
                Row(
                  children: [
                    const Icon(
                      Icons.monetization_on,
                      color: ThemeColor.gray400,
                      size: ThemeSize.s24,
                    ),
                    const SizedBox(width: ThemeSize.s16),
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
                const SizedBox(height: ThemeSize.s24),
                data.type == "ACTIVITY"
                    ? SizedBox(
                        width: 0,
                        height: 0,
                        child: NumberInput(
                          defaultValue: "1",
                          controller: _quantityController,
                          hintText: "Quantity",
                        ),
                      )
                    : NumberInput(
                        defaultValue: "1",
                        controller: _quantityController,
                        hintText: "Quantity",
                      ),
                Button(
                  label: data.type == "ACTIVITY" ? "Participer" : "Acheter",
                  onTap: _participate,
                ),
              ],
            );
          },
        ),
      ],
    );
  }

  @override
  void dispose() {
    _quantityController.dispose();
    super.dispose();
  }
}
