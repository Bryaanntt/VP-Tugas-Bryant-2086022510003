import 'package:flutter/material.dart';
import '../screens/game_backlog_screen.dart';

class GameStatusFilter extends StatelessWidget {
  final GameStatus? selectedStatus;
  final ValueChanged<GameStatus?> onChanged;

  const GameStatusFilter({
    super.key,
    required this.selectedStatus,
    required this.onChanged,
  });

  String _label(GameStatus? status) {
    switch (status) {
      case GameStatus.playing:
        return 'Playing';
      case GameStatus.finished:
        return 'Finished';
      case GameStatus.dropped:
        return 'Dropped';
      case GameStatus.backlog:
        return 'Backlog';
      case null:
        return 'Semua';
    }
  }

  @override
  Widget build(BuildContext context) {
    final options = <GameStatus?>[null, ...GameStatus.values];

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          children: options.map((status) {
            final isSelected = status == selectedStatus;
            return Padding(
              padding: const EdgeInsets.only(right: 8),
              child: ChoiceChip(
                label: Text(_label(status)),
                selected: isSelected,
                onSelected: (_) => onChanged(status),
              ),
            );
          }).toList(),
        ),
      ),
    );
  }
}