import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:kermanager/api/api_response.dart';
import 'package:kermanager/data/kermesse_details_response.dart';
import 'package:kermanager/router/child/routes.dart';
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

  @override
  Widget build(BuildContext context) {
    return Screen(
      appBar: AppBar(),
      children: [
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
                ElevatedButton(
                  onPressed: () {
                    context.push(
                      ChildRoutes.kermesseDashboard,
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
                      ChildRoutes.kermesseStandList,
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
                      ChildRoutes.kermesseTombolaList,
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
                      ChildRoutes.kermesseInteractionList,
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
    );
  }
}
