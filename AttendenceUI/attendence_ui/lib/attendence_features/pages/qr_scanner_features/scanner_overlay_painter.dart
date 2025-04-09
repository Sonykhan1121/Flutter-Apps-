import 'package:flutter/material.dart';

class ScannerOverlayPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final width = size.width;
    final height = size.height;
    final Paint paint = Paint()
      ..color = Colors.blue.shade800
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2.5;

    final double cornerLength = 30;
    final double cornerRadius = 8;

    // Top left corner
    _drawCorner(
      canvas,
      paint,
      Offset(0, 0),
      cornerLength,
      cornerRadius,
      topLeft: true,
    );

    // Top right corner
    _drawCorner(
      canvas,
      paint,
      Offset(width, 0),
      cornerLength,
      cornerRadius,
      topRight: true,
    );

    // Bottom left corner
    _drawCorner(
      canvas,
      paint,
      Offset(0, height),
      cornerLength,
      cornerRadius,
      bottomLeft: true,
    );

    // Bottom right corner
    _drawCorner(
      canvas,
      paint,
      Offset(width, height),
      cornerLength,
      cornerRadius,
      bottomRight: true,
    );
  }

  void _drawCorner(
      Canvas canvas,
      Paint paint,
      Offset position,
      double length,
      double radius,
      {bool topLeft = false, bool topRight = false, bool bottomLeft = false, bool bottomRight = false}
      ) {
    if (topLeft) {
      canvas.drawArc(
        Rect.fromCircle(center: Offset(position.dx + radius, position.dy + radius), radius: radius),
        3.14 * 1, // π rad = 180°
        3.14 / 2, // π/2 rad = 90°
        false,
        paint,
      );
      canvas.drawLine(
        Offset(position.dx + radius, position.dy),
        Offset(position.dx + length, position.dy),
        paint,
      );
      canvas.drawLine(
        Offset(position.dx, position.dy + radius),
        Offset(position.dx, position.dy + length),
        paint,
      );
    } else if (topRight) {
      canvas.drawArc(
        Rect.fromCircle(center: Offset(position.dx - radius, position.dy + radius), radius: radius),
        3.14 * 3/2, // 3π/2 rad = 270°
        3.14 / 2, // π/2 rad = 90°
        false,
        paint,
      );
      canvas.drawLine(
        Offset(position.dx - radius, position.dy),
        Offset(position.dx - length, position.dy),
        paint,
      );
      canvas.drawLine(
        Offset(position.dx, position.dy + radius),
        Offset(position.dx, position.dy + length),
        paint,
      );
    } else if (bottomLeft) {
      canvas.drawArc(
        Rect.fromCircle(center: Offset(position.dx + radius, position.dy - radius), radius: radius),
        3.14 / 2, // π/2 rad = 90°
        3.14 / 2, // π/2 rad = 90°
        false,
        paint,
      );
      canvas.drawLine(
        Offset(position.dx + radius, position.dy),
        Offset(position.dx + length, position.dy),
        paint,
      );
      canvas.drawLine(
        Offset(position.dx, position.dy - radius),
        Offset(position.dx, position.dy - length),
        paint,
      );
    } else if (bottomRight) {
      canvas.drawArc(
        Rect.fromCircle(center: Offset(position.dx - radius, position.dy - radius), radius: radius),
        0,
        3.14 / 2, // π/2 rad = 90°
        false,
        paint,
      );
      canvas.drawLine(
        Offset(position.dx - radius, position.dy),
        Offset(position.dx - length, position.dy),
        paint,
      );
      canvas.drawLine(
        Offset(position.dx, position.dy - radius),
        Offset(position.dx, position.dy - length),
        paint,
      );
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}