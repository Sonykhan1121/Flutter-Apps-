import 'package:flutter/material.dart';

import '../pages/add_task_page.dart';
import '../providers/task_provider.dart';
import '../widgets/task_tile.dart';

class TaskListView extends StatefulWidget {
  final TaskProvider provider;
  const TaskListView({super.key,required this.provider});

  @override
  State<TaskListView> createState() => _TaskListViewState();
}

class _TaskListViewState extends State<TaskListView> {
  @override
  Widget build(BuildContext context) {
    return ListView.builder(

      itemCount: widget.provider.tasks.length,
      itemBuilder: (context, index) {
        final task = widget.provider.tasks[index];
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
            widget.provider.deleteTask(task.id);
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
                padding: const EdgeInsets.all(3.0),
                child: TaskTile(task: task),
              ),
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
