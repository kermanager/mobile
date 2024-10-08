import 'package:flutter/material.dart';
import 'package:kermanager/services/stripe_service.dart';
import 'package:kermanager/theme/theme_size.dart';
import 'package:kermanager/widgets/button.dart';
import 'package:kermanager/widgets/form_column.dart';
import 'package:kermanager/widgets/number_form_input.dart';
import 'package:kermanager/widgets/screen.dart';

class UserCreditEditScreen extends StatefulWidget {
  final int userId;

  const UserCreditEditScreen({
    super.key,
    required this.userId,
  });

  @override
  State<UserCreditEditScreen> createState() => _UserCreditEditScreenState();
}

class _UserCreditEditScreenState extends State<UserCreditEditScreen> {
  final _formKey = GlobalKey<FormState>();

  final StripeService _stripeService = StripeService();

  final TextEditingController _creditController = TextEditingController();

  Future<void> _submit() async {
    if (_formKey.currentState!.validate()) {
      await _stripeService.stripePaymentCheckout(
        widget.userId,
        int.parse(_creditController.text),
        context,
        onSuccess: () {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Jetons achetés avec succès'),
            ),
          );
        },
        onCancel: () {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Achat des jetons annulé'),
            ),
          );
        },
        onError: (error) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Erreur d\'achat de jetons'),
            ),
          );
        },
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Screen(
      appBar: AppBar(
        title: const Text('Acheter des jetons'),
      ),
      children: [
        FormColumn(
          formKey: _formKey,
          children: [
            NumberFormInput(
              hintText: "Nombre de jetons",
              unit: "jeton",
              controller: _creditController,
            ),
            const SizedBox(height: ThemeSize.s16),
            Button(
              onTap: _submit,
              label: 'Payer',
            ),
          ],
        ),
      ],
    );
  }

  @override
  void dispose() {
    _creditController.dispose();
    super.dispose();
  }
}
