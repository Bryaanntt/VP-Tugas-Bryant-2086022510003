import 'package:flutter/material.dart';
import '../screens/game_backlog_screen.dart';

class GameListItem extends StatelessWidget {
  final Game game;
  final VoidCallback onTap;

  const GameListItem({
    super.key,
    required this.game,
    required this.onTap,
  });

  Color _statusColor(GameStatus status) {
    switch (status) {
      case GameStatus.playing:
        return Colors.blue;
      case GameStatus.finished:
        return Colors.green;
      case GameStatus.dropped:
        return Colors.red;
      case GameStatus.backlog:
        return Colors.grey;
    }
  }

  String _statusLabel(GameStatus status) {
    switch (status) {
      case GameStatus.playing:
        return 'Playing';
      case GameStatus.finished:
        return 'Finished';
      case GameStatus.dropped:
        return 'Dropped';
      case GameStatus.backlog:
        return 'Backlog';
    }
  }

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: const Icon(Icons.videogame_asset),
      title: Text(game.title),
      trailing: Chip(
        label: Text(
          _statusLabel(game.status),
          style: const TextStyle(color: Colors.white, fontSize: 12),
        ),
        backgroundColor: _statusColor(game.status),
        padding: EdgeInsets.zero,
      ),
      onTap: onTap,
    );
  }
}