import 'package:flutter/material.dart';
import '../screens/game_backlog_screen.dart';

class GameEmptyState extends StatelessWidget {
  final GameStatus? status;

  const GameEmptyState({super.key, required this.status});

  @override
  Widget build(BuildContext context) {
    final message = status == null
        ? 'Belum ada game di backlog kamu.'
        : 'Belum ada game dengan status ini.';
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Text(message, textAlign: TextAlign.center),
      ),
    );
  }
}