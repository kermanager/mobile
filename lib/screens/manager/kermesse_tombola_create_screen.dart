import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:kermanager/api/api_response.dart';
import 'package:kermanager/services/tombola_service.dart';
import 'package:kermanager/widgets/screen.dart';

class KermesseTombolaCreateScreen extends StatefulWidget {
  final int kermesseId;

  const KermesseTombolaCreateScreen({
    super.key,
    required this.kermesseId,
  });

  @override
  State<KermesseTombolaCreateScreen> createState() =>
      _KermesseTombolaCreateScreenState();
}

class _KermesseTombolaCreateScreenState
    extends State<KermesseTombolaCreateScreen> {
  final TombolaService _tombolaService = TombolaService();

  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _priceController = TextEditingController();
  final TextEditingController _giftController = TextEditingController();

  Future<void> _submit() async {
    ApiResponse<Null> response = await _tombolaService.create(
      kermesseId: widget.kermesseId,
      name: _nameController.text,
      price: int.parse(_priceController.text),
      gift: _giftController.text,
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
          content: Text('Tombola created successfully'),
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
            "Tombola Create",
          ),
          TextField(
            controller: _nameController,
            decoration: const InputDecoration(
              hintText: 'Name',
            ),
          ),
          TextField(
            controller: _priceController,
            decoration: const InputDecoration(
              hintText: 'Price',
            ),
          ),
          TextField(
            controller: _giftController,
            decoration: const InputDecoration(
              hintText: 'Gift',
            ),
          ),
          ElevatedButton(
            onPressed: _submit,
            child: const Text('Save'),
          ),
        ],
      ),
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
