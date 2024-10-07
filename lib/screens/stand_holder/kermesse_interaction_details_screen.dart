import 'package:flutter/material.dart';
import 'package:kermanager/api/api_response.dart';
import 'package:kermanager/data/interaction_details_response.dart';
import 'package:kermanager/services/interaction_service.dart';
import 'package:kermanager/widgets/details_future_builder.dart';
import 'package:kermanager/widgets/number_input.dart';
import 'package:kermanager/widgets/screen.dart';

class KermesseInteractionDetailsScreen extends StatefulWidget {
  final int kermesseId;
  final int interactionId;

  const KermesseInteractionDetailsScreen({
    super.key,
    required this.kermesseId,
    required this.interactionId,
  });

  @override
  State<KermesseInteractionDetailsScreen> createState() =>
      _KermesseInteractionDetailsScreenState();
}

class _KermesseInteractionDetailsScreenState
    extends State<KermesseInteractionDetailsScreen> {
  final InteractionService _interactionService = InteractionService();

  final TextEditingController _pointController = TextEditingController();

  Future<InteractionDetailsResponse> _get() async {
    ApiResponse<InteractionDetailsResponse> response =
        await _interactionService.details(
      interactionId: widget.interactionId,
    );
    if (response.error != null) {
      throw Exception(response.errorMessage);
    }
    return response.data!;
  }

  Future<void> _end() async {
    ApiResponse<Null> response = await _interactionService.end(
      interactionId: widget.interactionId,
      point: int.parse(_pointController.text),
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
          content: Text('Interaction ended successfully'),
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
      appBar: AppBar(),
      children: [
        DetailsFutureBuilder<InteractionDetailsResponse>(
          future: _get,
          builder: (context, data) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(data.id.toString()),
                Text(data.type),
                Text(data.status),
                Text(data.user.name),
                Text(data.credit.toString()),
                Text(data.kermesse.name),
                Text(data.stand.name),
                data.type == "ACTIVITY" && data.status == "STARTED"
                    ? Column(
                        children: [
                          NumberInput(
                            controller: _pointController,
                            defaultValue: "0",
                            hintText: "Point",
                          ),
                          ElevatedButton(
                            onPressed: _end,
                            child: const Text("End"),
                          ),
                        ],
                      )
                    : const SizedBox.shrink(),
              ],
            );
          },
        ),
      ],
    );
  }
}
