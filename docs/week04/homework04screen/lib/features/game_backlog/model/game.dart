enum GameStatus { playing, finished, dropped, backlog }

extension GameStatusLabel on GameStatus {
  String get label {
    switch (this) {
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
}

class Game {
  final String title;
  final GameStatus status;

  const Game({required this.title, required this.status});

  Game copyWith({String? title, GameStatus? status}) {
    return Game(title: title ?? this.title, status: status ?? this.status);
  }
}