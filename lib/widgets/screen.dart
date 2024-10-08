import 'package:flutter/material.dart';
import 'package:kermanager/theme/theme_color.dart';
import 'package:kermanager/theme/theme_size.dart';

class Screen extends StatefulWidget {
  final PreferredSizeWidget? appBar;
  final List<Widget> children;
  final bool? withoutBottomBar;

  const Screen({
    super.key,
    this.appBar,
    required this.children,
    this.withoutBottomBar,
  });

  @override
  State<Screen> createState() => _ScreenState();
}

class _ScreenState extends State<Screen> {
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
              vertical: ThemeSize.s24,
            ),
            constraints: BoxConstraints(
              minHeight: safeHeight,
            ),
            decoration: BoxDecoration(
              color: ThemeColor.white,
              borderRadius: BorderRadius.circular(ThemeSize.s24),
              border: Border.all(color: ThemeColor.gray200),
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
