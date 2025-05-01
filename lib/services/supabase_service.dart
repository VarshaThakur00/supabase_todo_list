import 'package:supabase_flutter/supabase_flutter.dart';

class SupabaseService {
  final _client = Supabase.instance.client;
  Future<List<Map<String, dynamic>>> getTodos() async {
    final response = await _client
        .from('todos')
        .select()
        .order('created_at', ascending: false);
    return response;
  }

  Future<void> addTodo(String title, String? description) async {
    await _client.from('todos').insert({
      'title': title,
      'description': description,
      'is_completed': false,
    });
  }

Future<void> updateTodo(
    String id, String title, String? description, bool isCompleted) async {
  final response = await _client
      .from('todos')
      .update({
        'title': title,
        'description': description,
        'is_completed': isCompleted,
      })
      .eq('id', id)
      .select();

  if (response.isEmpty) {
    throw Exception('Update failed: No rows returned.');
  }
}
  Future<void> deleteTodo(String id) async {
    await _client.from('todos').delete().eq('id', id);
  }
}
