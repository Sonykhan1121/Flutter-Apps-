import 'package:flutter/material.dart';

import '../database/database_helper.dart';
import '../database/image_database_helper.dart';
import '../models/image_model.dart';
import '../models/task_model.dart';



class TaskProvider extends ChangeNotifier {
  List<Task> _tasks = [];
  List<ImageModel> _images = [];


  List<Task> get tasks => _tasks;



  List<ImageModel> get images => _images;

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
    final results = await ImageDatabaseHelper.instance.getImagePaths();
    _images = results.map((map) => ImageModel.fromMap(map)).toList();
    notifyListeners();
  }
  void addImagePath(String path) async {
    int id = await ImageDatabaseHelper.instance.insertImagePath(path);
    ImageModel image = ImageModel(id: id, path: path);
    _images.add(image);
    loadImagePaths();
  }
  void deleteImagePath(int id) async {
    await ImageDatabaseHelper.instance.deleteImagePath(id);
    _images.removeWhere((image) => image.id == id);
    loadImagePaths();
  }

}
