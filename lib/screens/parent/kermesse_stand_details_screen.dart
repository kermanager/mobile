import 'package:flutter/material.dart';
import 'package:kermanager/api/api_response.dart';
import 'package:kermanager/data/stand_details_response.dart';
import 'package:kermanager/services/interaction_service.dart';
import 'package:kermanager/services/stand_service.dart';
import 'package:kermanager/widgets/details_future_builder.dart';
import 'package:kermanager/widgets/screen.dart';
import 'package:kermanager/widgets/text_input.dart';

class KermesseStandDetailsScreen extends StatefulWidget {
  final int kermesseId;
  final int standId;

  const KermesseStandDetailsScreen({
    super.key,
    required this.kermesseId,
    required this.standId,
  });

  @override
  State<KermesseStandDetailsScreen> createState() =>
      _KermesseInteractionDetailsScreenState();
}

class _KermesseInteractionDetailsScreenState
    extends State<KermesseStandDetailsScreen> {
  final StandService _standService = StandService();
  final InteractionService _interactionService = InteractionService();

  final TextEditingController _quantityController = TextEditingController();

  Future<StandDetailsResponse> _get() async {
    ApiResponse<StandDetailsResponse> response = await _standService.details(
      standId: widget.standId,
    );
    if (response.error != null) {
      throw Exception(response.error);
    }
    return response.data!;
  }

  Future<void> _participate() async {
    ApiResponse<Null> response = await _interactionService.create(
      kermesseId: widget.kermesseId,
      standId: widget.standId,
      quantity: int.parse(_quantityController.text),
    );
    if (response.error != null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(response.error!),
        ),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Participation successful'),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Screen(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            "Stand Details",
          ),
          DetailsFutureBuilder<StandDetailsResponse>(
            future: _get,
            builder: (context, data) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(data.id.toString()),
                  Text(data.type),
                  Text(data.name),
                  Text(data.description),
                  Text(data.price.toString()),
                  Text(data.stock.toString()),
                  data.type == "ACTIVITY"
                      ? SizedBox(
                          width: 0,
                          height: 0,
                          child: TextInput(
                            defaultValue: "1",
                            controller: _quantityController,
                            hintText: "Quantity",
                          ),
                        )
                      : TextInput(
                          defaultValue: "1",
                          controller: _quantityController,
                          hintText: "Quantity",
                        ),
                  ElevatedButton(
                    onPressed: _participate,
                    child: const Text("Participate"),
                  ),
                ],
              );
            },
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _quantityController.dispose();
    super.dispose();
  }
}
