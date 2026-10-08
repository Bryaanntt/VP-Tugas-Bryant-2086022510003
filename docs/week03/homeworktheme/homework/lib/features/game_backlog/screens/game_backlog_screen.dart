import 'package:flutter/material.dart';
import '../widgets/game_status.dart';
import '../widgets/game_list_item.dart';
import '../widgets/game_empty_state.dart';
import '../widgets/game_loading_view.dart';

enum GameStatus { playing, finished, dropped, backlog }

class Game {
  final String title;
  final GameStatus status;

  const Game({required this.title, required this.status});
}                   
  
cl  ass GameBacklogScreen extends StatefulWidget {
  const GameBacklogScreen({super.key});

  @override
  State<GameBacklogScreen> createState() => _GameBacklogScreenState();
}

class _GameBacklogScreenState extends State<GameBacklogScreen> {
  bool _isLoading = true;
  GameStatus? _selectedStatus;
  final List<Game> _allGames = [];

  @override
  void initState() {
    super.initState();
    _loadGames();
  }

  Future<void> _loadGames() async {
    await Future.delayed(const Duration(seconds: 1));
    setState(() {
      _allGames.addAll(const [
        Game(title: 'Genshin Impact', status: GameStatus.playing),
        Game(title: 'Honkai: Star Rail', status: GameStatus.playing),
        Game(title: 'Elden Ring', status: GameStatus.finished),
        Game(title: 'Persona 5 Royal', status: GameStatus.finished),
        Game(title: 'Cyberpunk 2077', status: GameStatus.dropped),
        Game(title: 'Baldur\'s Gate 3', status: GameStatus.backlog),
        Game(title: 'Hollow Knight', status: GameStatus.backlog),
      ]);
      _isLoading = false;
    });
  }

  List<Game> get _filteredGames {
    if (_selectedStatus == null) return _allGames;
    return _allGames.where((g) => g.status == _selectedStatus).toList();
  }

  // Game Status Widget
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Game Backlog')),
      body: Column(
        children: [
          GameStatusFilter(
            selectedStatus: _selectedStatus,
            onChanged: (status) {
              setState(() => _selectedStatus = status);
            },
          ),
          Expanded(child: _buildBody()),
        ],
      ),
    );
  }

    // Game List Item Widget
  Widget _buildBody() {
    if (_isLoading) return const GameLoadingView();
    if (_filteredGames.isEmpty) {
      return GameEmptyState(status: _selectedStatus);
    }
    return ListView.builder(
      itemCount: _filteredGames.length,
      itemBuilder: (context, index) {
        final game = _filteredGames[index];
        return GameListItem(
          game: game,
          onTap: () {
            showDialog(
              context: context,
              builder: (context) => SimpleDialog(
                title: const Text('Ubah status'),
                children: GameStatus.values.map((status) {
                  return SimpleDialogOption(
                    onPressed: () {
                      setState(() {
                        final index = _allGames.indexOf(game);
                        _allGames[index] =
                            Game(title: game.title, status: status);
                      });
                      Navigator.pop(context);
                    },
                    child: Text(status.name),
                  );
                }).toList(),
              ),
            );
          },
        );
      },
    );
  }
}