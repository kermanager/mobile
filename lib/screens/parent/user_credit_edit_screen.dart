import 'package:flutter/material.dart';
import 'package:kermanager/services/stripe_service.dart';
import 'package:kermanager/widgets/number_input.dart';
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
  final StripeService _stripeService = StripeService();

  final TextEditingController _creditController = TextEditingController();

  Future<void> _submit() async {
    await _stripeService.stripePaymentCheckout(
      widget.userId,
      int.parse(_creditController.text),
      context,
      onSuccess: () {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Credit buyed successfully'),
          ),
        );
      },
      onCancel: () {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Credit buying canceled'),
          ),
        );
      },
      onError: (error) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Credit buying error'),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Screen(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            "Credit Edit",
          ),
          NumberInput(
            controller: _creditController,
            hintText: "Points",
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
    _creditController.dispose();
    super.dispose();
  }
}
