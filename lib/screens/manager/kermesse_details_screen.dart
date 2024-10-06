import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:kermanager/api/api_response.dart';
import 'package:kermanager/data/kermesse_details_response.dart';
import 'package:kermanager/router/manager/routes.dart';
import 'package:kermanager/services/kermesse_service.dart';
import 'package:kermanager/widgets/details_future_builder.dart';
import 'package:kermanager/widgets/screen.dart';

class KermesseDetailsScreen extends StatefulWidget {
  final int kermesseId;

  const KermesseDetailsScreen({
    super.key,
    required this.kermesseId,
  });

  @override
  State<KermesseDetailsScreen> createState() => _KermesseDetailsScreenState();
}

class _KermesseDetailsScreenState extends State<KermesseDetailsScreen> {
  final KermesseService _kermesseService = KermesseService();

  Future<KermesseDetailsResponse> _get() async {
    ApiResponse<KermesseDetailsResponse> response =
        await _kermesseService.details(
      kermesseId: widget.kermesseId,
    );
    if (response.error != null) {
      throw Exception(response.errorMessage);
    }
    return response.data!;
  }

  Future<void> _end() async {
    ApiResponse<Null> response =
        await _kermesseService.end(id: widget.kermesseId);
    if (response.error != null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(response.errorMessage),
        ),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Kermesse Ended successfully'),
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
            "Kermesse Details",
          ),
          DetailsFutureBuilder<KermesseDetailsResponse>(
            future: _get,
            builder: (context, data) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(data.id.toString()),
                  Text(data.name),
                  Text(data.description),
                  Text(data.status),
                  data.status == "STARTED"
                      ? Column(
                          children: [
                            ElevatedButton(
                              onPressed: () {
                                context.push(
                                  ManagerRoutes.kermesseEdit,
                                  extra: {
                                    "kermesseId": data.id,
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
                  ElevatedButton(
                    onPressed: () {
                      context.push(
                        ManagerRoutes.kermesseDashboard,
                        extra: {
                          "kermesseId": data.id,
                        },
                      );
                    },
                    child: const Text("Dashboard"),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      context.push(
                        ManagerRoutes.kermesseUserList,
                        extra: {
                          "kermesseId": data.id,
                        },
                      );
                    },
                    child: const Text("Users"),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      context.push(
                        ManagerRoutes.kermesseStandList,
                        extra: {
                          "kermesseId": data.id,
                        },
                      );
                    },
                    child: const Text("Stands"),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      context.push(
                        ManagerRoutes.kermesseTombolaList,
                        extra: {
                          "kermesseId": data.id,
                        },
                      );
                    },
                    child: const Text("Tombolas"),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      context.push(
                        ManagerRoutes.kermesseInteractionList,
                        extra: {
                          "kermesseId": data.id,
                        },
                      );
                    },
                    child: const Text("Interactions"),
                  )
                ],
              );
            },
          ),
        ],
      ),
    );
  }
}
