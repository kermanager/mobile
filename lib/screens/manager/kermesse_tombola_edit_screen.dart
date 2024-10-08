import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:kermanager/api/api_response.dart';
import 'package:kermanager/data/tombola_details_response.dart';
import 'package:kermanager/services/tombola_service.dart';
import 'package:kermanager/theme/theme_size.dart';
import 'package:kermanager/utils/snackbar.dart';
import 'package:kermanager/widgets/button.dart';
import 'package:kermanager/widgets/details_future_builder.dart';
import 'package:kermanager/widgets/form_column.dart';
import 'package:kermanager/widgets/number_form_input.dart';
import 'package:kermanager/widgets/screen.dart';
import 'package:kermanager/widgets/text_form_input.dart';

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
  final _formKey = GlobalKey<FormState>();

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
      throw Exception(response.error!);
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
      SnackBarUtils.showCustomSnackBar(
        context,
        response.error!,
        SnackBarVariant.error,
      );
    } else {
      SnackBarUtils.showCustomSnackBar(
        context,
        'Tombola modifiée avec succès',
        SnackBarVariant.success,
      );
      context.pop();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Screen(
      appBar: AppBar(
        title: const Text("Modifier la tombola"),
      ),
      children: [
        DetailsFutureBuilder<TombolaDetailsResponse>(
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
                    TextFormInput(
                      hintText: "Cadeau",
                      controller: _giftController,
                      defaultValue: data.gift,
                      keyboardType: TextInputType.name,
                    ),
                    const SizedBox(height: ThemeSize.s16),
                    NumberFormInput(
                      hintText: "Prix de participation",
                      unit: "jeton",
                      controller: _priceController,
                      defaultValue: data.price.toString(),
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
    _priceController.dispose();
    _giftController.dispose();
    super.dispose();
  }
}
