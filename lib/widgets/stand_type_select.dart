import 'package:flutter/material.dart';

class StandTypeSelect extends StatefulWidget {
  final String defaultValue;
  final Function(String) onChange;

  const StandTypeSelect({
    super.key,
    required this.defaultValue,
    required this.onChange,
  });

  @override
  State<StandTypeSelect> createState() => _StandTypeSelectState();
}

class _StandTypeSelectState extends State<StandTypeSelect> {
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
          value: 'ACTIVITY',
          child: Text('Activity'),
        ),
        DropdownMenuItem(
          value: 'CONSUMPTION',
          child: Text('Consumption'),
        ),
      ],
    );
  }
}
