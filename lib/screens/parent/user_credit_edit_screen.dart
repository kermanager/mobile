import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:kermanager/services/stripe_service.dart';
import 'package:kermanager/theme/theme_size.dart';
import 'package:kermanager/utils/snackbar.dart';
import 'package:kermanager/utils/validator.dart';
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
          context.pop();
          SnackBarUtils.showCustomSnackBar(
            context,
            'Jetons achetés avec succès',
            SnackBarVariant.success,
          );
        },
        onCancel: () {
          SnackBarUtils.showCustomSnackBar(
            context,
            'Achat des jetons annulé',
            SnackBarVariant.success,
          );
        },
        onError: (error) {
          SnackBarUtils.showCustomSnackBar(
            context,
            "Erreur d'achat de jetons, veuillez réessayer",
            SnackBarVariant.error,
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
              validator: InputValidationUtil.validateQuantity,
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
