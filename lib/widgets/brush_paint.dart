import 'package:flutter/material.dart';

class BrushPaint extends CustomPainter {
  final List<Offset?> points;

  BrushPaint(this.points);

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = const Color(0xff346391)
      ..style = PaintingStyle.fill
      ..strokeCap = StrokeCap.round
      ..strokeWidth = 15.0;

    for (int i = 0; i < points.length - 1; i++) {
      if (points[i] != null && points[i + 1] != null) {
        canvas.drawLine(points[i]!, points[i + 1]!, paint);
      }
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
