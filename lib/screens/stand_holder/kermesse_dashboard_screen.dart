import 'package:flutter/material.dart';
import 'package:kermanager/api/api_response.dart';
import 'package:kermanager/data/kermesse_details_response.dart';
import 'package:kermanager/services/kermesse_service.dart';
import 'package:kermanager/widgets/details_future_builder.dart';
import 'package:kermanager/widgets/screen.dart';

class KermesseDashboardScreen extends StatefulWidget {
  final int kermesseId;

  const KermesseDashboardScreen({
    super.key,
    required this.kermesseId,
  });

  @override
  State<KermesseDashboardScreen> createState() =>
      _KermesseDashboardScreenState();
}

class _KermesseDashboardScreenState extends State<KermesseDashboardScreen> {
  final KermesseService _kermesseService = KermesseService();

  Future<KermesseDetailsResponse> _get() async {
    ApiResponse<KermesseDetailsResponse> response =
        await _kermesseService.details(
      kermesseId: widget.kermesseId,
    );
    if (response.error != null) {
      throw Exception(response.error!);
    }
    return response.data!;
  }

  @override
  Widget build(BuildContext context) {
    return Screen(
      appBar: AppBar(
        title: const Text("Dashboard"),
      ),
      children: [
        DetailsFutureBuilder<KermesseDetailsResponse>(
          future: _get,
          builder: (context, data) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("Stand Count: ${data.standCount}"),
                Text("Interaction Count: ${data.interactionCount}"),
                Text("Interaction Income: ${data.interactionIncome}"),
              ],
            );
          },
        ),
      ],
    );
  }
}
