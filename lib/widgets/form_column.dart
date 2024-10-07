import 'package:flutter/material.dart';

class FormColumn extends StatefulWidget {
  final Key formKey;
  final List<Widget> children;

  const FormColumn({
    super.key,
    required this.children,
    required this.formKey,
  });

  @override
  State<FormColumn> createState() => _FormColumnState();
}

class _FormColumnState extends State<FormColumn> {
  @override
  Widget build(BuildContext context) {
    return Form(
      key: widget.formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: widget.children,
      ),
    );
  }
}
