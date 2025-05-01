import 'package:flutter/material.dart';
import 'package:to_do_list/models/todo_model.dart';

class TodoTile extends StatelessWidget {
  final TodoModel todo;
  final VoidCallback onDelete;
  final VoidCallback onEdit;
  final VoidCallback onToggle;

  const TodoTile({super.key, required this.todo, required this.onDelete, required this.onToggle, required this.onEdit});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      elevation: 4,  
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),  
      ),
      child: ListTile(
        title: Text(todo.title),
        subtitle: Text(todo.description ?? 'No description'),
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            IconButton(
              icon: Icon(todo.isCompleted ? Icons.check_box : Icons.check_box_outline_blank),
              onPressed: onToggle,
            ),
            IconButton(
              icon: const Icon(Icons.edit,color: Colors.blue,),
              onPressed: onEdit,
            ),
            IconButton(
              icon: const Icon(Icons.delete,color: Colors.red,),
              onPressed: onDelete,
            ),
          ],
        ),
      ),
    );
  }
}
