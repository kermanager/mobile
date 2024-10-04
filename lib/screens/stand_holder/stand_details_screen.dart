import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:kermanager/api/api_response.dart';
import 'package:kermanager/data/stand_details_response.dart';
import 'package:kermanager/router/stand_holder/routes.dart';
import 'package:kermanager/services/stand_service.dart';
import 'package:kermanager/widgets/screen.dart';

class StandDetailsScreen extends StatefulWidget {
  const StandDetailsScreen({
    super.key,
  });

  @override
  State<StandDetailsScreen> createState() => _StandDetailsScreenState();
}

class _StandDetailsScreenState extends State<StandDetailsScreen> {
  final Key _key = UniqueKey();

  final StandService _standService = StandService();

  Future<StandDetailsResponse> _get() async {
    ApiResponse<StandDetailsResponse> response = await _standService.current();
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
    return Screen(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            "Stand Details",
          ),
          FutureBuilder<StandDetailsResponse>(
            key: _key,
            future: _get(),
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
                StandDetailsResponse data = snapshot.data!;
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
                      onPressed: () async {
                        await context.push(
                          StandHolderRoutes.standEdit,
                        );
                        _refresh();
                      },
                      child: const Text('Edit'),
                    ),
                  ],
                );
              }
              return const Center(
                child: Text('Something went wrong'),
              );
            },
          ),
        ],
      ),
    );
  }
}
