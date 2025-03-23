import 'dart:math' as math;
import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:table/abstract/canvas_shape.dart';
import 'package:table/constant/resizedirection.dart';

class TableShape extends CanvasShape {
  bool isExpanded = true;
  List<List<String>> cells = [
    ['Aaaaaaaaaa', 'B', 'C'],
    ['D', 'E', 'F'],
    ['D', 'E', 'F'],
  ];

  TableShape({
    required Offset position,
    required Size size,
  }) : super(position: position, size: size);

  @override
  Widget buildWidget({
    required bool isSelected,
    required VoidCallback onSelect,
    required Function(double, double) onMove,
    required Function(ResizeDirection, Offset) onResize,
    required Function(double) onRotate,
    required VoidCallback onDelete,
  }) {
    return Positioned(
      left: position.dx,
      top: position.dy,
      child: GestureDetector(
        onTap: onSelect,
        onPanUpdate: (details) {
          onMove(details.delta.dx, details.delta.dy);
        },
        child: Transform.rotate(
          angle: rotation,
          child: Stack(
            children: [
              // Main table widget
              Container(
                width: size.width,
                height: size.height,
                decoration: BoxDecoration(
                  color: Colors.white,
                  border: Border.all(color: isSelected ? Colors.blue : Colors.grey),
                  boxShadow: isSelected
                      ? [BoxShadow(color: Colors.blue.withOpacity(0.3), blurRadius: 5)]
                      : null,
                ),
                child: Column(
                  children: [
                    // Table header with controls
                    Container(
                      height: 30,
                      color: Colors.grey[200],
                      child: Row(
                        children: [
                          // Expand/collapse button
                          IconButton(
                            icon: Icon(
                              isExpanded ? Icons.keyboard_arrow_up : Icons.keyboard_arrow_down,
                              size: 16,
                            ),
                            padding: EdgeInsets.zero,
                            constraints: BoxConstraints(),
                            onPressed: () {
                              _toggleExpand();
                            },
                          ),
                          Expanded(
                            child: Center(
                              child: Text('Table', style: TextStyle(fontWeight: FontWeight.bold)),
                            ),
                          ),
                          // Add column button
                          IconButton(
                            icon: Icon(Icons.add_box_outlined, size: 16),
                            padding: EdgeInsets.zero,
                            constraints: BoxConstraints(),
                            onPressed: () {
                              _addColumn();
                            },
                          ),
                        ],
                      ),
                    ),

                    // Table content
                    if (isExpanded)
                      Expanded(
                        child: Row(
                          children: [
                            // Table cells
                            Expanded(
                              child: Column(
                                children: [
                                  // Table rows
                                  ...List.generate(cells.length, (rowIndex) {
                                    return Expanded(
                                      child: Row(
                                        children: [
                                          ...List.generate(cells[0].length, (colIndex) {
                                            return Expanded(
                                              child: Container(
                                                decoration: BoxDecoration(
                                                  border: Border.all(color: Colors.grey[300]!),
                                                ),
                                                child: TextField(
                                                  decoration: InputDecoration(
                                                    border: InputBorder.none,
                                                    contentPadding: EdgeInsets.all(4),
                                                  ),
                                                  controller: TextEditingController(text: cells[rowIndex][colIndex]),
                                                  onChanged: (value) {
                                                    cells[rowIndex][colIndex] = value;
                                                  },
                                                ),
                                              ),
                                            );
                                          }),
                                        ],
                                      ),
                                    );
                                  }),
                                ],
                              ),
                            ),

                            // Add row buttons column
                            Container(
                              width: 24,
                              child: Column(
                                children: [
                                  ...List.generate(cells.length, (index) {
                                    return Expanded(
                                      child: Container(
                                        alignment: Alignment.center,
                                        decoration: BoxDecoration(
                                          border: Border.all(color: Colors.grey[300]!),
                                        ),
                                        child: index == cells.length - 1
                                            ? IconButton(
                                          icon: Icon(Icons.add, size: 16),
                                          padding: EdgeInsets.zero,
                                          constraints: BoxConstraints(),
                                          onPressed: () {
                                            _addRow();
                                          },
                                        )
                                            : null,
                                      ),
                                    );
                                  }),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                  ],
                ),
              ),

              // Resize handles (only shown when selected)
              if (isSelected) ...[
                // Left resize handle
                Positioned(
                  left: 0,
                  top: size.height / 2,
                  child: _buildResizeHandle(
                    onDrag: (delta) => onResize(ResizeDirection.left, delta),
                  ),
                ),

                // Right resize handle
                Positioned(
                  right: 0,
                  top: size.height / 2,
                  child: _buildResizeHandle(
                    onDrag: (delta) => onResize(ResizeDirection.right, delta),
                  ),
                ),

                // Top resize handle
                Positioned(
                  left: size.width / 2,
                  top: 0,
                  child: _buildResizeHandle(
                    onDrag: (delta) => onResize(ResizeDirection.top, delta),
                  ),
                ),

                // Bottom resize handle
                Positioned(
                  left: size.width / 2,
                  bottom: 0,
                  child: _buildResizeHandle(
                    onDrag: (delta) => onResize(ResizeDirection.bottom, delta),
                  ),
                ),

                // Rotation handle (top-right)
                Positioned(
                  right: -15,
                  top: -15,
                  child: GestureDetector(
                    onPanUpdate: (details) {
                      // Calculate center of the shape
                      final centerX = size.width / 2;
                      final centerY = size.height / 2;

                      // Calculate the angle between the center and the new position
                      final dx = details.localPosition.dx - centerX;
                      final dy = details.localPosition.dy - centerY;
                      final angle = math.atan2(dy, dx);

                      onRotate(angle);
                    },
                    child: Container(
                      width: 30,
                      height: 30,
                      decoration: BoxDecoration(
                        color: Colors.blue.withOpacity(0.5),
                        shape: BoxShape.circle,
                      ),
                      child: Icon(Icons.rotate_right, size: 16, color: Colors.white),
                    ),
                  ),
                ),

                // Delete button (top-left)
                Positioned(
                  left: -15,
                  top: -15,
                  child: GestureDetector(
                    onTap: onDelete,
                    child: Container(
                      width: 30,
                      height: 30,
                      decoration: BoxDecoration(
                        color: Colors.red,
                        shape: BoxShape.circle,
                      ),
                      child: Icon(Icons.close, size: 16, color: Colors.white),
                    ),
                  ),
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }

  // Resize handle widget
  Widget _buildResizeHandle({required Function(Offset) onDrag}) {
    return GestureDetector(
      onPanUpdate: (details) {
        onDrag(details.delta);
      },
      child: Container(
        width: 12,
        height: 12,
        decoration: BoxDecoration(
          color: Colors.blue,
          shape: BoxShape.circle,
        ),
      ),
    );
  }

  // Toggle expand/collapse table
  void _toggleExpand() {
    isExpanded = !isExpanded;
  }

  // Add a new row to the table
  void _addRow() {
    final newRow = List.generate(cells[0].length, (_) => '');
    cells.add(newRow);
  }

  // Add a new column to the table
  void _addColumn() {
    for (var row in cells) {
      row.add('');
    }
  }

  @override
  void resize(ResizeDirection direction, Offset delta) {
    switch (direction) {
      case ResizeDirection.left:
        position = Offset(position.dx + delta.dx, position.dy);
        size = Size(size.width - delta.dx, size.height);
        break;
      case ResizeDirection.right:
        size = Size(size.width + delta.dx, size.height);
        break;
      case ResizeDirection.top:
        position = Offset(position.dx, position.dy + delta.dy);
        size = Size(size.width, size.height - delta.dy);
        break;
      case ResizeDirection.bottom:
        size = Size(size.width, size.height + delta.dy);
        break;
      default:
        break;
    }

    // Ensure minimum size
    if (size.width < 100) {
      size = Size(100, size.height);
    }
    if (size.height < 100) {
      size = Size(size.width, 100);
    }
  }
}