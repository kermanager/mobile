import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:kermanager/api/api_response.dart';
import 'package:kermanager/data/ticket_list_response.dart';
import 'package:kermanager/router/parent/routes.dart';
import 'package:kermanager/services/ticket_service.dart';
import 'package:kermanager/widgets/list_future_builder.dart';
import 'package:kermanager/widgets/screen_list.dart';
import 'package:kermanager/widgets/ticket_card.dart';

class TicketListScreen extends StatefulWidget {
  const TicketListScreen({super.key});

  @override
  State<TicketListScreen> createState() => _TicketListScreenState();
}

class _TicketListScreenState extends State<TicketListScreen> {
  final TicketService _ticketService = TicketService();

  Future<List<TicketListItem>> _getAll() async {
    ApiResponse<List<TicketListItem>> response = await _ticketService.list();
    if (response.error != null) {
      throw Exception(response.error!);
    }
    return response.data!;
  }

  @override
  Widget build(BuildContext context) {
    return ScreenList(
      appBar: AppBar(
        title: const Text("Tickets"),
      ),
      children: [
        Expanded(
          child: ListFutureBuilder<TicketListItem>(
            future: _getAll,
            builder: (context, item) {
              return TicketCard(
                ticket: item,
                onTap: () {
                  context.push(
                    ParentRoutes.ticketDetails,
                    extra: {
                      "ticketId": item.id,
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
