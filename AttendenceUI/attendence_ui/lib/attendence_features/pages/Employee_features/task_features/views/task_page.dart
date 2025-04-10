import 'package:flutter/material.dart';

class TaskPage extends StatelessWidget {
  const TaskPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('My Task page'),

      ),
      body: Center(
        child: Text('Tasks'),
      ),
    );
  }
}

