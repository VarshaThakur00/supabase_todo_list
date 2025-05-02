import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:to_do_list/bloc/todo_bloc.dart';
import 'package:to_do_list/screens/home_screen.dart';
import 'package:to_do_list/services/supabase_service.dart';
import 'package:to_do_list/notifications/notification_service.dart'; // <-- Add this

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  
  await Supabase.initialize(
    url: 'https://lhxfpijnsqykpcxludkm.supabase.co',
    anonKey: 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6ImxoeGZwaWpuc3F5a3BjeGx1ZGttIiwicm9sZSI6ImFub24iLCJpYXQiOjE3NDYwODg1NDMsImV4cCI6MjA2MTY2NDU0M30.IixC0d9lVT_jr-YxC_q-M8ZzCWFUT0sri9vOtHTLNL8',
  );

  await NotificationService.initialize(); // <-- Initialize notifications

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final supabaseService = SupabaseService();

    return MultiBlocProvider(
      providers: [
        BlocProvider<TodoBloc>(
          create: (context) => TodoBloc(supabaseService: supabaseService),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'To-Do App',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: const HomeScreen(),
      ),
    );
  }
}
