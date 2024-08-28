import 'package:flutter/material.dart';

class StartMarkerPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final blackPaint = Paint()..color = Colors.black;
    final whitePaint = Paint()..color = Colors.white;

    const double circleBlackRadius = 20;
    const double circleWhiteRadius = 7;

    canvas.drawCircle(
      Offset(circleBlackRadius, size.height - circleBlackRadius),
      circleBlackRadius,
      blackPaint,
    );

    canvas.drawCircle(
      Offset(circleBlackRadius, size.height - circleBlackRadius),
      circleWhiteRadius,
      whitePaint,
    );

    final path = Path();
    path.moveTo(40, 20);
    path.lineTo(size.width - 10, 20);
    path.lineTo(size.width - 10, 100);
    path.lineTo(40, 100);

    canvas.drawShadow(path, Colors.black, 10, false);

    canvas.drawPath(path, whitePaint);

    const blackBox = Rect.fromLTWH(40, 20, 70, 80);
    canvas.drawRect(blackBox, blackPaint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;

  @override
  bool shouldRebuildSemantics(covariant CustomPainter oldDelegate) => false;
}
