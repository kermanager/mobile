import 'package:flutter/material.dart';
import 'package:kermanager/theme/theme_color.dart';
import 'package:kermanager/theme/theme_font.dart';
import 'package:kermanager/theme/theme_size.dart';

class BalanceLabel extends StatefulWidget {
  final int balance;

  const BalanceLabel({
    super.key,
    required this.balance,
  });

  @override
  State<BalanceLabel> createState() => _BalanceLabelState();
}

class _BalanceLabelState extends State<BalanceLabel> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: ThemeColor.gray100,
        borderRadius: BorderRadius.circular(ThemeSize.s24),
        border: Border.all(color: ThemeColor.gray200),
      ),
      padding: const EdgeInsets.only(
        top: ThemeSize.s8,
        bottom: ThemeSize.s8,
        left: ThemeSize.s8,
        right: ThemeSize.s16,
      ),
      child: Row(
        children: [
          const Icon(
            Icons.monetization_on,
            color: ThemeColor.primary,
            size: ThemeFontSize.s32,
          ),
          const SizedBox(width: ThemeSize.s8),
          Text(
            widget.balance.toString(),
            style: const TextStyle(
              fontSize: ThemeFontSize.s18,
              fontWeight: ThemeFontWeight.semiBold,
              color: ThemeColor.black,
            ),
          )
        ],
      ),
    );
  }
}
