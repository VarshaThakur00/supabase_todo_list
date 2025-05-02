import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:to_do_list/bloc/todo_bloc.dart';
import 'package:to_do_list/bloc/todo_event.dart';
import 'package:to_do_list/models/todo_model.dart';
import 'package:to_do_list/utils/app_constants.dart';

class AddEditTodoScreen extends StatefulWidget {
  final TodoModel? todo;

  const AddEditTodoScreen({super.key, this.todo});

  @override
  AddEditTodoScreenState createState() => AddEditTodoScreenState();
}

class AddEditTodoScreenState extends State<AddEditTodoScreen> {
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();

  @override
  void initState() {
    super.initState();
    if (widget.todo != null) {
      _titleController.text = widget.todo!.title;
      _descriptionController.text = widget.todo!.description ?? '';
    }
  }

  void _saveTodo() {
    if (_titleController.text.isEmpty) {
      return;
    }

    final newTitle = _titleController.text;
    final newDescription = _descriptionController.text.isEmpty
        ? null
        : _descriptionController.text;

    if (widget.todo == null) {
      context.read<TodoBloc>().add(AddTodoEvent(
            title: newTitle,
            description: newDescription,
          ));
    } else {
      context.read<TodoBloc>().add(UpdateTodoEvent(
            id: widget.todo!.id,
            title: _titleController.text,
            description: _descriptionController.text,
            isCompleted: widget.todo!.isCompleted,
          ));
    }

    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.todo == null ? AppConstants.addTodo : AppConstants.editTodo),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextField(
              controller: _titleController,
              decoration: const InputDecoration(labelText: AppConstants.title),
            ),
            TextField(
              controller: _descriptionController,
              decoration: const InputDecoration(labelText: AppConstants.description),
            ),
            const SizedBox(height: 20),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue,
                ),
                onPressed: _saveTodo,
                child: Text(widget.todo == null ? AppConstants.addTodo : AppConstants.saveTodo,style: const TextStyle(color: Colors.white),),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
