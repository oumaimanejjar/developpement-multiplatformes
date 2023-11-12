import 'package:flutter/material.dart';
import 'package:tp3/models/task.dart';
import 'package:tp3/services/firestore.dart';

import 'package:tp3/widgets/new_task.dart';
import 'package:tp3/widgets/tasks_list.dart';

class Tasks extends StatefulWidget {
  const Tasks({super.key});

  @override
  State<Tasks> createState() {
    return _TasksState();
  }
}

class _TasksState extends State<Tasks> {
  final FirestoreService firestoreService = FirestoreService();

  void _openAddTaskOverlay() {
    showModalBottomSheet(
      context: context,
      builder: (ctx) => NewTask(onAddTask: _addTask),
    );
  }

  void _addTask(Task task) {
    firestoreService.addTask(task); // Add the task to Firestore
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Flutter ToDoList'),
        actions: [
          IconButton(
            onPressed: _openAddTaskOverlay,
            icon: const Icon(Icons.add),
          ),
        ],
      ),
      body: Stack(
        children: [
          TasksList(firestoreService: firestoreService), // Pass the Firestore service
        ],
      ),
    );
  }
}