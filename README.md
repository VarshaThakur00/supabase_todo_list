# to_do_list

A cross-platform Flutter To-Do app with full CRUD functionality, using Supabase as the backend, BLoC for state management, and local notifications for task reminders. Developed as part of an assignment to demonstrate practical use of modern Flutter architecture and backend integration.

## Getting Started
Tech Stack
Flutter (latest stable)

State Management: BLoC Pattern (flutter_bloc)

Backend: Supabase (PostgreSQL, REST API)

Database Auth/Access: Supabase Public REST

Notifications: flutter_local_notifications

Device Info + Permissions: device_info_plus, permission_handler

Features
📋 Add, update, delete, and mark tasks as completed

🔄 Real-time task list updates via BLoC state transitions

☁️ Backend powered by Supabase for data persistence

🔔 Local notification triggers when a new task is added

✅ Works on Android (release-tested) and iOS (with necessary permissions)

📱 Clean UI with modular architecture for scalability


Project Structure

lib/
├── main.dart                         # App entry point
├── models/                           # Task model (todo_model.dart)
├── services/                         # Supabase setup and API calls
│   └── supabase_service.dart
├── bloc/                             # Business logic (BLoC pattern)
│   ├── todo_bloc.dart
│   ├── todo_event.dart
│   └── todo_state.dart
├── screens/                          # UI Screens
│   ├── home_screen.dart
│   └── add_edit_todo_screen.dart
├── widgets/                          # Reusable components
│   └── todo_tile.dart
└── notifications/                    # Notification setup and trigger
    └── notification_service.dart


Setup Instructions
Clone the repo

Replace Supabase credentials in supabase_service.dart

Run flutter pub get

For Android:

Ensure INTERNET permission is in AndroidManifest.xml

If using notifications, handle Android 13+ runtime permissions

For iOS:

Add notification permissions in Info.plist

Run on a real device to test notifications
