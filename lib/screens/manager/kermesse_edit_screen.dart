import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:kermanager/api/api_response.dart';
import 'package:kermanager/data/kermesse_details_response.dart';
import 'package:kermanager/services/kermesse_service.dart';
import 'package:kermanager/widgets/details_future_builder.dart';
import 'package:kermanager/widgets/screen.dart';
import 'package:kermanager/widgets/text_input.dart';

class KermesseEditScreen extends StatefulWidget {
  final int kermesseId;

  const KermesseEditScreen({
    super.key,
    required this.kermesseId,
  });

  @override
  State<KermesseEditScreen> createState() => _KermesseEditScreenState();
}

class _KermesseEditScreenState extends State<KermesseEditScreen> {
  final KermesseService _kermesseService = KermesseService();

  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();

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

  Future<void> _submit() async {
    ApiResponse<Null> response = await _kermesseService.edit(
      id: widget.kermesseId,
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
          content: Text('Kermesse edited successfully'),
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
          "Kermesse Edit",
        ),
        DetailsFutureBuilder<KermesseDetailsResponse>(
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
    _descriptionController.dispose();
    super.dispose();
  }
}
