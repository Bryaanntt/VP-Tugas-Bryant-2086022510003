import '../model/game.dart';

abstract class GameData {
  Future<List<Game>> fetchGames();
}

class SampleGameData implements GameData {
  const SampleGameData({
    this.games,
    this.delay = const Duration(seconds: 1),
  });

  final List<Game>? games;
  final Duration delay;

  static const List<Game> defaultGames = [
    Game(title: 'Genshin Impact', status: GameStatus.playing),
    Game(title: 'Honkai: Star Rail', status: GameStatus.playing),
    Game(title: 'Elden Ring', status: GameStatus.finished),
    Game(title: 'Persona 5 Royal', status: GameStatus.finished),
    Game(title: 'Cyberpunk 2077', status: GameStatus.dropped),
    Game(title: 'Baldur\'s Gate 3', status: GameStatus.backlog),
    Game(title: 'Hollow Knight', status: GameStatus.backlog),
  ];

  @override
  Future<List<Game>> fetchGames() async {
    await Future.delayed(delay);
    return List<Game>.of(games ?? defaultGames);
  }
}