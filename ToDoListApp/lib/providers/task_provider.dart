import 'package:flutter/material.dart';

import '../database/database_helper.dart';
import '../database/image_database_helper.dart';
import '../models/task_model.dart';



class TaskProvider extends ChangeNotifier {
  List<Task> _tasks = [];
  List<String> _imagePaths = [];


  List<Task> get tasks => _tasks;



  List<String> get imagePaths => _imagePaths;

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



  void loadImagePaths() async {
    _imagePaths = await ImageDatabaseHelper.instance.getImagePaths();
    notifyListeners();
  }

  void addImagePath(String path) async {
    await ImageDatabaseHelper.instance.insertImagePath(path);
    _imagePaths.add(path);
    notifyListeners();
  }

  void deleteImagePath(int id) async {
    await ImageDatabaseHelper.instance.deleteImagePath(id);
    loadImagePaths();
  }


}
