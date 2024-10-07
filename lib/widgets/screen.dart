import 'package:flutter/material.dart';
import 'package:kermanager/theme/theme_size.dart';

class Screen extends StatefulWidget {
  final PreferredSizeWidget? appBar;
  final List<Widget> children;

  const Screen({
    super.key,
    this.appBar,
    required this.children,
  });

  @override
  State<Screen> createState() => _ScreenState();
}

class _ScreenState extends State<Screen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: widget.appBar,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: ThemeSize.s16,
              vertical: ThemeSize.s16,
            ),
            child: SizedBox(
              width: double.infinity,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: widget.children,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
