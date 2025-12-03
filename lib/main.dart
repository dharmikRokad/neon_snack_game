import 'package:flame/game.dart';
import 'package:flutter/widgets.dart';
import 'package:snake_game_flame/utils/shared_prefs.dart';
import 'game/snake_game.dart';
import 'overlays/main_menu.dart';
import 'overlays/game_over.dart';
import 'overlays/game_overlay.dart';

void main() async {
  await SharedPrefs().init();

  runApp(
    GameWidget<SnakeGame>.controlled(
      gameFactory: SnakeGame.new,
      overlayBuilderMap: {
        'MainMenu': (_, game) => MainMenuOverlay(game: game),
        'GameOver': (_, game) => GameOverOverlay(game: game),
        'GameOverlay': (_, game) => GameOverlay(game: game),
      },
      initialActiveOverlays: const ['MainMenu'],
    ),
  );
}
