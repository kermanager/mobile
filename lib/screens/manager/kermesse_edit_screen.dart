import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:kermanager/api/api_response.dart';
import 'package:kermanager/data/kermesse_details_response.dart';
import 'package:kermanager/services/kermesse_service.dart';
import 'package:kermanager/theme/theme_size.dart';
import 'package:kermanager/widgets/button.dart';
import 'package:kermanager/widgets/details_future_builder.dart';
import 'package:kermanager/widgets/form_column.dart';
import 'package:kermanager/widgets/screen.dart';
import 'package:kermanager/widgets/text_area_form_input.dart';
import 'package:kermanager/widgets/text_form_input.dart';

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
  final _formKey = GlobalKey<FormState>();

  final KermesseService _kermesseService = KermesseService();

  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();

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

  Future<void> _submit() async {
    if (_formKey.currentState!.validate()) {
      ApiResponse<Null> response = await _kermesseService.edit(
        id: widget.kermesseId,
        name: _nameController.text,
        description: _descriptionController.text,
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
            content: Text('Kermesse modifiée avec succès'),
          ),
        );
        context.pop();
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Screen(
      appBar: AppBar(
        title: const Text("Modifier la kermesse"),
      ),
      children: [
        DetailsFutureBuilder<KermesseDetailsResponse>(
          future: _get,
          builder: (context, data) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                FormColumn(
                  formKey: _formKey,
                  children: [
                    TextFormInput(
                      hintText: "Nom",
                      controller: _nameController,
                      defaultValue: data.name,
                      keyboardType: TextInputType.name,
                    ),
                    const SizedBox(height: ThemeSize.s16),
                    TextAreaFormInput(
                      hintText: "Description",
                      controller: _descriptionController,
                      defaultValue: data.description,
                    ),
                    const SizedBox(height: ThemeSize.s16),
                    Button(
                      label: "Modifier",
                      onTap: _submit,
                    ),
                  ],
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
