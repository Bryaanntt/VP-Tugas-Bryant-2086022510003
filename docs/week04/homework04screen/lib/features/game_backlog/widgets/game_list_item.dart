import 'package:flutter/material.dart';
import '../model/game.dart';

class GameListItem extends StatelessWidget {
  final Game game;
  final VoidCallback onTap;

  const GameListItem({
    super.key,
    required this.game,
    required this.onTap,
  });

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
        title: Text(
          game.title,
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
          style: textTheme.titleMedium,
        ),
        trailing: Chip(
          label: Text(
            game.status.label,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
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