import 'package:flutter/material.dart';

class TaskProvider with ChangeNotifier {
  List<String> _tasks = [];

  List<String> get tasks => _tasks;

  void addTask(String task) {
    _tasks.add(task);
    notifyListeners();
  }

  void removeTask(String task) {
    _tasks.remove(task);
    notifyListeners();
  }
}
