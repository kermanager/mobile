import 'package:flutter/material.dart';
import 'package:kermanager/api/api_response.dart';
import 'package:kermanager/data/stand_list_response.dart';
import 'package:kermanager/services/stand_service.dart';
import 'package:kermanager/widgets/screen_list.dart';

class KermesseStandInviteScreen extends StatefulWidget {
  final int kermesseId;

  const KermesseStandInviteScreen({
    super.key,
    required this.kermesseId,
  });

  @override
  State<KermesseStandInviteScreen> createState() =>
      _KermesseStandInviteScreenState();
}

class _KermesseStandInviteScreenState extends State<KermesseStandInviteScreen> {
  final Key _key = UniqueKey();

  final StandService _standService = StandService();

  Future<List<StandListItem>> _getAll() async {
    ApiResponse<List<StandListItem>> response = await _standService.list(
      isFree: true,
    );
    if (response.error != null) {
      throw Exception(response.error);
    }
    return response.data!;
  }

  Future<void> _invite(int standId) async {
    ApiResponse<Null> response = await _standService.invite(
      kermesseId: widget.kermesseId,
      standId: standId,
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
          content: Text('Stand invited successfully'),
        ),
      );
      _refresh();
    }
  }

  void _refresh() {
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return ScreenList(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            "Kermesse Stand Invite",
          ),
          Expanded(
            child: FutureBuilder<List<StandListItem>>(
              key: _key,
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
                        leading: ElevatedButton(
                          onPressed: () async {
                            await _invite(item.id);
                          },
                          child: const Text('Invite'),
                        ),
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
