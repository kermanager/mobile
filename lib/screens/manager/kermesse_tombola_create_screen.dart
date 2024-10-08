import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:kermanager/api/api_response.dart';
import 'package:kermanager/services/tombola_service.dart';
import 'package:kermanager/theme/theme_size.dart';
import 'package:kermanager/widgets/button.dart';
import 'package:kermanager/widgets/form_column.dart';
import 'package:kermanager/widgets/number_form_input.dart';
import 'package:kermanager/widgets/screen.dart';
import 'package:kermanager/widgets/text_form_input.dart';

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
  final _formKey = GlobalKey<FormState>();

  final TombolaService _tombolaService = TombolaService();

  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _priceController = TextEditingController();
  final TextEditingController _giftController = TextEditingController();

  Future<void> _submit() async {
    if (_formKey.currentState!.validate()) {
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
            content: Text('Tombola créée avec succès'),
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
        title: const Text("Lancer une tombola"),
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
            TextFormInput(
              hintText: "Cadeau",
              controller: _giftController,
              keyboardType: TextInputType.name,
            ),
            const SizedBox(height: ThemeSize.s16),
            NumberFormInput(
              hintText: "Prix de participation",
              unit: "jeton",
              controller: _priceController,
            ),
            const SizedBox(height: ThemeSize.s16),
            Button(
              label: "Lancer",
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
    _priceController.dispose();
    _giftController.dispose();
    super.dispose();
  }
}
