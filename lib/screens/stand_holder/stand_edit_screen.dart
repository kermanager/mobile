import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:kermanager/api/api_response.dart';
import 'package:kermanager/data/stand_details_response.dart';
import 'package:kermanager/services/stand_service.dart';
import 'package:kermanager/theme/theme_size.dart';
import 'package:kermanager/widgets/button.dart';
import 'package:kermanager/widgets/details_future_builder.dart';
import 'package:kermanager/widgets/form_column.dart';
import 'package:kermanager/widgets/number_form_input.dart';
import 'package:kermanager/widgets/screen.dart';
import 'package:kermanager/widgets/text_area_form_input.dart';
import 'package:kermanager/widgets/text_form_input.dart';

class StandEditScreen extends StatefulWidget {
  const StandEditScreen({
    super.key,
  });

  @override
  State<StandEditScreen> createState() => _StandEditScreenState();
}

class _StandEditScreenState extends State<StandEditScreen> {
  final _formKey = GlobalKey<FormState>();

  final StandService _standService = StandService();

  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  final TextEditingController _priceController = TextEditingController();
  final TextEditingController _stockController = TextEditingController();

  Future<StandDetailsResponse> _get() async {
    ApiResponse<StandDetailsResponse> response = await _standService.current();
    if (response.error != null) {
      throw Exception(response.error!);
    }
    return response.data!;
  }

  Future<void> _submit() async {
    if (_formKey.currentState!.validate()) {
      ApiResponse<Null> response = await _standService.edit(
        name: _nameController.text,
        description: _descriptionController.text,
        price: int.parse(_priceController.text),
        stock: int.parse(_stockController.text),
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
            content: Text('Stand modifié avec succès'),
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
        title: const Text("Modifier mon stand"),
      ),
      children: [
        DetailsFutureBuilder<StandDetailsResponse>(
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
                    NumberFormInput(
                      hintText: "Prix",
                      unit: "jeton",
                      controller: _priceController,
                      defaultValue: data.price.toString(),
                    ),
                    const SizedBox(height: ThemeSize.s16),
                    data.type == "CONSUMPTION"
                        ? Column(
                            children: [
                              NumberFormInput(
                                hintText: "Stock",
                                unit: "pièce",
                                controller: _stockController,
                                defaultValue: data.stock.toString(),
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
                              defaultValue: data.stock.toString(),
                            ),
                          ),
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
    _priceController.dispose();
    _stockController.dispose();
    super.dispose();
  }
}
