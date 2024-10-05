import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:kermanager/api/api_response.dart';
import 'package:kermanager/data/ticket_list_response.dart';
import 'package:kermanager/router/child/routes.dart';
import 'package:kermanager/services/ticket_service.dart';
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
      throw Exception(response.error);
    }
    return response.data!;
  }

  @override
  Widget build(BuildContext context) {
    return ScreenList(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            "Ticket List",
          ),
          Expanded(
            child: FutureBuilder<List<TicketListItem>>(
              future: _getAll(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }
                if (snapshot.hasError) {
                  return Center(
                    child: Text(
                      snapshot.error.toString(),
                    ),
                  );
                }
                if (snapshot.hasData) {
                  return ListView.builder(
                    itemCount: snapshot.data!.length,
                    itemBuilder: (context, index) {
                      TicketListItem item = snapshot.data![index];
                      return ListTile(
                        title: Text(item.isWinner ? 'Winner' : 'Loser'),
                        subtitle: Text(item.user.name),
                        onTap: () {
                          context.push(
                            ChildRoutes.ticketDetails,
                            extra: {
                              "ticketId": item.id,
                            },
                          );
                        },
                      );
                    },
                  );
                }
                return const Center(
                  child: Text('No tickets found'),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
