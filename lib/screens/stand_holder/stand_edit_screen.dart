import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:kermanager/api/api_response.dart';
import 'package:kermanager/data/stand_details_response.dart';
import 'package:kermanager/services/stand_service.dart';
import 'package:kermanager/widgets/details_future_builder.dart';
import 'package:kermanager/widgets/number_input.dart';
import 'package:kermanager/widgets/screen.dart';
import 'package:kermanager/widgets/text_input.dart';

class StandEditScreen extends StatefulWidget {
  const StandEditScreen({
    super.key,
  });

  @override
  State<StandEditScreen> createState() => _StandEditScreenState();
}

class _StandEditScreenState extends State<StandEditScreen> {
  final StandService _standService = StandService();

  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  final TextEditingController _priceController = TextEditingController();
  final TextEditingController _stockController = TextEditingController();

  Future<StandDetailsResponse> _get() async {
    ApiResponse<StandDetailsResponse> response = await _standService.current();
    if (response.error != null) {
      throw Exception(response.errorMessage);
    }
    return response.data!;
  }

  Future<void> _submit() async {
    ApiResponse<Null> response = await _standService.edit(
      name: _nameController.text,
      description: _descriptionController.text,
      price: int.parse(_priceController.text),
      stock: int.parse(_stockController.text),
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
          content: Text('Stand edited successfully'),
        ),
      );
      context.pop();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Screen(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            "Stand Edit",
          ),
          DetailsFutureBuilder<StandDetailsResponse>(
            future: _get,
            builder: (context, data) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  TextInput(
                    hintText: "Name",
                    controller: _nameController,
                    defaultValue: data.name,
                  ),
                  TextInput(
                    hintText: "Description",
                    controller: _descriptionController,
                    defaultValue: data.description,
                  ),
                  NumberInput(
                    hintText: "Price",
                    controller: _priceController,
                    defaultValue: data.price.toString(),
                  ),
                  NumberInput(
                    hintText: "Stock",
                    controller: _stockController,
                    defaultValue: data.stock.toString(),
                  ),
                  ElevatedButton(
                    onPressed: _submit,
                    child: const Text('Save'),
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
    _nameController.dispose();
    _descriptionController.dispose();
    _priceController.dispose();
    _stockController.dispose();
    super.dispose();
  }
}
