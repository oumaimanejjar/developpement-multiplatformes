import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:tp3/models/task.dart';

class NewTask extends StatefulWidget {
  const NewTask({super.key, required this.onAddTask});

  final void Function(Task task) onAddTask;

  @override
  State<NewTask> cd c) {
    return _NewTaskState();
  }
}

class _NewTaskState extends State<NewTask> {
  Category _selectedCategory = Category.personal;
  final _titleController = TextEditingController();
  final _descriptionController = TextEditingController();
  DateTime _selectedDate = DateTime.now();

  void _submitTaskData() {
    if (_titleController.text.trim().isEmpty) {
      showDialog(
        context: context,
        builder: (ctx) => AlertDialog(
          title: const Text('Erreur'),
          content: const Text(
              'Merci de saisir le titre de la tâche à ajouter dans la liste'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(ctx);
              },
              child: const Text('Okay'),
            ),
          ],
        ),
      );
      return;
    }
    widget.onAddTask(
      Task(
        title: _titleController.text,
        description: _descriptionController.text,
        date: _selectedDate, // Use the selected date
        category: _selectedCategory,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          DropdownButton<Category>(
            value: _selectedCategory,
            items: Category.values
                .map((category) => DropdownMenuItem<Category>(
              value: category,
              child: Text(
                category.name.toUpperCase(),
              ),
            ))
                .toList(),
            onChanged: (value) {
              if (value == null) {
                return;
              }
              setState(() {
                _selectedCategory = value;
              });
            },
          ),
          TextField(
            controller: _titleController,
            maxLength: 50,
            decoration: InputDecoration(
              labelText: 'Task Title',
            ),
          ),
          TextField(
            controller: _descriptionController,
            maxLength: 50,
            decoration: InputDecoration(
              labelText: 'Task Description',
            ),
          ),
          ElevatedButton(
            onPressed: _submitTaskData,
            child: const Text('Save Task'),
          ),
          TableCalendar(
            focusedDay: _selectedDate,
            firstDay: DateTime(2000),
            lastDay: DateTime(2101),
            calendarFormat: CalendarFormat.month,
            onDaySelected: (selectedDay, focusedDay) {
              setState(() {
                _selectedDate = selectedDay;
              });
            },
          ),
          Text('Selected Date: ${_selectedDate.toLocal()}'.split(' ')[0]),
        ],
      ),
    );
  }
}
