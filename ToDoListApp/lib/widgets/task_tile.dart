import 'package:flutter/material.dart';
import '../models/task_model.dart';
import 'package:provider/provider.dart';
import '../providers/task_provider.dart';

class TaskTile extends StatelessWidget {
  final Task task;

  TaskTile({required this.task});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(task.title),

      subtitle: Text(task.description),
      trailing: IconButton(
        icon: Icon(Icons.delete),
        onPressed: () {
          Provider.of<TaskProvider>(context, listen: false).deleteTask(task.id!);
        },
      ),
    );
  }
}
