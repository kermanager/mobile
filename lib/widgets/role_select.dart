import 'package:flutter/material.dart';
import 'package:kermanager/theme/theme_color.dart';
import 'package:kermanager/theme/theme_font.dart';
import 'package:kermanager/theme/theme_size.dart';

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
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: ThemeColor.gray100,
        borderRadius: BorderRadius.circular(ThemeFontSize.s12),
        border: Border.all(
          color: ThemeColor.gray200,
          width: ThemeSize.s2,
        ),
      ),
      child: DropdownButtonHideUnderline(
        child: DropdownButtonFormField(
          value: widget.defaultValue,
          onChanged: (String? newValue) {
            setState(() {
              widget.onChange(newValue!);
            });
          },
          dropdownColor: ThemeColor.white,
          style: const TextStyle(
            fontFamily: ThemeFontFamily.poppins,
            fontSize: ThemeFontSize.s16,
            fontWeight: ThemeFontWeight.medium,
            color: ThemeColor.black,
          ),
          decoration: const InputDecoration(
            border: InputBorder.none,
            contentPadding: EdgeInsets.symmetric(
              horizontal: ThemeSize.s16,
              vertical: ThemeSize.s20,
            ),
          ),
          items: const [
            DropdownMenuItem(
              value: 'MANAGER',
              child: Text('Organisateur'),
            ),
            DropdownMenuItem(
              value: 'STAND_HOLDER',
              child: Text('Teneur de stand'),
            ),
            DropdownMenuItem(
              value: 'PARENT',
              child: Text('Parent'),
            ),
          ],
        ),
      ),
    );
  }
}
