import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:kermanager/api/api_response.dart';
import 'package:kermanager/data/stand_details_response.dart';
import 'package:kermanager/router/stand_holder/routes.dart';
import 'package:kermanager/services/stand_service.dart';
import 'package:kermanager/widgets/details_future_builder.dart';
import 'package:kermanager/widgets/screen.dart';

class StandDetailsScreen extends StatefulWidget {
  const StandDetailsScreen({
    super.key,
  });

  @override
  State<StandDetailsScreen> createState() => _StandDetailsScreenState();
}

class _StandDetailsScreenState extends State<StandDetailsScreen> {
  final StandService _standService = StandService();

  Future<StandDetailsResponse> _get() async {
    ApiResponse<StandDetailsResponse> response = await _standService.current();
    if (response.error != null) {
      throw Exception(response.error);
    }
    return response.data!;
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
                  Text(data.stock.toString()),
                  Text(data.price.toString()),
                  ElevatedButton(
                    onPressed: () {
                      context.push(
                        StandHolderRoutes.standEdit,
                      );
                    },
                    child: const Text('Edit'),
                  ),
                ],
              );
            },
          ),
        ],
      ),
    );
  }
}
