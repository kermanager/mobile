import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:kermanager/api/api_response.dart';
import 'package:kermanager/data/tombola_list_response.dart';
import 'package:kermanager/router/child/routes.dart';
import 'package:kermanager/services/tombola_service.dart';
import 'package:kermanager/widgets/list_future_builder.dart';
import 'package:kermanager/widgets/screen_list.dart';
import 'package:kermanager/widgets/tombola_card.dart';

class KermesseTombolaListScreen extends StatefulWidget {
  final int kermesseId;

  const KermesseTombolaListScreen({
    super.key,
    required this.kermesseId,
  });

  @override
  State<KermesseTombolaListScreen> createState() =>
      _KermesseTombolaListScreenState();
}

class _KermesseTombolaListScreenState extends State<KermesseTombolaListScreen> {
  final TombolaService _tombolaService = TombolaService();

  Future<List<TombolaListItem>> _getAll() async {
    ApiResponse<List<TombolaListItem>> response = await _tombolaService.list(
      kermesseId: widget.kermesseId,
    );
    if (response.error != null) {
      throw Exception(response.error!);
    }
    return response.data!;
  }

  @override
  Widget build(BuildContext context) {
    return ScreenList(
      appBar: AppBar(
        title: const Text("Tombolas"),
      ),
      children: [
        Expanded(
          child: ListFutureBuilder<TombolaListItem>(
            future: _getAll,
            noResultMessage:
                "Aucune tombola n'a été trouvée pour cette kermesse",
            builder: (context, item) {
              return TombolaCard(
                tombola: item,
                onTap: () {
                  context.push(
                    ChildRoutes.kermesseTombolaDetails,
                    extra: {
                      "tombolaId": item.id,
                      "kermesseId": widget.kermesseId,
                    },
                  );
                },
              );
            },
          ),
        ),
      ],
    );
  }
}
