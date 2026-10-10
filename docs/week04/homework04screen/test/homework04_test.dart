// =============================================================================
// lab04_test.dart — Week 4 Lab: the nine tests, automated
// IMT01303305 Visual Programming · Module 1 · UI Layer
//
// Sixteen cases covering the nine tests, plus one bonus.
//
// Put this file at  lab04/test/lab04_test.dart  and run:
//   flutter test test/lab04_test.dart
//
// Every test sets a screen size (and sometimes a keyboard, a notch, or a data
// set), pumps the app, and fails if Flutter reports ANY layout error —
// "A RenderFlex overflowed…", "unbounded height", a RangeError, anything.
//
// ONE THING TO KNOW: flutter test draws text with a test font in which every
// letter is a full square, so text is much wider here than on a phone. If a
// test fails but the harness looks fine, that text has no overflow strategy
// (maxLines + ellipsis, or room to wrap). Fix the strategy, not the font.
//
// If your project is not called lab04, change "package:lab04/" below.
// =============================================================================

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:homework/features/game_backlog/screens/game_backlog_screen.dart';
import 'package:homework/features/game_backlog/widgets/game_list_item.dart';

const Size small = Size(320, 568);
const Size large = Size(430, 932);
const Size tablet = Size(800, 1280);

const List<(String, Size)> screens = [
  ('small phone', small),
  ('large phone', large),
  ('tablet', tablet),
];

/// 200 karakter dengan spasi, supaya bisa membungkus baris.
final String longTitle = List.filled(20, 'abcdefghi ').join();

List<Game> sampleGames(int count) => List.generate(
      count,
      (i) => Game(
        title: 'Game ${i + 1}',
        status: GameStatus.values[i % GameStatus.values.length],
      ),
    );

Future<void> pumpScreen(
  WidgetTester tester,
  Size size, {
  List<Game>? games,
  double keyboard = 0,
  double topInset = 0,
  double bottomInset = 0,
  ThemeMode theme = ThemeMode.light,
}) async {
  tester.view.devicePixelRatio = 1.0;
  tester.view.physicalSize = size;
  tester.view.viewInsets = FakeViewPadding(bottom: keyboard);
  tester.view.padding = FakeViewPadding(top: topInset, bottom: bottomInset);
  tester.view.viewPadding = FakeViewPadding(top: topInset, bottom: bottomInset);
  addTearDown(tester.view.reset);

  const seed = Color(0xFF7C5CFF);
  await tester.pumpWidget(
    MaterialApp(
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(seedColor: seed),
      ),
      darkTheme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(
          seedColor: seed,
          brightness: Brightness.dark,
        ),
      ),
      themeMode: theme,
      home: GameBacklogScreen(
        games: games ?? sampleGames(7),
        loadDelay: Duration.zero,
      ),
    ),
  );
  await tester.pumpAndSettle();
}

void expectNoLayoutErrors(WidgetTester tester) {
  final Object? error = tester.takeException();
  expect(error, isNull, reason: 'Layout error:\n$error');
}

/// List utama yang di-scroll ke bawah (bukan baris chip filter yang horizontal).
Finder get mainScrollable => find
    .byWidgetPredicate(
      (w) => w is Scrollable && w.axisDirection == AxisDirection.down,
    )
    .first;

void main() {
  group('Homework 04 - Game Backlog screen', () {
    testWidgets('1 · small phone, 320 dp', (tester) async {
      await pumpScreen(tester, small);
      expectNoLayoutErrors(tester);
    });

    testWidgets('2 · large phone, 430 dp', (tester) async {
      await pumpScreen(tester, large);
      expectNoLayoutErrors(tester);
    });

    testWidgets('3 · tablet 800 dp - layout berubah jadi grid', (tester) async {
      await pumpScreen(tester, tablet);
      expectNoLayoutErrors(tester);
      expect(find.byType(GridView), findsOneWidget,
          reason: 'Di 800 dp list harus berubah jadi grid.');
    });

    testWidgets('3 · phone tetap memakai list', (tester) async {
      await pumpScreen(tester, small);
      expect(find.byType(GridView), findsNothing);
    });

    for (final (name, size) in screens) {
      testWidgets('4 · landscape - $name', (tester) async {
        await pumpScreen(tester, size.flipped);
        expectNoLayoutErrors(tester);
      });
    }

    for (final (name, size) in screens) {
      testWidgets('5 · judul 200 karakter - $name', (tester) async {
        await pumpScreen(
          tester,
          size,
          games: [
            Game(title: longTitle, status: GameStatus.playing),
            ...sampleGames(6),
          ],
        );
        expectNoLayoutErrors(tester);
      });
    }

    testWidgets('6 · zero items menampilkan empty state', (tester) async {
      await pumpScreen(tester, small, games: const <Game>[]);
      expectNoLayoutErrors(tester);
      expect(find.byKey(const Key('empty-state')), findsOneWidget,
          reason: "Butuh widget dengan key: const Key('empty-state').");
    });

    testWidgets('7 · 500 items dibangun lazy', (tester) async {
      await pumpScreen(tester, small, games: sampleGames(500));
      expectNoLayoutErrors(tester);
      expect(find.byType(GameListItem).evaluate().length, lessThan(100),
          reason: 'Hanya item yang terlihat yang boleh dibangun.');

      for (var i = 0; i < 5; i++) {
        await tester.fling(mainScrollable, const Offset(0, -2000), 3000);
        await tester.pumpAndSettle();
      }
      expectNoLayoutErrors(tester);
    });

        testWidgets('8 · keyboard terbuka: field tetap terlihat', (tester) async {
      await pumpScreen(tester, small, keyboard: 260);
      expectNoLayoutErrors(tester);
      final field = tester.getRect(find.byKey(const Key('search-field')));
      expect(field.bottom, lessThanOrEqualTo(small.height - 260),
          reason: 'Search field tertutup keyboard.');
      expect(tester.getRect(mainScrollable).bottom,
          lessThanOrEqualTo(small.height - 260),
          reason: 'Daftar harus berakhir di atas keyboard.');
    });

    testWidgets('8 · keyboard terbuka di landscape', (tester) async {
      await pumpScreen(tester, small.flipped, keyboard: 180);
      expectNoLayoutErrors(tester);
      final field = tester.getRect(find.byKey(const Key('search-field')));
      expect(field.bottom, lessThanOrEqualTo(small.flipped.height - 180));
    });

    testWidgets('pencarian memfilter, hasil kosong memunculkan empty state',
        (tester) async {
      await pumpScreen(tester, small);
      await tester.enterText(find.byKey(const Key('search-field')), 'Game 1');
      await tester.pumpAndSettle();
      expectNoLayoutErrors(tester);
      expect(find.byType(GameListItem), findsOneWidget);

      await tester.enterText(find.byKey(const Key('search-field')), 'zzz');
      await tester.pumpAndSettle();
      expect(find.byKey(const Key('empty-state')), findsOneWidget);
    });

    for (final (name, size) in screens) {
      testWidgets('9 · dark mode - $name', (tester) async {
        await pumpScreen(tester, size, theme: ThemeMode.dark);
        expectNoLayoutErrors(tester);
      });
    }

    testWidgets('Bonus · notch dan gesture bar', (tester) async {
      await pumpScreen(tester, small, topInset: 32, bottomInset: 20);
      expectNoLayoutErrors(tester);
    });
  });
}