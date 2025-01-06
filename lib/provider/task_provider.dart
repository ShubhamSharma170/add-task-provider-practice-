import 'package:flutter/material.dart';

class TaskProvider extends ChangeNotifier {
  List<Map<String, dynamic>> tasks = [];

  // for get tasks list
  List<Map<String, dynamic>> getTasks() {
    return tasks;
  }

  // function for add task
  void addtask(String name) {
    tasks.add({
      'name': name,
      'status': false,
    });
    notifyListeners();
  }

  // function for change task status
  void changeStatus(int index, bool status) {
    tasks[index]['status'] = status;
    notifyListeners();
  }

  // function for delete task
  void deleteTask(int index) {
    tasks.removeAt(index);
    notifyListeners();
  }

  // function for edit task
  void editTask(int index, String name) {
    tasks[index]['name'] = name;
    notifyListeners();
  }
}
