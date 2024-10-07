import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:kermanager/api/api_response.dart';
import 'package:kermanager/data/ticket_list_response.dart';
import 'package:kermanager/router/manager/routes.dart';
import 'package:kermanager/services/ticket_service.dart';
import 'package:kermanager/widgets/list_future_builder.dart';
import 'package:kermanager/widgets/screen_list.dart';

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
      throw Exception(response.errorMessage);
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
              return ListTile(
                title: Text(item.isWinner ? 'Winner' : 'Loser'),
                subtitle: Text(item.user.name),
                onTap: () {
                  context.push(
                    ManagerRoutes.ticketDetails,
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
