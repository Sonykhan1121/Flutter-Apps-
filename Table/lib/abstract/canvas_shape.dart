import 'package:flutter/material.dart';

import '../constant/resizedirection.dart';

abstract class CanvasShape {
  Offset position;
  Size size;
  double rotation;

  CanvasShape({
    required this.position,
    required this.size,
    this.rotation = 0.0,
  });

  Widget buildWidget({
    required bool isSelected,
    required VoidCallback onSelect,
    required Function(double, double) onMove,
    required Function(ResizeDirection, Offset) onResize,
    required Function(double) onRotate,
    required VoidCallback onDelete,
  });

  void resize(ResizeDirection direction, Offset delta);
}