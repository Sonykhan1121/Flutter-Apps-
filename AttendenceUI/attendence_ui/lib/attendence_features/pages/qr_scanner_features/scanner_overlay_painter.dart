import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ScannerOverlayPainter extends CustomPainter {
  // Make the overlay parameters customizable
  final Color cornerColor;
  final double strokeWidth;
  final double cornerLengthRatio; // Corner length as a ratio of total size
  final double cornerRadiusRatio; // Corner radius as a ratio of total size

  ScannerOverlayPainter({
    this.cornerColor = Colors.green,
    this.strokeWidth = 2.5,
    this.cornerLengthRatio = 0.15, // 15% of the size
    this.cornerRadiusRatio = 0.03, // 3% of the size
  });

  @override
  void paint(Canvas canvas, Size size) {
    final width = size.width;
    final height = size.height;
    final Paint paint = Paint()
      ..color = cornerColor
      ..style = PaintingStyle.stroke
      ..strokeWidth = strokeWidth;

    // Calculate corner length and radius based on the size
    final double cornerLength = size.width * cornerLengthRatio;
    final double cornerRadius = size.width * cornerRadiusRatio;

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