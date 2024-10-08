import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:kermanager/api/api_response.dart';
import 'package:kermanager/data/kermesse_list_response.dart';
import 'package:kermanager/router/stand_holder/routes.dart';
import 'package:kermanager/services/kermesse_service.dart';
import 'package:kermanager/widgets/list_future_builder.dart';

import 'package:kermanager/widgets/screen_list.dart';

class KermesseListScreen extends StatefulWidget {
  const KermesseListScreen({super.key});

  @override
  State<KermesseListScreen> createState() => _KermesseListScreenState();
}

class _KermesseListScreenState extends State<KermesseListScreen> {
  final KermesseService _kermesseService = KermesseService();

  Future<List<KermesseListItem>> _getAll() async {
    ApiResponse<List<KermesseListItem>> response =
        await _kermesseService.list();
    if (response.error != null) {
      throw Exception(response.error!);
    }
    return response.data!;
  }

  @override
  Widget build(BuildContext context) {
    return ScreenList(
      appBar: AppBar(
        title: const Text("Mes kermesses"),
      ),
      children: [
        Expanded(
          child: ListFutureBuilder<KermesseListItem>(
            future: _getAll,
            builder: (context, item) {
              return ListTile(
                title: Text(item.name),
                subtitle: Text(item.description),
                onTap: () {
                  context.push(
                    StandHolderRoutes.kermesseDetails,
                    extra: {
                      "kermesseId": item.id,
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
