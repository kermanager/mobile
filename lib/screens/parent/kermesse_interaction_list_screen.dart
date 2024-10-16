import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:kermanager/api/api_response.dart';
import 'package:kermanager/data/interaction_list_response.dart';
import 'package:kermanager/router/parent/routes.dart';
import 'package:kermanager/services/interaction_service.dart';
import 'package:kermanager/widgets/interaction_card.dart';
import 'package:kermanager/widgets/list_future_builder.dart';
import 'package:kermanager/widgets/screen_list.dart';

class KermesseInteractionListScreen extends StatefulWidget {
  final int kermesseId;

  const KermesseInteractionListScreen({
    super.key,
    required this.kermesseId,
  });

  @override
  State<KermesseInteractionListScreen> createState() =>
      _KermesseInteractionListScreenState();
}

class _KermesseInteractionListScreenState
    extends State<KermesseInteractionListScreen> {
  final InteractionService _interactionService = InteractionService();

  Future<List<InteractionListItem>> _getAll() async {
    ApiResponse<List<InteractionListItem>> response =
        await _interactionService.list(
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
        title: const Text("Interactions"),
      ),
      children: [
        Expanded(
          child: ListFutureBuilder<InteractionListItem>(
            future: _getAll,
            noResultMessage:
                "Aucune interaction n'a été faite pour cette kermesse",
            builder: (context, item) {
              return InteractionCard(
                interaction: item,
                isMinus: true,
                onTap: () {
                  context.push(
                    ParentRoutes.kermesseInteractionDetails,
                    extra: {
                      "kermesseId": widget.kermesseId,
                      "interactionId": item.id,
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
