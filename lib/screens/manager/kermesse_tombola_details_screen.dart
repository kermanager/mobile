import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:kermanager/api/api_response.dart';
import 'package:kermanager/data/tombola_details_response.dart';
import 'package:kermanager/router/manager/routes.dart';
import 'package:kermanager/services/tombola_service.dart';
import 'package:kermanager/widgets/details_future_builder.dart';
import 'package:kermanager/widgets/screen.dart';

class KermesseTombolaDetailsScreen extends StatefulWidget {
  final int kermesseId;
  final int tombolaId;

  const KermesseTombolaDetailsScreen({
    super.key,
    required this.kermesseId,
    required this.tombolaId,
  });

  @override
  State<KermesseTombolaDetailsScreen> createState() =>
      _KermesseTombolaDetailsScreenState();
}

class _KermesseTombolaDetailsScreenState
    extends State<KermesseTombolaDetailsScreen> {
  final TombolaService _tombolaService = TombolaService();

  Future<TombolaDetailsResponse> _get() async {
    ApiResponse<TombolaDetailsResponse> response =
        await _tombolaService.details(
      tombolaId: widget.tombolaId,
    );
    if (response.error != null) {
      throw Exception(response.errorMessage);
    }
    return response.data!;
  }

  Future<void> _end() async {
    ApiResponse<Null> response =
        await _tombolaService.end(tombolaId: widget.tombolaId);
    if (response.error != null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(response.errorMessage),
        ),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Tombola ended successfully'),
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
    return Screen(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            "Tombola Details",
          ),
          DetailsFutureBuilder<TombolaDetailsResponse>(
            future: _get,
            builder: (context, data) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(data.id.toString()),
                  Text(data.name),
                  Text(data.price.toString()),
                  Text(data.gift),
                  Text(data.status),
                  data.status == "STARTED"
                      ? Column(
                          children: [
                            ElevatedButton(
                              onPressed: () {
                                context.push(
                                  ManagerRoutes.kermesseTombolaEdit,
                                  extra: {
                                    "kermesseId": widget.kermesseId,
                                    "tombolaId": widget.tombolaId,
                                  },
                                );
                              },
                              child: const Text("Edit"),
                            ),
                            ElevatedButton(
                              onPressed: _end,
                              child: const Text("End"),
                            )
                          ],
                        )
                      : const SizedBox.shrink(),
                ],
              );
            },
          ),
        ],
      ),
    );
  }
}
