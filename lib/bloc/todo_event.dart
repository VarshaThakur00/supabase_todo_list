abstract class TodoEvent {}

class LoadTodosEvent extends TodoEvent {}

class AddTodoEvent extends TodoEvent {
  final String title;
  final String? description;
  AddTodoEvent({required this.title, this.description});
}
class UpdateTodoEvent extends TodoEvent {
  final String id;
  final String title;
  final String? description;
  final bool isCompleted;

  UpdateTodoEvent({
    required this.id,
    required this.title,
    this.description,
    required this.isCompleted,
  });
}

class DeleteTodoEvent extends TodoEvent {
  final String id;
  DeleteTodoEvent({required this.id});
}
