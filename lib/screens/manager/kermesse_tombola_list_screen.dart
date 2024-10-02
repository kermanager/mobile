import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:kermanager/api/api_response.dart';
import 'package:kermanager/data/tombola_list_response.dart';
import 'package:kermanager/router/manager/routes.dart';
import 'package:kermanager/services/tombola_service.dart';
import 'package:kermanager/widgets/screen_list.dart';

class KermesseTombolaListScreen extends StatefulWidget {
  final int kermesseId;

  const KermesseTombolaListScreen({
    super.key,
    required this.kermesseId,
  });

  @override
  State<KermesseTombolaListScreen> createState() =>
      _KermesseTombolaListScreenState();
}

class _KermesseTombolaListScreenState extends State<KermesseTombolaListScreen> {
  final Key _key = UniqueKey();

  final TombolaService _tombolaService = TombolaService();

  Future<List<TombolaListItem>> _getAll() async {
    ApiResponse<List<TombolaListItem>> response = await _tombolaService.list(
      kermesseId: widget.kermesseId,
    );
    if (response.error != null) {
      throw Exception(response.error);
    }
    return response.data!;
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
            "Kermesse Tombola List",
          ),
          ElevatedButton(
            onPressed: () {
              context.push(ManagerRoutes.kermesseCreate);
              _refresh();
            },
            child: const Text('Create'),
          ),
          Expanded(
            child: FutureBuilder<List<TombolaListItem>>(
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
                      TombolaListItem item = snapshot.data![index];
                      return ListTile(
                        title: Text(item.name),
                        subtitle: Text(item.gift),
                      );
                    },
                  );
                }
                return const Center(
                  child: Text('No tombolas found'),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
