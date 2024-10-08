import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:kermanager/api/api_response.dart';
import 'package:kermanager/data/stand_list_response.dart';
import 'package:kermanager/router/parent/routes.dart';
import 'package:kermanager/services/stand_service.dart';
import 'package:kermanager/widgets/list_future_builder.dart';
import 'package:kermanager/widgets/screen_list.dart';
import 'package:kermanager/widgets/stand_card.dart';

class KermesseStandListScreen extends StatefulWidget {
  final int kermesseId;

  const KermesseStandListScreen({
    super.key,
    required this.kermesseId,
  });

  @override
  State<KermesseStandListScreen> createState() =>
      _KermesseStandListScreenState();
}

class _KermesseStandListScreenState extends State<KermesseStandListScreen> {
  final StandService _standService = StandService();

  Future<List<StandListItem>> _getAll() async {
    ApiResponse<List<StandListItem>> response = await _standService.list(
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
        title: const Text("Stands"),
      ),
      children: [
        Expanded(
          child: ListFutureBuilder<StandListItem>(
            future: _getAll,
            noResultMessage: "Aucun stand trouvé pour cette kermesse",
            builder: (context, item) {
              return StandCard(
                stand: item,
                onTap: () {
                  context.push(
                    ParentRoutes.kermesseStandDetails,
                    extra: {
                      "kermesseId": widget.kermesseId,
                      "standId": item.id,
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
