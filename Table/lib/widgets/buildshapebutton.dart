
import 'package:flutter/material.dart';

class buildShapeButton extends StatefulWidget {
  IconData icon;
  String label;
  VoidCallback onPressed;
   buildShapeButton({required this.icon, required this.label,required this.onPressed,super.key});

  @override
  State<buildShapeButton> createState() => _buildShapeButtonState();
}

class _buildShapeButtonState extends State<buildShapeButton> {
  @override
  Widget build(BuildContext context) {
      return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          ElevatedButton(
            onPressed: widget.onPressed,
            style: ElevatedButton.styleFrom(
              shape: CircleBorder(),
              padding: EdgeInsets.all(16),
            ),
            child: Icon(widget.icon, size: 24),
          ),
          SizedBox(height: 4),
          Text(widget.label),
        ],
      ),
    );
  }
}
