import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:kermanager/api/api_response.dart';
import 'package:kermanager/services/kermesse_service.dart';
import 'package:kermanager/widgets/screen.dart';

class KermesseCreateScreen extends StatefulWidget {
  const KermesseCreateScreen({super.key});

  @override
  State<KermesseCreateScreen> createState() => _KermesseCreateScreenState();
}

class _KermesseCreateScreenState extends State<KermesseCreateScreen> {
  final KermesseService _kermesseService = KermesseService();

  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();

  Future<void> _submit() async {
    ApiResponse<Null> response = await _kermesseService.create(
      name: _nameController.text,
      description: _descriptionController.text,
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
          content: Text('Kermesse created successfully'),
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
          "Kermesse Create",
        ),
        TextField(
          controller: _nameController,
          decoration: const InputDecoration(
            hintText: 'Name',
          ),
        ),
        TextField(
          controller: _descriptionController,
          decoration: const InputDecoration(
            hintText: 'Description',
          ),
        ),
        ElevatedButton(
          onPressed: _submit,
          child: const Text('Save'),
        ),
      ],
    );
  }

  @override
  void dispose() {
    _nameController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }
}
