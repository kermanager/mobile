import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:kermanager/api/api_response.dart';
import 'package:kermanager/services/kermesse_service.dart';
import 'package:kermanager/theme/theme_size.dart';
import 'package:kermanager/widgets/button.dart';
import 'package:kermanager/widgets/form_column.dart';
import 'package:kermanager/widgets/screen.dart';
import 'package:kermanager/widgets/text_area_form_input.dart';
import 'package:kermanager/widgets/text_form_input.dart';

class KermesseCreateScreen extends StatefulWidget {
  const KermesseCreateScreen({super.key});

  @override
  State<KermesseCreateScreen> createState() => _KermesseCreateScreenState();
}

class _KermesseCreateScreenState extends State<KermesseCreateScreen> {
  final _formKey = GlobalKey<FormState>();

  final KermesseService _kermesseService = KermesseService();

  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();

  Future<void> _submit() async {
    if (_formKey.currentState!.validate()) {
      ApiResponse<Null> response = await _kermesseService.create(
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
            content: Text('Kermesse created successfully'),
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
        title: const Text('Créer une kermesse'),
      ),
      children: [
        FormColumn(
          formKey: _formKey,
          children: [
            TextFormInput(
              hintText: "Nom",
              controller: _nameController,
              keyboardType: TextInputType.name,
            ),
            const SizedBox(height: ThemeSize.s16),
            TextAreaFormInput(
              hintText: "Description",
              controller: _descriptionController,
            ),
            const SizedBox(height: ThemeSize.s16),
            Button(
              label: "Enregistrer",
              onTap: _submit,
            ),
          ],
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
