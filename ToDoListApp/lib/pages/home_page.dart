import 'dart:io';
import 'dart:ui' as ui;
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:path_provider/path_provider.dart';
import 'package:provider/provider.dart';
import 'package:to_do_list/pages/settings_page.dart';

import '../providers/task_provider.dart';
import '../providers/theme_provider.dart'; // Add this import
import '../widgets/task_tile.dart';
import 'add_task_page.dart';

class HomePage extends StatefulWidget {
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final _noteController = TextEditingController();
  final GlobalKey _globalKey = GlobalKey();

  bool _isFabOpen = false;

  @override
  void initState() {
    super.initState();
    // Assuming you have access to TaskProvider here
    Provider.of<TaskProvider>(context, listen: false).loadTasks();
  }

  @override
  Widget build(BuildContext context) {
    final themeProvider =
        Provider.of<ThemeProvider>(context); // Get theme provider
    final themeData = themeProvider.themeData;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'To-Do List',
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color:
                themeData.appBarTheme.titleTextStyle?.color, // Use theme color
          ),
        ),
        backgroundColor: themeData.colorScheme.primary, // Use theme color
        elevation: 10,
        actions: [
          IconButton(
            icon: Icon(Icons.settings, color: themeData.iconTheme.color),
            onPressed: () => Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => SettingsPage()),
            ),
          ),
        ],
      ),
      body: Consumer<TaskProvider>(
        builder: (context, provider, child) {
          if (provider.tasks.isEmpty) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.assignment,
                    size: 80,
                    color: themeData.colorScheme.primary.withOpacity(0.5),
                  ),
                  SizedBox(height: 16),
                  Text(
                    "No tasks added yet,\nstart by adding a new one!",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 18,
                      color: themeData.colorScheme.onSurface.withOpacity(0.7),
                    ),
                  ),
                  SizedBox(height: 16),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => AddTaskPage()),
                      );
                    },
                    child: Text(
                      'Add Task',
                      style: TextStyle(color: Colors.white),
                    ),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: themeData.colorScheme.primary,
                    ),
                  ),
                ],
              ),
            );
          }
          return Column(
            children: [
              Expanded(

                child: ListView.builder(

                  itemCount: provider.tasks.length,
                  itemBuilder: (context, index) {
                    final task = provider.tasks[index];
                    return Dismissible(
                      key: Key(task.id.toString()),
                      background: Container(
                        color: Colors.red,
                        alignment: Alignment.centerRight,
                        padding: EdgeInsets.only(right: 20),
                        child: Icon(Icons.delete, color: Colors.white),
                      ),
                      direction: DismissDirection.endToStart,
                      onDismissed: (direction) {
                        provider.deleteTask(task.id);
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text('${task.title} deleted'),
                            backgroundColor: Colors.red,
                            behavior: SnackBarBehavior.floating,
                          ),
                        );
                      },
                      child: Card(
                        margin:
                            EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                        elevation: 4,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        color: _getPriorityColor(task.priority),
                        child: InkWell(
                          borderRadius: BorderRadius.circular(12),
                          onTap: () => Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) =>
                                  AddTaskPage(existingTask: task),
                            ),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: TaskTile(task: task),
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
              Text("..My drawing..",textAlign: TextAlign.center,),
              Expanded(
                flex: 1,
                child: ListView.builder(

                  scrollDirection: Axis.horizontal,
                  itemCount: provider.imagePaths.length,
                  itemBuilder: (context, index) {

                    String imagePath = provider.imagePaths[index];
                    return Image.file(File(imagePath));
                  },
                ),
              ),
            ],
          );
        },
      ),
      floatingActionButton: ValueListenableBuilder(
        valueListenable: ValueNotifier(_isFabOpen),
        builder: (context, value, child) {
          return _isFabOpen
              ? Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    FloatingActionButton(
                      onPressed: () {
                        setState(() {
                          _isFabOpen = !_isFabOpen;
                        });
                      },
                      child: Icon(Icons.arrow_forward, color: Colors.white),
                      backgroundColor: themeData.colorScheme.primary,
                      // Use theme color
                      elevation: 8,
                      splashColor: themeData.colorScheme.secondary,
                    ),
                    SizedBox(width: 16),
                    FloatingActionButton(
                      onPressed: () {
                        _showDrawerDialog(context);
                      },
                      child: Icon(Icons.draw, color: Colors.white),
                      backgroundColor: themeData.colorScheme.primary,
                      // Use theme color
                      elevation: 8,
                      splashColor: themeData.colorScheme.secondary,
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
                      backgroundColor: themeData.colorScheme.primary,
                      // Use theme color
                      elevation: 8,
                      splashColor: themeData.colorScheme.secondary,
                    ),
                  ],
                )
              : FloatingActionButton(
                  onPressed: () {
                    setState(() {
                      _isFabOpen = !_isFabOpen;
                    });
                  },
                  child: Icon(Icons.create, color: Colors.white),
                  backgroundColor: themeData.colorScheme.primary,
                  // Use theme color
                  elevation: 8,
                  splashColor: themeData.colorScheme.secondary,
                );
        },
      ),
      backgroundColor:
          themeData.scaffoldBackgroundColor, // Use theme background
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

  Color _getPriorityColor(int priority) {
    switch (priority) {
      case 1:
        return Colors.green.shade100;
      case 2:
        return Colors.orange.shade100;
      case 3:
        return Colors.red.shade100;
      default:
        return Theme.of(context).cardTheme.color ?? Colors.white;
    }
  }
}
class SignaturePainter extends CustomPainter {
  List<Offset?> _points;

  SignaturePainter(this._points);

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.black
      ..strokeCap = StrokeCap.round
      ..strokeWidth = 5;

    for (int i = 0; i < _points.length - 1; i++) {
      if (_points[i] != null && _points[i + 1] != null) {
        canvas.drawLine(_points[i]!, _points[i + 1]!, paint);
      }
    }
  }

  @override
  bool shouldRepaint(SignaturePainter oldDelegate) => true;  // Always repaint when setState is called
}