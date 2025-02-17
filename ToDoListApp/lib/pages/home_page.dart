import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:to_do_list/pages/settings_page.dart';
import '../providers/task_provider.dart';
import '../providers/theme_provider.dart'; // Add this import
import 'add_task_page.dart';
import '../widgets/task_tile.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class HomePage extends StatefulWidget {
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {



  @override
  void initState() {
    super.initState();
    // Assuming you have access to TaskProvider here
    Provider.of<TaskProvider>(context, listen: false).loadTasks();
  }
  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context); // Get theme provider
    final themeData = themeProvider.themeData;

    // Get current theme data

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'To-Do List',
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: themeData.appBarTheme.titleTextStyle?.color, // Use theme color
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
                        margin: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
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
                              builder: (context) => AddTaskPage(existingTask: task),
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
              SizedBox(height: 16),
              Text(
                  AppLocalizations.of(context)!.language,
                style: TextStyle(
                  fontSize: 16,)),
            ],
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => AddTaskPage()),
          );
        },
        child: Icon(Icons.add, color: Colors.white),
        backgroundColor: themeData.colorScheme.primary, // Use theme color
        elevation: 8,
        splashColor: themeData.colorScheme.secondary,
      ),
      backgroundColor: themeData.scaffoldBackgroundColor, // Use theme background
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