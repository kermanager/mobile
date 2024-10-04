import 'package:flutter/material.dart';

class RoleSelect extends StatefulWidget {
  final String defaultValue;
  final Function(String) onChange;

  const RoleSelect({
    super.key,
    required this.defaultValue,
    required this.onChange,
  });

  @override
  State<RoleSelect> createState() => _RoleSelectState();
}

class _RoleSelectState extends State<RoleSelect> {
  @override
  Widget build(BuildContext context) {
    return DropdownButton<String>(
      value: widget.defaultValue,
      onChanged: (String? newValue) {
        setState(() {
          widget.onChange(newValue!);
        });
      },
      items: const [
        DropdownMenuItem(
          value: 'MANAGER',
          child: Text('Manager'),
        ),
        DropdownMenuItem(
          value: 'STAND_HOLDER',
          child: Text('Stand Holder'),
        ),
        DropdownMenuItem(
          value: 'PARENT',
          child: Text('Parent'),
        ),
      ],
    );
  }
}
