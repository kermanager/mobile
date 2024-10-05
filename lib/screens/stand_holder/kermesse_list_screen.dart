import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:kermanager/api/api_response.dart';
import 'package:kermanager/data/kermesse_list_response.dart';
import 'package:kermanager/router/stand_holder/routes.dart';
import 'package:kermanager/services/kermesse_service.dart';

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
            "Kermesse List",
          ),
          Expanded(
            child: FutureBuilder<List<KermesseListItem>>(
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
                      KermesseListItem item = snapshot.data![index];
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
                  );
                }
                return const Center(
                  child: Text('No kermesses found'),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
