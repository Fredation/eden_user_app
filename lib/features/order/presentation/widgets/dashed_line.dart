import 'package:eden_user_app/core/data_utils/colors.dart';
import 'package:flutter/material.dart';

class DashedLineVerticalPainter extends CustomPainter {
  final Color? color;

  DashedLineVerticalPainter({this.color});

  @override
  void paint(Canvas canvas, Size size) {
    const double dashHeight = 3;
    const double dashSpace = 5;
    double startY = 0;
    final paint = Paint()
      ..color = color ?? EdenColors.cardGrey
      ..strokeWidth = 1;
    while (startY < size.height) {
      canvas.drawLine(Offset(0, startY), Offset(0, startY + dashHeight), paint);
      startY += dashHeight + dashSpace;
    }
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}
