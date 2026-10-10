import 'package:flutter/foundation.dart';
import '../data/game_data.dart';
import '../model/game.dart';

class GameBacklogController extends ChangeNotifier {
  GameBacklogController(this._data);

  final GameData _data;

  bool _isLoading = true;
  bool _disposed = false;
  GameStatus? _selectedStatus;
  String _query = '';
  List<Game> _games = [];
  String get query => _query;
  bool get hasActiveFilter => _selectedStatus != null || _query.isNotEmpty;

  bool get isLoading => _isLoading;
  GameStatus? get selectedStatus => _selectedStatus;

  List<Game> get filteredGames {
    if (_selectedStatus == null && _query.isEmpty) return _games;
    return _games.where((g) {
      final matchesStatus = _selectedStatus == null || g.status == _selectedStatus;
      final matchesQuery = _query.isEmpty || g.title.toLowerCase().contains(_query.toLowerCase());
      return matchesStatus && matchesQuery;
    }).toList();
  }

  Future<void> load() async {
    _isLoading = true;
    notifyListeners();
    _games = await _data.fetchGames();
    _isLoading = false;
    notifyListeners();
  }

  void selectStatus(GameStatus? status) {
    _selectedStatus = status;
    notifyListeners();
  }

  void search(String value) {
    _query = value;
    notifyListeners();
  }

  void clearFilters() {
    _query = '';
    _selectedStatus = null;
    notifyListeners();
  }

  void changeStatus(Game game, GameStatus newStatus) {
    final index = _games.indexOf(game);
    if (index == -1) return;
    _games[index] = game.copyWith(status: newStatus);
    notifyListeners();
  }

  @override
  void notifyListeners() {
    if (_disposed) return;
    super.notifyListeners();
  }

  @override
  void dispose() {
    _disposed = true;
    super.dispose();
  }
}