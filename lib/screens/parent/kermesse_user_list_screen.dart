import 'package:flutter/material.dart';
import 'package:kermanager/api/api_response.dart';
import 'package:kermanager/data/user_list_response.dart';
import 'package:kermanager/services/user_service.dart';
import 'package:kermanager/widgets/list_future_builder.dart';
import 'package:kermanager/widgets/participant_card.dart';
import 'package:kermanager/widgets/screen_list.dart';

class KermesseUserListScreen extends StatefulWidget {
  final int kermesseId;

  const KermesseUserListScreen({
    super.key,
    required this.kermesseId,
  });

  @override
  State<KermesseUserListScreen> createState() => _KermesseUserListScreenState();
}

class _KermesseUserListScreenState extends State<KermesseUserListScreen> {
  final UserService _userService = UserService();

  Future<List<UserListItem>> _getAll() async {
    ApiResponse<List<UserListItem>> response = await _userService.listChildren(
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
        title: const Text("Mes enfants"),
      ),
      children: [
        Expanded(
          child: ListFutureBuilder<UserListItem>(
            future: _getAll,
            noResultMessage:
                "Aucun de vos enfants n'est inscrit à cette kermesse",
            builder: (context, item) {
              return ParticipantCard(user: item);
            },
          ),
        ),
      ],
    );
  }
}
