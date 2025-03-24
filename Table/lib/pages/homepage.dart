import 'package:flutter/material.dart';
import 'package:table/abstract/canvas_shape.dart';
import 'package:table/constant/resizedirection.dart';
import 'package:table/shapes/tableshape.dart';
import 'package:table/widgets/buildshapebutton.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  Offset position = Offset(100, 100);
  List<CanvasShape> shapes = [];
  CanvasShape? selectedShape;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Canvas')),
      body: Column(
        children: [
          Expanded(
            flex: 7,
            child: Stack(
              children: [

                SizedBox(height:10),
                Container(color: Colors.grey[200]),
                // Positioned(
                //   left: position.dx,
                //   top: position.dy,
                //   child: GestureDetector(
                //     onPanUpdate : (value)
                //     {
                //       setState(() {
                //         position+= value.delta;
                //       });
                //
                //     },
                //     child: Container(
                //       height: 100,
                //       width: 100,
                //       color: Colors.red,
                //       child: Center(child: Text('Red')),
                //     ),
                //   ),
                // ),
                ...shapes.map(
                  (shape) => shape.buildWidget(
                    isSelected: shape == selectedShape,
                    onSelect: () => _selectShape(shape),
                    onMove: (dx, dy) {
                     _moveShape(shape,dx,dy);
                    },
                    onResize: (dir, off) {
                      _resizeShape(shape, dir, off);
                    },
                    onRotate: (angle) {
                      _rotateShape(shape, angle);
                    },
                    onDelete: () {
                      _deleteShape(shape);
                    },
                  ),
                ),
              ],
            ),
          ),
          Expanded(
              flex: 2,
              child: Container(
                  color: Colors.white,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    buildShapeButton(icon: Icons.table_chart_outlined, label: 'Table', onPressed: _addTable),
                  ],
                ),
              ),
          ),
        ],
      ),
    );
  }

  void _selectShape(CanvasShape shape) {
    setState(() {
      selectedShape = shape;
    });
  }

  void _moveShape(CanvasShape shape, double dx, double dy) {
    setState(() {
      shape.position = Offset(shape.position.dx+dx, shape.position.dy+dy);
    });
  }

  void _resizeShape(CanvasShape shape, ResizeDirection dir, Offset off) {
    setState(() {

      shape.resize(dir, off);
    });
  }

  void _rotateShape(CanvasShape shape, double angle) {
    setState(() {
      shape.rotation = angle;
    });
  }

  void _deleteShape(CanvasShape shape) {
    setState(() {
      shapes.remove(shape);
      if(selectedShape == shape)
        {
          selectedShape = null;
        }
    });
  }

  void _addTable() {
    setState(() {
      final newTable = TableShape(position: Offset(MediaQuery.of(context).size.width/4, MediaQuery.of(context).size.height/4), size: Size(250, 200));
      shapes.add(newTable);
      selectedShape= newTable;
    });
  }
}
