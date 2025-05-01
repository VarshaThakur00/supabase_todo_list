import 'package:to_do_list/models/todo_model.dart';

abstract class TodoState {}

class TodoInitialState extends TodoState {}

class TodoLoadingState extends TodoState {}

class TodoLoadedState extends TodoState {
  final List<TodoModel> todos;
  TodoLoadedState({required this.todos});
}

class TodoErrorState extends TodoState {
  final String error;
  TodoErrorState({required this.error});
}
