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
    return Stack(
        children:[
          Positioned(
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
                  clipBehavior: Clip.none,
                  children: [
                    // Main table widget with transparent background and black border
                    Container(
                      width: size.width,
                      height: size.height,
                      decoration: BoxDecoration(
                        color: Colors.transparent,
                        border: Border.all(
                            color: Colors.black,
                            width: isSelected ? 2.0 : 1.0
                        ),
                      ),
                      child: isExpanded
                          ? Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          // Table rows
                          ...List.generate(cells.length, (rowIndex) {
                            return IntrinsicHeight(
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.stretch,
                                children: [
                                  ...List.generate(cells[0].length, (colIndex) {
                                    return Expanded(
                                      child: Container(
                                        decoration: BoxDecoration(
                                          border: Border.all(color: Colors.grey, width: 0.5),
                                          color: Colors.white,
                                        ),
                                        // Fit the content precisely
                                        child: TextField(
                                          decoration: InputDecoration(
                                            border: InputBorder.none,
                                            contentPadding: EdgeInsets.symmetric(horizontal: 4, vertical: 0),
                                            isDense: true,
                                          ),
                                          style: TextStyle(fontSize: 14),
                                          textAlign: TextAlign.start,
                                          maxLines: 1,
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
                      )
                          : Container(
                        width: size.width,
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
                            Spacer(),
                          ],
                        ),
                      ),
                    ),

                    // Dynamic resize handles (only shown when selected)
                    if (isSelected) ...[
                      // Left resize handle - dynamically positioned
                      Positioned(
                        left: -10,
                        top: size.height / 2,
                        child: _buildResizeHandle(
                          onDrag: (delta) => onResize(ResizeDirection.left, delta),
                        ),
                      ),

                      // Right resize handle - dynamically positioned
                      Positioned(
                        right: -10,
                        top: size.height / 2,
                        child: _buildResizeHandle(
                          onDrag: (delta) => onResize(ResizeDirection.right, delta),
                        ),
                      ),

                      // Top resize handle - dynamically positioned
                      Positioned(
                        left: size.width / 2,
                        top: -10,
                        child: _buildResizeHandle(
                          onDrag: (delta) => onResize(ResizeDirection.top, delta),
                        ),
                      ),

                      // Bottom resize handle - dynamically positioned
                      Positioned(
                        left: size.width / 2,
                        bottom: -10,
                        child: _buildResizeHandle(
                          onDrag: (delta) => onResize(ResizeDirection.bottom, delta),
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

                      // Add column button - positioned to the right of the table
                      Positioned(
                        left: size.width + 15,
                        top: size.height / 2 - 15,
                        child: GestureDetector(
                          onTap: () {
                            _addColumn();
                          },
                          child: Container(
                            width: 30,
                            height: 30,
                            decoration: BoxDecoration(
                              color: Colors.blue,
                              shape: BoxShape.circle,
                            ),
                            child: Icon(
                                Icons.add_box_outlined,
                                size: 16,
                                color: Colors.white
                            ),
                          ),
                        ),
                      ),

                      // Add row button - positioned below the table
                      Positioned(
                        left: size.width / 2 - 15,
                        top: size.height + 15,
                        child: GestureDetector(
                          onTap: () {
                            _addRow();
                          },
                          child: Container(
                            width: 30,
                            height: 30,
                            decoration: BoxDecoration(
                              color: Colors.blue,
                              shape: BoxShape.circle,
                            ),
                            child: Icon(
                                Icons.add_box,
                                size: 16,
                                color: Colors.white
                            ),
                          ),
                        ),
                      ),
                    ],
                  ],
                ),
              ),
            ),
          ),
          // Rotation button positioned outside the table
          Positioned(
            top: position.dy - 50, // Positioned above the table
            left: position.dx + size.width / 2 - 25, // Centered horizontally
            child: GestureDetector(
              onTap: () {
                print('Click Rotation');
                onRotate(rotation + math.pi / 2); // Rotate by 90 degrees
              },
              child: Container(
                width: 50,
                height: 50,
                decoration: BoxDecoration(
                  color: isSelected ? Colors.blue.withOpacity(0.5) : Colors.transparent,
                  shape: BoxShape.circle,
                ),
                child: Icon(
                    Icons.rotate_right,
                    size: 24,
                    color: isSelected ? Colors.white : Colors.transparent
                ),
              ),
            ),
          ),
        ]
    );
  }

  // Resize handle widget with improved visual appearance
  Widget _buildResizeHandle({required Function(Offset) onDrag}) {
    return GestureDetector(
      onPanUpdate: (details) {
        onDrag(details.delta);
      },
      child: Container(
        width: 20,
        height: 20,
        decoration: BoxDecoration(
          color: Colors.blue,
          shape: BoxShape.circle,
          border: Border.all(color: Colors.white, width: 2),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.3),
              blurRadius: 3,
              offset: Offset(1, 1),
            ),
          ],
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
