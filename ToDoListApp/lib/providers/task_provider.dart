import 'package:flutter/material.dart';

import '../database/database_helper.dart';
import '../models/task_model.dart';



class TaskProvider extends ChangeNotifier {
  List<Task> _tasks = [];

  List<Task> get tasks => _tasks;

  void loadTasks() async {
    _tasks = await DatabaseHelper.instance.getTasks();
    notifyListeners();
  }

  void addTask(Task task) async {
    await DatabaseHelper.instance.insertTask(task);
    loadTasks();
  }

  void updateTask(Task task) async {
    await DatabaseHelper.instance.updateTask(task);
    loadTasks();
  }

  void deleteTask(int? id) async {
    await DatabaseHelper.instance.deleteTask(id!);
    loadTasks();
  }
}
