import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:to_do_list/bloc/todo_bloc.dart';
import 'package:to_do_list/bloc/todo_event.dart';
import 'package:to_do_list/bloc/todo_state.dart';
import 'package:to_do_list/screens/add_edit_todo_screen.dart';
import 'package:to_do_list/widgets/todo_tile.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.blue,
        child: const Icon(Icons.add, color: Colors.white),
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const AddEditTodoScreen()),
          );
        },
      ),
      appBar: AppBar(
        title: const Text('TODO LIST'),
        centerTitle: true,
      ),
      body: BlocBuilder<TodoBloc, TodoState>(
        builder: (context, state) {
          if (state is TodoLoadingState) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is TodoErrorState) {
            return Center(child: Text('Error: ${state.error}'));
          } else if (state is TodoLoadedState) {
            if (state.todos.isEmpty) {
              return const Center(child: Text('Add Todo Item'));
            } else {
              return ListView.builder(
                itemCount: state.todos.length,
                     padding: const EdgeInsets.only(bottom: 80.0),
                shrinkWrap: true,
                itemBuilder: (context, index) {
                  return TodoTile(
                    todo: state.todos[index],
                    onDelete: () {
                      context
                          .read<TodoBloc>()
                          .add(DeleteTodoEvent(id: state.todos[index].id));
                    },
                    onEdit: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>
                              AddEditTodoScreen(todo: state.todos[index]),
                        ),
                      );
                    },
                    onToggle: () {
                      context.read<TodoBloc>().add(UpdateTodoEvent(
                            id: state.todos[index].id,
                            title: state.todos[index].title,
                            description: state.todos[index].description,
                            isCompleted: !state.todos[index].isCompleted,
                          ));
                    },
                  );
                },
              );
            }
          } else {
            return const Center(child: Text('No tasks available'));
          }
        },
      ),
    );
  }
}
