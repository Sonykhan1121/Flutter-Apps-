import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:to_do_list/pages/settings_page.dart';

import '../listviews/drawing_list_view.dart';
import '../listviews/task_list_view.dart';
import '../providers/task_provider.dart';
import '../providers/theme_provider.dart'; // Add this import
import '../widgets/custom_valuelistenablebuilder.dart';
import '../widgets/notaskisadded.dart';

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
    Provider.of<TaskProvider>(context, listen: false).loadImagePaths();
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
            color:Theme.of(context).colorScheme.onError,
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
            return Notaskisadded(themeData: themeData, context: context);
          }
          return Column(
            children: [
              Expanded(
                child: TaskListView(provider: provider),
              ),
              Text(
                "..My drawing..",
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.displaySmall,
              ),
              Expanded(
                flex: 1,
                child: DrawingListView(provider: provider),
              ),
            ],
          );
        },
      ),
      floatingActionButton: CustomValuelistenablebuilder(themeData: themeData),
      backgroundColor:
          themeData.scaffoldBackgroundColor, // Use theme background
    );
  }
}
