import 'package:flutter/material.dart';
import 'package:kermanager/theme/theme_color.dart';
import 'package:kermanager/theme/theme_size.dart';

class ScreenSpecial extends StatefulWidget {
  final PreferredSizeWidget? appBar;
  final List<Widget> children;
  final bool? withoutBottomBar;

  const ScreenSpecial({
    super.key,
    this.appBar,
    required this.children,
    this.withoutBottomBar,
  });

  @override
  State<ScreenSpecial> createState() => _ScreenSpecialState();
}

class _ScreenSpecialState extends State<ScreenSpecial> {
  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double safeAreaHeight = MediaQuery.paddingOf(context).top;
    double appBarHeight = widget.appBar?.preferredSize.height ?? 0;
    double bottomBarHeight =
        (widget.withoutBottomBar ?? false) ? 0 : ThemeSize.s80;
    double safeHeight =
        screenHeight - appBarHeight - bottomBarHeight - safeAreaHeight;

    return Scaffold(
      appBar: widget.appBar,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(
              horizontal: ThemeSize.s16,
              vertical: ThemeSize.s16,
            ),
            constraints: BoxConstraints(
              minHeight: safeHeight,
            ),
            decoration: const BoxDecoration(
              color: ThemeColor.gray100,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: widget.children,
            ),
          ),
        ),
      ),
    );
  }
}
