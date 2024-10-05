import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:kermanager/api/api_response.dart';
import 'package:kermanager/data/stand_list_response.dart';
import 'package:kermanager/router/manager/routes.dart';
import 'package:kermanager/services/stand_service.dart';
import 'package:kermanager/widgets/screen_list.dart';

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
            "Kermesse Stand List",
          ),
          ElevatedButton(
            onPressed: () {
              context.push(
                ManagerRoutes.kermesseStandInvite,
                extra: {
                  'kermesseId': widget.kermesseId,
                },
              );
            },
            child: const Text('Invite'),
          ),
          Expanded(
            child: FutureBuilder<List<StandListItem>>(
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
                      StandListItem item = snapshot.data![index];
                      return ListTile(
                        title: Text(item.name),
                        subtitle: Text(item.type),
                      );
                    },
                  );
                }
                return const Center(
                  child: Text('No stands found'),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
