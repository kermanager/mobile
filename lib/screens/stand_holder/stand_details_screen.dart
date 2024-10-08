import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:kermanager/api/api_response.dart';
import 'package:kermanager/data/stand_details_response.dart';
import 'package:kermanager/router/stand_holder/routes.dart';
import 'package:kermanager/services/stand_service.dart';
import 'package:kermanager/theme/theme_color.dart';
import 'package:kermanager/theme/theme_font.dart';
import 'package:kermanager/theme/theme_size.dart';
import 'package:kermanager/widgets/details_future_builder.dart';
import 'package:kermanager/widgets/icon_box.dart';
import 'package:kermanager/widgets/screen.dart';

class StandDetailsScreen extends StatefulWidget {
  const StandDetailsScreen({
    super.key,
  });

  @override
  State<StandDetailsScreen> createState() => _StandDetailsScreenState();
}

class _StandDetailsScreenState extends State<StandDetailsScreen> {
  final StandService _standService = StandService();

  Future<StandDetailsResponse> _get() async {
    ApiResponse<StandDetailsResponse> response = await _standService.current();
    if (response.error != null) {
      throw Exception(response.error!);
    }
    return response.data!;
  }

  @override
  Widget build(BuildContext context) {
    return Screen(
      appBar: AppBar(
        title: const Text('Mon stand'),
        actions: [
          IconButton(
            icon: const Icon(Icons.edit),
            onPressed: () {
              context.push(
                StandHolderRoutes.standEdit,
              );
            },
          ),
        ],
      ),
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
                      : Icons.sports_esports,
                  isLarge: true,
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
              ],
            );
          },
        ),
      ],
    );
  }
}
