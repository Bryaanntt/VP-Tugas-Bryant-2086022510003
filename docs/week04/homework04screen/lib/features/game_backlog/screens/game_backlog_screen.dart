import 'package:flutter/material.dart';
import '../controller/game_backlog_controller.dart';
import '../data/game_data.dart';
import '../model/game.dart';
import '../widgets/game_empty_state.dart';
import '../widgets/game_list_item.dart';
import '../widgets/game_loading_view.dart';
import '../widgets/game_status.dart';

export '../model/game.dart';

class GameBacklogScreen extends StatefulWidget {
  const GameBacklogScreen({
    super.key,
    this.games,
    this.loadDelay = const Duration(seconds: 1),
  });

  final List<Game>? games;
  final Duration loadDelay;

  @override
  State<GameBacklogScreen> createState() => _GameBacklogScreenState();
}

class _GameBacklogScreenState extends State<GameBacklogScreen> {
  static const double _tabletBreakpoint = 600;

  late final GameBacklogController _controller;
  final TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _controller = GameBacklogController(
      SampleGameData(games: widget.games, delay: widget.loadDelay),
    )..load();
  }

  @override
  void dispose() {
    _searchController.dispose();
    _controller.dispose();
    super.dispose();
  }

  void _clearFilters() {
    _searchController.clear();
    _controller.clearFilters();
  }

  void _showStatusDialog(Game game) {
    showDialog(
      context: context,
      builder: (dialogContext) => SimpleDialog(
        title: const Text('Ubah status'),
        children: GameStatus.values.map((status) {
          return SimpleDialogOption(
            onPressed: () {
              _controller.changeStatus(game, status);
              Navigator.pop(dialogContext);
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text('${game.title} sekarang: ${status.label}'),
                ),
              );
            },
            child: Text(status.label),
          );
        }).toList(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    return Scaffold(
      body: SafeArea(
        child: ListenableBuilder(
          listenable: _controller,
          builder: (context, _) {
            return LayoutBuilder(
              builder: (context, constraints) {
                final compact = constraints.maxHeight < 320;

                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding:
                          EdgeInsets.fromLTRB(16, compact ? 8 : 24, 16, 0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Backlog Kamu',
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: (compact
                                    ? textTheme.titleLarge
                                    : textTheme.headlineMedium)
                                ?.copyWith(color: scheme.primary),
                          ),
                          if (!compact) ...[
                            const SizedBox(height: 4),
                            Text(
                              _controller.isLoading
                                  ? 'Memuat daftar game...'
                                  : '${_controller.filteredGames.length} game',
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: textTheme.bodyMedium?.copyWith(
                                color: scheme.onSurfaceVariant,
                              ),
                            ),
                          ],
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(16, 8, 16, 0),
                      child: SearchBar(
                        key: const Key('search-field'),
                        controller: _searchController,
                        hintText: 'Cari game...',
                        leading: const Icon(Icons.search),
                        onChanged: _controller.search,
                      ),
                    ),
                    // Layar sangat pendek: chip disembunyikan, search tetap ada.
                    if (!compact)
                      GameStatusFilter(
                        selectedStatus: _controller.selectedStatus,
                        onChanged: _controller.selectStatus,
                      ),
                    Expanded(child: _buildBody(constraints.maxWidth)),
                  ],
                );
              },
            );
          },
        ),
      ),
    );
  }

  Widget _buildBody(double width) {
    if (_controller.isLoading) return const GameLoadingView();

    final games = _controller.filteredGames;
    if (games.isEmpty) {
      return Column(
        key: const Key('empty-state'),
        children: [
          Expanded(child: GameEmptyState(status: _controller.selectedStatus)),
          Padding(
            padding: const EdgeInsets.only(bottom: 16),
            child: FilledButton.tonal(
              onPressed: _controller.selectedStatus != null
                  ? () => _controller.selectStatus(null)
                  : _controller.load,
              child: Text(
                _controller.selectedStatus != null
                    ? 'Lihat semua'
                    : 'Muat ulang',
                maxLines: 1,
              ),
            ),
          ),
        ],
      );
    }

    Widget buildItem(BuildContext context, int index) {
      final game = games[index];
      return GameListItem(game: game, onTap: () => _showStatusDialog(game));
    }

    if (width >= _tabletBreakpoint) {
      return GridView.builder(
        padding: const EdgeInsets.symmetric(horizontal: 4),
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: width >= 1000 ? 3 : 2,
          mainAxisExtent: 96,
        ),
        itemCount: games.length,
        itemBuilder: buildItem,
      );
    }

    return ListView.builder(
      itemCount: games.length,
      itemBuilder: buildItem,
    );
  }
}