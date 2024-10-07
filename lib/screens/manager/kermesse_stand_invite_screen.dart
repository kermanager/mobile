import 'package:flutter/material.dart';
import 'package:kermanager/api/api_response.dart';
import 'package:kermanager/data/stand_list_response.dart';
import 'package:kermanager/services/kermesse_service.dart';
import 'package:kermanager/services/stand_service.dart';
import 'package:kermanager/widgets/list_future_builder.dart';
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
  final StandService _standService = StandService();
  final KermesseService _kermesseService = KermesseService();

  Future<List<StandListItem>> _getAll() async {
    ApiResponse<List<StandListItem>> response = await _standService.list(
      isFree: true,
    );
    if (response.error != null) {
      throw Exception(response.errorMessage);
    }
    return response.data!;
  }

  Future<void> _invite(int standId) async {
    ApiResponse<Null> response = await _kermesseService.inviteStand(
      kermesseId: widget.kermesseId,
      standId: standId,
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
          content: Text('Stand invited successfully'),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return ScreenList(
      appBar: AppBar(
        title: const Text("Inviter un stand"),
      ),
      children: [
        Expanded(
          child: ListFutureBuilder<StandListItem>(
            future: _getAll,
            builder: (context, item) {
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
          ),
        ),
      ],
    );
  }
}
