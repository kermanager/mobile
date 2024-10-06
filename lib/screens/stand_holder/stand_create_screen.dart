import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:kermanager/api/api_response.dart';
import 'package:kermanager/providers/auth_provider.dart';
import 'package:kermanager/router/stand_holder/routes.dart';
import 'package:kermanager/services/stand_service.dart';
import 'package:kermanager/widgets/number_input.dart';
import 'package:kermanager/widgets/screen.dart';
import 'package:kermanager/widgets/stand_type_select.dart';
import 'package:kermanager/widgets/text_input.dart';
import 'package:provider/provider.dart';

class StandCreateScreen extends StatefulWidget {
  const StandCreateScreen({super.key});

  @override
  State<StandCreateScreen> createState() => _StandCreateScreenState();
}

class _StandCreateScreenState extends State<StandCreateScreen> {
  final StandService _standService = StandService();

  String _selectedType = "ACTIVITY";
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  final TextEditingController _priceController = TextEditingController();
  final TextEditingController _stockController = TextEditingController();

  Future<void> _submit() async {
    ApiResponse<Null> response = await _standService.create(
      type: _selectedType,
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
          content: Text('Stand created successfully'),
        ),
      );
      Provider.of<AuthProvider>(context, listen: false).setHasStand(true);
      context.go(StandHolderRoutes.kermesseList);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Screen(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            "Stand Create",
          ),
          StandTypeSelect(
            defaultValue: _selectedType,
            onChange: (value) {
              setState(() {
                _selectedType = value;
              });
            },
          ),
          TextInput(
            hintText: "Name",
            controller: _nameController,
          ),
          TextInput(
            hintText: "Description",
            controller: _descriptionController,
          ),
          NumberInput(
            hintText: "Price",
            controller: _priceController,
          ),
          NumberInput(
            hintText: "Stock",
            controller: _stockController,
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
    _descriptionController.dispose();
    _priceController.dispose();
    _stockController.dispose();
    super.dispose();
  }
}
