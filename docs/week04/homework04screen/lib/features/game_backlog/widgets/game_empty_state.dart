import 'package:flutter/material.dart';
import '../model/game.dart';

class GameEmptyState extends StatelessWidget {
  final GameStatus? status;
  final String query;

  const GameEmptyState({super.key, required this.status, this.query = ''});

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    final message = query.isNotEmpty
        ? 'Tidak ada game yang cocok dengan pencarian.'
        : status == null
            ? 'Belum ada game di backlog kamu.'
            : 'Belum ada game dengan status ini.';

    return Center(
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(Icons.inbox_outlined, size: 48, color: scheme.outline),
            const SizedBox(height: 12),
            Text(
              message,
              textAlign: TextAlign.center,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: textTheme.titleMedium?.copyWith(
                color: scheme.onSurfaceVariant,
              ),
            ),
          ],
        ),
      ),
    );
  }
}