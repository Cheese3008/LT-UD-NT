import 'package:flutter/material.dart';

import 'screens/home_screen.dart';

void main() {
  runApp(const ExerciseWeek4App());
}

class ExerciseWeek4App extends StatelessWidget {
  const ExerciseWeek4App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Exercise Week 4',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.blue,
        ),
        useMaterial3: true,
      ),
      home: const HomeScreen(),
    );
  }
}