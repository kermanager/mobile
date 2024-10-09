import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:kermanager/api/api_response.dart';
import 'package:kermanager/providers/auth_provider.dart';
import 'package:kermanager/router/stand_holder/routes.dart';
import 'package:kermanager/services/stand_service.dart';
import 'package:kermanager/theme/theme_size.dart';
import 'package:kermanager/utils/snackbar.dart';
import 'package:kermanager/utils/validator.dart';
import 'package:kermanager/widgets/button.dart';
import 'package:kermanager/widgets/form_column.dart';
import 'package:kermanager/widgets/number_form_input.dart';
import 'package:kermanager/widgets/screen.dart';
import 'package:kermanager/widgets/stand_type_select.dart';
import 'package:kermanager/widgets/text_area_form_input.dart';
import 'package:kermanager/widgets/text_form_input.dart';
import 'package:provider/provider.dart';

class StandCreateScreen extends StatefulWidget {
  const StandCreateScreen({super.key});

  @override
  State<StandCreateScreen> createState() => _StandCreateScreenState();
}

class _StandCreateScreenState extends State<StandCreateScreen> {
  final _formKey = GlobalKey<FormState>();

  final StandService _standService = StandService();

  String _selectedType = "ACTIVITY";
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  final TextEditingController _priceController = TextEditingController();
  final TextEditingController _stockController = TextEditingController();

  Future<void> _submit() async {
    if (_formKey.currentState!.validate()) {
      ApiResponse<Null> response = await _standService.create(
        type: _selectedType,
        name: _nameController.text,
        description: _descriptionController.text,
        price: int.parse(_priceController.text),
        stock: int.parse(_stockController.text),
      );
      if (response.error != null) {
        SnackBarUtils.showCustomSnackBar(
          context,
          response.error!,
          SnackBarVariant.error,
        );
      } else {
        Provider.of<AuthProvider>(context, listen: false).setHasStand(true);
        SnackBarUtils.showCustomSnackBar(
          context,
          'Stand créé avec succès',
          SnackBarVariant.success,
        );
        context.go(StandHolderRoutes.standDetails);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Screen(
      appBar: AppBar(
        title: const Text("Créer mon stand"),
      ),
      children: [
        FormColumn(
          formKey: _formKey,
          children: [
            StandTypeSelect(
              defaultValue: _selectedType,
              onChange: (value) {
                setState(() {
                  _selectedType = value;
                });
              },
            ),
            const SizedBox(height: ThemeSize.s16),
            TextFormInput(
              hintText: "Nom",
              controller: _nameController,
              keyboardType: TextInputType.name,
              validator: InputValidationUtil.validateName,
            ),
            const SizedBox(height: ThemeSize.s16),
            TextAreaFormInput(
              hintText: "Description",
              controller: _descriptionController,
            ),
            const SizedBox(height: ThemeSize.s16),
            NumberFormInput(
              hintText: "Prix",
              unit: "jeton",
              controller: _priceController,
              validator: InputValidationUtil.validateNumber,
            ),
            const SizedBox(height: ThemeSize.s16),
            _selectedType == "CONSUMPTION"
                ? Column(
                    children: [
                      NumberFormInput(
                        hintText: "Stock",
                        unit: "pièce",
                        controller: _stockController,
                        validator: InputValidationUtil.validateNumber,
                      ),
                      const SizedBox(height: ThemeSize.s16),
                    ],
                  )
                : SizedBox(
                    width: 0,
                    height: 0,
                    child: NumberFormInput(
                      hintText: "Stock",
                      unit: "pièce",
                      controller: _stockController,
                      defaultValue: "0",
                      validator: InputValidationUtil.validateNumber,
                    ),
                  ),
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
    _priceController.dispose();
    _stockController.dispose();
    super.dispose();
  }
}
