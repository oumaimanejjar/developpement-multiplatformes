import 'package:uuid/uuid.dart';

const uuid = Uuid();

enum Category { personal, work, shopping, others }
class Task{
  Task({
    required this.title,
    required this.description,
    required this.date,
    required this.category,
  }) : id = uuid.v4();

  final String id;
  final String title;
  final String  description;
  final DateTime date;
  final Category category;
}