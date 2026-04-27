import 'package:flutter/material.dart';

import 'contact_list_screen.dart';
import 'grid_view_screen.dart';
import 'shared_preferences_screen.dart';
import 'async_user_screen.dart';
import 'factorial_isolate_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  void _openScreen(BuildContext context, Widget screen) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => screen,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final exercises = [
      _ExerciseItem(
        title: 'ListView Exercise',
        subtitle: 'Scrollable contact list with avatar',
        icon: Icons.contacts,
        screen: const ContactListScreen(),
      ),
      _ExerciseItem(
        title: 'GridView Exercise',
        subtitle: 'GridView.count and GridView.extent',
        icon: Icons.grid_view,
        screen: const GridViewScreen(),
      ),
      _ExerciseItem(
        title: 'SharedPreferences Exercise',
        subtitle: 'Save, show, and clear user data',
        icon: Icons.save,
        screen: const SharedPreferencesScreen(),
      ),
      _ExerciseItem(
        title: 'Async Programming Exercise',
        subtitle: 'Load user after 3 seconds',
        icon: Icons.timer,
        screen: const AsyncUserScreen(),
      ),
      _ExerciseItem(
        title: 'Isolate Factorial Exercise',
        subtitle: 'Calculate large factorial using compute',
        icon: Icons.memory,
        screen: const FactorialIsolateScreen(),
      ),
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text('Exercise Week 4'),
        centerTitle: true,
      ),
      body: ListView.separated(
        padding: const EdgeInsets.all(16),
        itemCount: exercises.length,
        separatorBuilder: (context, index) => const SizedBox(height: 12),
        itemBuilder: (context, index) {
          final item = exercises[index];

          return Card(
            elevation: 3,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
            child: ListTile(
              contentPadding: const EdgeInsets.symmetric(
                horizontal: 16,
                vertical: 12,
              ),
              leading: CircleAvatar(
                radius: 26,
                child: Icon(item.icon),
              ),
              title: Text(
                item.title,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),
              subtitle: Text(item.subtitle),
              trailing: const Icon(Icons.arrow_forward_ios, size: 18),
              onTap: () => _openScreen(context, item.screen),
            ),
          );
        },
      ),
    );
  }
}

class _ExerciseItem {
  final String title;
  final String subtitle;
  final IconData icon;
  final Widget screen;

  const _ExerciseItem({
    required this.title,
    required this.subtitle,
    required this.icon,
    required this.screen,
  });
}