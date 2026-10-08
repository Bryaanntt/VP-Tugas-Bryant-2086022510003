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

  (Color background, Color foreground) _statusColors(ColorScheme scheme) {
    switch (game.status) {
      case GameStatus.playing:
        return (scheme.primaryContainer, scheme.onPrimaryContainer);
      case GameStatus.finished:
        return (scheme.tertiaryContainer, scheme.onTertiaryContainer);
      case GameStatus.dropped:
        return (scheme.errorContainer, scheme.onErrorContainer);
      case GameStatus.backlog:
        return (scheme.surfaceContainerHighest, scheme.onSurfaceVariant);
    }
  }

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;
    final (background, foreground) = _statusColors(scheme);

    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
      child: ListTile(
        leading: Icon(Icons.videogame_asset, color: scheme.primary),
        // Judul = elemen terpenting di item ini
        title: Text(game.title, style: textTheme.titleMedium),
        trailing: Chip(
          label: Text(
            _statusLabel(game.status),
            style: textTheme.labelMedium?.copyWith(color: foreground),
          ),
          backgroundColor: background,
          side: BorderSide.none,
          padding: EdgeInsets.zero,
        ),
        onTap: onTap,
      ),
    );
  }
}