import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:task_tracker_app/provider/task_provider.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    TextEditingController taskController = TextEditingController();
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.green[300],
          title: const Text('Home'),
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
          child: Consumer<TaskProvider>(
            builder: (context, value, child) {
              var notCompleTask = value.getTasks().where((element) {
                return element['status'] == false;
              }).toList();
              var compleTask = value.getTasks().where((element) {
                return element['status'] == true;
              }).toList();
              return Column(
                children: [
                  const Text(
                    "Not Completed Tasks",
                    style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.black),
                  ),
                  Expanded(
                      child: ListView.builder(
                          itemCount: notCompleTask.length,
                          itemBuilder: (context, index) {
                            return Card(
                              child: ListTile(
                                title: Text(notCompleTask[index]['name']),
                                trailing: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Checkbox(
                                      value: notCompleTask[index]['status'],
                                      onChanged: (boolValue) {
                                        var originalIndex = value
                                            .getTasks()
                                            .indexOf(notCompleTask[index]);
                                        Provider.of<TaskProvider>(context,
                                                listen: false)
                                            .changeStatus(originalIndex, true);
                                      },
                                    ),
                                    IconButton(
                                        onPressed: () {
                                          var originalIndex = value
                                              .getTasks()
                                              .indexOf(notCompleTask[index]);
                                          Provider.of<TaskProvider>(context,
                                                  listen: false)
                                              .deleteTask(originalIndex);
                                        },
                                        icon: const Icon(Icons.delete,
                                            color: Colors.red)),
                                  ],
                                ),
                              ),
                            );
                          })),
                  const Text(
                    "Completed Tasks",
                    style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.black),
                  ),
                  Expanded(
                      child: ListView.builder(
                          itemCount: compleTask.length,
                          itemBuilder: (context, index) {
                            return Card(
                              child: ListTile(
                                title: Text(compleTask[index]['name']),
                                trailing: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Checkbox(
                                      value: compleTask[index]['status'],
                                      onChanged: (boolValue) {
                                        var originalIndex = value
                                            .getTasks()
                                            .indexOf(compleTask[index]);
                                        Provider.of<TaskProvider>(context,
                                                listen: false)
                                            .changeStatus(originalIndex, false);
                                      },
                                    ),
                                    IconButton(
                                        onPressed: () {
                                          var originalIndex = value
                                              .getTasks()
                                              .indexOf(compleTask[index]);
                                          Provider.of<TaskProvider>(context,
                                                  listen: false)
                                              .deleteTask(originalIndex);
                                        },
                                        icon: const Icon(Icons.delete,
                                            color: Colors.red))
                                  ],
                                ),
                              ),
                            );
                          })),
                ],
              );
            },
          ),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            showDialog(
              context: context,
              builder: (context) {
                return AlertDialog(
                  title: const Text("Add Task"),
                  content: TextField(
                    controller: taskController,
                  ),
                  actions: [
                    ElevatedButton(
                        onPressed: () {
                          if (taskController.text.trim().isEmpty) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                  content: Text("Task cannot be empty")),
                            );
                          } else {
                            Provider.of<TaskProvider>(context, listen: false)
                                .addtask(taskController.text);
                          }
                        },
                        child: const Text("Add")),
                    ElevatedButton(
                        onPressed: () {
                          taskController.clear();
                          Navigator.pop(context);
                        },
                        child: const Text("Cancel")),
                  ],
                );
              },
            );
          },
          child: const Icon(Icons.add),
        ),
      ),
    );
  }
}
