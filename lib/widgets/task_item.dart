

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:tp3/models/task.dart';

import '../services/firestore.dart';

class TaskItem extends StatelessWidget {
  final Task task;
  final VoidCallback Delete;


  TaskItem({required this.task, required this.Delete});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        title: Text(task.title),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(task.description),
            Text('Date: ${DateFormat('yyyy-MM-dd').format(task.date)}'),
            Text('Category: ${task.category}'),
          ],
        ),
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[


            IconButton(
              icon: Icon(Icons.delete),
              onPressed: Delete,
            ),
          ],
        ),
      ),
    );
  }
}