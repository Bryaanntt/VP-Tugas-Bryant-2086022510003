import 'package:flutter/material.dart';
import 'features/game_backlog/screens/game_backlog_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Game Backlog',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFF7C5CFF), 
          brightness: Brightness.dark,
        ),
      ),
      home: const GameBacklogScreen(),
    );
  }
}