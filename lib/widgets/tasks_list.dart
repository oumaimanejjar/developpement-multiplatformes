import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:tp3/models/task.dart';
import '../services/firestore.dart';
import 'task_item.dart';
class TasksList extends StatelessWidget {
  final FirestoreService firestoreService;

  TasksList({super.key, required this.firestoreService});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: firestoreService.getTasks(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return CircularProgressIndicator();
        }

        final taskLists = snapshot.data!.docs;
        List<Task> taskItems = [];

        for (int index = 0; index < taskLists.length; index++) {
          DocumentSnapshot document = taskLists[index];
          Map<String, dynamic> data = document.data() as Map<String, dynamic>;
          String title = data['taskTitle'];
          String description = data['taskDesc'];
          DateTime date = data['taskDate'].toDate();
          String categoryString = data['taskCategory'];

          Category category;

          switch (categoryString) {
            case 'personal':
              category = Category.personal;
              break;
            case 'work':
              category = Category.work;
              break;
            case 'shopping':
              category = Category.shopping;
              break;
            default:
              category = Category.others;
          }
          Task task = Task(
            title: title,
            description: description,
            date: date,
            category: category,

          );
          taskItems.add(task);
        }

        return ListView.builder(
          itemCount: taskItems.length,

          itemBuilder: (ctx, index) {

            return TaskItem(
              task: taskItems[index],
              Delete: () {

                firestoreService.deleteTask(taskLists[index].reference as Task );

              },


            );
          },
        );

      },
    );
  }
}