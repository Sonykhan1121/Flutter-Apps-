import 'package:flutter/material.dart';

import '../pages/add_task_page.dart';

class Notaskisadded extends StatelessWidget {
  final ThemeData themeData;
  final BuildContext context;

  const Notaskisadded({super.key,required this.themeData,required this.context});

  @override
  Widget build(BuildContext context) {
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
}
