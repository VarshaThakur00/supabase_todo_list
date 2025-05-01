import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:to_do_list/models/todo_model.dart';
import 'package:to_do_list/services/supabase_service.dart';
import 'todo_event.dart';
import 'todo_state.dart';
class TodoBloc extends Bloc<TodoEvent, TodoState> {
  final SupabaseService supabaseService;

  TodoBloc({required this.supabaseService}) : super(TodoInitialState()) {
   
    on<TodoEvent>(_handleEvent);
    add(LoadTodosEvent());  }

  Future<void> _handleEvent(TodoEvent event, Emitter<TodoState> emit) async {
    if (event is LoadTodosEvent) {
      emit(TodoLoadingState());
      try {
        final todos = await supabaseService.getTodos();
        emit(TodoLoadedState(
          todos: todos.map((e) => TodoModel.fromMap(e)).toList(),
        ));
      } catch (e) {
        emit(TodoErrorState(error: e.toString()));
      }
    }

    if (event is AddTodoEvent) {
      try {
        await supabaseService.addTodo(event.title, event.description);
        add(LoadTodosEvent());
      } catch (e) {
        emit(TodoErrorState(error: e.toString()));
      }
    }

    if (event is UpdateTodoEvent) {
      try {
        await supabaseService.updateTodo(
          event.id,
          event.title,
          event.description,
          event.isCompleted,
        );
        add(LoadTodosEvent());
      } catch (e) {
        emit(TodoErrorState(error: e.toString()));
      }
    }

    if (event is DeleteTodoEvent) {
      try {
        await supabaseService.deleteTodo(event.id);
        add(LoadTodosEvent());
      } catch (e) {
        emit(TodoErrorState(error: e.toString()));
      }
    }
  }
}
