import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/task.dart';

class FirestoreService{
final CollectionReference tasks= FirebaseFirestore.instance.collection('tasks');
Future<void> addTask( Task task)
{
return FirebaseFirestore.instance.collection('tasks').add(
{
'taskTitle': task.title.toString(),
'taskDesc': task.description.toString(),
'taskCategory': task.category.toString(),
  'taskDate':task.date,
},
);
}
Future<void> deleteTask(Task task) {
  return tasks
      .where('taskTitle', isEqualTo: task.title)
      .where('taskDesc', isEqualTo: task.description)
      .get()
      .then((querySnapshot) {
    querySnapshot.docs.forEach((doc) {
      doc.reference.delete();
    });
  });
}
Stream <QuerySnapshot> getTasks()
{
final taskStream= tasks.snapshots();
return taskStream;

}
}
