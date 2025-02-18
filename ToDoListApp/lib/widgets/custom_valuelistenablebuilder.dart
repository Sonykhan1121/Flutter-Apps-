import 'dart:io';
import 'dart:typed_data';
import 'dart:ui' as ui;
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:path_provider/path_provider.dart';
import 'package:provider/provider.dart';
import 'package:to_do_list/widgets/painters/signaturepainter.dart';

import '../pages/add_task_page.dart';
import '../providers/task_provider.dart';

class CustomValuelistenablebuilder extends StatefulWidget {
  final ThemeData themeData;

  const CustomValuelistenablebuilder({super.key,required this.themeData});

  @override
  State<CustomValuelistenablebuilder> createState() => _CustomValuelistenablebuilderState();
}

class _CustomValuelistenablebuilderState extends State<CustomValuelistenablebuilder> {
  final GlobalKey _globalKey = GlobalKey();
  bool isFabOpen = false;
  @override
  Widget build(BuildContext context) {

    return ValueListenableBuilder(  //it's rebuild some portion of the page  not the whole page
      valueListenable: ValueNotifier(isFabOpen),
      builder: (context, value, child) {
        return isFabOpen
            ? Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            FloatingActionButton(
              onPressed: () {
                setState(() {
                  isFabOpen = !isFabOpen;
                });
              },
              child: Icon(Icons.arrow_forward, color: Colors.white),
              backgroundColor: widget.themeData.colorScheme.primary,
              // Use theme color
              elevation: 8,
              splashColor: widget.themeData.colorScheme.secondary,
            ),
            SizedBox(width: 16),
            FloatingActionButton(
              onPressed: () {
                _showDrawerDialog(context);
              },
              child: Icon(Icons.draw, color: Colors.white),
              backgroundColor: widget.themeData.colorScheme.primary,
              // Use theme color
              elevation: 8,
              splashColor: widget.themeData.colorScheme.secondary,
            ),
            SizedBox(width: 16),
            FloatingActionButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => AddTaskPage()),
                );
              },
              child: Icon(Icons.add, color: Colors.white),
              backgroundColor: widget.themeData.colorScheme.primary,
              // Use theme color
              elevation: 8,
              splashColor: widget.themeData.colorScheme.secondary,
            ),
          ],
        )
            : FloatingActionButton(
          onPressed: () {
            setState(() {
              isFabOpen = !isFabOpen;
            });
          },
          child: Icon(Icons.create, color: Colors.white),
          backgroundColor: widget.themeData.colorScheme.primary,
          // Use theme color
          elevation: 8,
          splashColor: widget.themeData.colorScheme.secondary,
        );
      },
    );
  }
  void _showDrawerDialog(BuildContext context) {
    List<Offset?> _points = [];
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          insetPadding: EdgeInsets.all(10),
          child: Container(
            width: MediaQuery.of(context).size.width * 0.9,
            height: MediaQuery.of(context).size.height * 0.7,
            child: Column(
              children: [
                Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Text('Draw Here', style: TextStyle(fontSize: 20)),
                ),
                Expanded(
                  child: StatefulBuilder(
                    builder: (BuildContext context, StateSetter setState) {
                      return GestureDetector(
                        onPanUpdate: (details) {
                          setState(() {
                            _points.add(details.localPosition);
                          });
                        },
                        onPanStart: (details) {
                          setState(() {
                            _points.add(details.localPosition);
                          });
                        },
                        onPanEnd: (details) {
                          setState(() {
                            _points.add(null);
                          });
                        },
                        child: RepaintBoundary(
                          key: _globalKey,
                          child: CustomPaint(
                            painter: SignaturePainter(_points),
                            child: Container(
                              constraints: BoxConstraints.expand(),
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    TextButton(
                      onPressed: () => Navigator.pop(context),
                      child: Text('Cancel'),
                    ),
                    TextButton(
                      onPressed: () async {
                        try {
                          final RenderRepaintBoundary boundary =
                          _globalKey.currentContext?.findRenderObject() as RenderRepaintBoundary;
                          final ui.Image image = await boundary.toImage(pixelRatio: 3.0);
                          final ByteData? byteData = await image.toByteData(format: ui.ImageByteFormat.png);
                          if (byteData == null) {
                            throw Exception('Failed to capture image bytes.');
                          }
                          final Uint8List pngBytes = byteData.buffer.asUint8List(byteData.offsetInBytes, byteData.lengthInBytes);

                          final directory = await getTemporaryDirectory();
                          final String imagePath = '${directory.path}/saved_drawing_${DateTime.now().millisecondsSinceEpoch}.png';
                          final File imgFile = File(imagePath);
                          await imgFile.writeAsBytes(pngBytes);

                          Provider.of<TaskProvider>(context, listen: false).addImagePath(imagePath);
                          Navigator.pop(context);
                        } catch (error) {
                          Navigator.pop(context);
                          showDialog(
                            context: context,
                            builder: (context) => AlertDialog(
                              title: Text('Error'),
                              content: Text('Failed to save drawing: $error'),
                              actions: <Widget>[
                                TextButton(
                                  child: Text('OK'),
                                  onPressed: () => Navigator.of(context).pop(),
                                ),
                              ],
                            ),
                          );
                        }
                      },
                      child: Text('Save'),
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
