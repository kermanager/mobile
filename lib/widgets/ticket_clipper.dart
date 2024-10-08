import 'package:flutter/material.dart';
import 'package:kermanager/theme/theme_size.dart';

class TicketClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    final path = Path();
    // radius
    path.addRRect(
      RRect.fromRectAndRadius(
        Rect.fromLTWH(0, 0, size.width, size.height),
        const Radius.circular(ThemeSize.s12),
      ),
    );
    // left round in
    path.addOval(
      Rect.fromCircle(
        center: Offset(0, size.height - 348),
        radius: 10,
      ),
    );
    // right round in
    path.addOval(
      Rect.fromCircle(
        center: Offset(size.width, size.height - 348),
        radius: 10,
      ),
    );
    // horizontal line dash
    const dashWidth = 10;
    const dashSpace = 5;
    final dashCount = size.width ~/ (dashWidth + dashSpace) - 1;
    for (var i = 0; i < dashCount; i++) {
      path.addRect(
        Rect.fromLTWH(
          i * (dashWidth + dashSpace).toDouble() + 10,
          size.height - 348,
          dashWidth.toDouble(),
          1,
        ),
      );
    }
    path.fillType = PathFillType.evenOdd;
    return path;
  }

  @override
  bool shouldReclip(CustomClipper oldClipper) {
    return true;
  }
}
