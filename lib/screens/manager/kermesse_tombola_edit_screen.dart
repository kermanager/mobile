import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:kermanager/api/api_response.dart';
import 'package:kermanager/data/tombola_details_response.dart';
import 'package:kermanager/services/tombola_service.dart';
import 'package:kermanager/widgets/details_future_builder.dart';
import 'package:kermanager/widgets/number_input.dart';
import 'package:kermanager/widgets/screen.dart';
import 'package:kermanager/widgets/text_input.dart';

class KermesseTombolaEditScreen extends StatefulWidget {
  final int kermesseId;
  final int tombolaId;

  const KermesseTombolaEditScreen({
    super.key,
    required this.tombolaId,
    required this.kermesseId,
  });

  @override
  State<KermesseTombolaEditScreen> createState() =>
      _KermesseTombolaEditScreenState();
}

class _KermesseTombolaEditScreenState extends State<KermesseTombolaEditScreen> {
  final TombolaService _tombolaService = TombolaService();

  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _priceController = TextEditingController();
  final TextEditingController _giftController = TextEditingController();

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

  Future<void> _submit() async {
    ApiResponse<Null> response = await _tombolaService.edit(
      id: widget.tombolaId,
      name: _nameController.text,
      price: int.parse(_priceController.text),
      gift: _giftController.text,
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
          content: Text('Tombola edited successfully'),
        ),
      );
      context.pop();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Screen(
      children: [
        const Text(
          "Kermesse Tombola Edit",
        ),
        DetailsFutureBuilder<TombolaDetailsResponse>(
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
                NumberInput(
                  hintText: "Price",
                  controller: _priceController,
                  defaultValue: data.price.toString(),
                ),
                TextInput(
                  hintText: "Gift",
                  controller: _giftController,
                  defaultValue: data.gift,
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
    );
  }

  @override
  void dispose() {
    _nameController.dispose();
    _priceController.dispose();
    _giftController.dispose();
    super.dispose();
  }
}
