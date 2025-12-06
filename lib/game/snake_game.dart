import 'package:flame/game.dart';
import 'package:flame/input.dart';
import 'package:flutter/services.dart';
import 'package:flutter/material.dart';
import 'package:snake_game_flame/game/grid_background.dart';
import 'package:snake_game_flame/utils/shared_prefs.dart';
import 'package:snake_game_flame/utils/audio_manager.dart';
import 'snake.dart';
import 'food.dart';
import 'theme.dart';

class SnakeGame extends FlameGame with KeyboardEvents, ChangeNotifier {
  late Snake snake;
  late Food food;
  static const double gridSize = 20.0;

  double _timeSinceLastMove = 0;
  double speed = 0.15;

  int score = 0;
  int highScore = SharedPrefs().getHighScore();

  // Game State
  bool isPlaying = false;
  bool isGameOver = false;
  bool showSettings = false;

  @override
  Color backgroundColor() => CyberpunkTheme.background;

  @override
  Future<void> onLoad() async {
    // Initialize audio
    await AudioManager().initialize();

    // Grid Background
    add(GridBackground());

    snake = Snake();
    food = Food();
    add(snake);
    add(food);

    // Initial State
    pauseEngine();
    overlays.add('MainMenu');

    // Start background music
    // await AudioManager().startBackgroundMusic();
  }

  void startGame() async {
    resetGameState();
    overlays.remove('MainMenu');
    overlays.remove('GameOver');
    overlays.add('GameOverlay');
    resumeEngine();
    isPlaying = true;
    isGameOver = false;
    notifyListeners();

    // ✅ First time we actually start the music, after user interaction
    await AudioManager().startBackgroundMusic();
  }

  void restartFromMain() {
    overlays.remove('GameOver');
    overlays.add('MainMenu');
  }

  void refreshTheme() {
    // Force rebuild of overlays when theme changes
    final activeOverlays = overlays.activeOverlays.toList();
    for (final overlay in activeOverlays) {
      overlays.remove(overlay);
      overlays.add(overlay);
    }
  }

  void resetGameState() {
    snake.reset();
    food.respawn(size, gridSize);
    speed = 0.125; // 8 FPS approx (1000/8 = 125ms)
    score = 0;
    _timeSinceLastMove = 0;
  }

  @override
  void update(double dt) {
    if (!isPlaying) return;

    super.update(dt);
    _timeSinceLastMove += dt;
    if (_timeSinceLastMove > speed) {
      snake.move();
      _timeSinceLastMove = 0;
      checkCollisions();
    }
  }

  void checkCollisions() {
    if (snake.head == food.gridPosition) {
      // Play eat sound effect
      AudioManager().playEatSound();

      food.respawn(size, gridSize);
      snake.grow();
      increaseSpeed();
      score++;
      if (score > highScore) {
        highScore = score;
        SharedPrefs().setHighScore(highScore);
      }
      notifyListeners();
      // Force overlay rebuild to update score
      overlays.remove('GameOverlay');
      overlays.add('GameOverlay');
    }

    if (snake.checkCollisionWithSelf() ||
        snake.checkCollisionWithWalls(size, gridSize)) {
      triggerGameOver();
    }
  }

  void increaseSpeed() {
    // Cap speed at some point
    if (speed > 0.03) {
      speed -= 0.002;
    }
  }

  void triggerGameOver() {
    isPlaying = false;
    isGameOver = true;
    pauseEngine();

    // Play game over sound and pause background music
    AudioManager().playGameOverSound();
    AudioManager().pauseBackgroundMusic();

    overlays.remove('GameOverlay');
    overlays.add('GameOver');
    notifyListeners();
  }

  void togglePause() {
    if (isGameOver) return;

    if (isPlaying) {
      isPlaying = false;
      pauseEngine();
      AudioManager().pauseBackgroundMusic();
    } else {
      isPlaying = true;
      resumeEngine();
      AudioManager().resumeBackgroundMusic();
    }
    overlays.remove('GameOverlay');
    overlays.add('GameOverlay');
    notifyListeners();
  }

  /// Track if game was playing before opening settings
  bool _wasPlayingBeforeSettings = false;

  void toggleSettings() {
    showSettings = !showSettings;

    if (showSettings) {
      // Store current playing state and pause if playing
      _wasPlayingBeforeSettings = isPlaying;
      if (isPlaying) {
        isPlaying = false;
        pauseEngine();
      }
      overlays.add('Settings');
    } else {
      overlays.remove('Settings');
      // Resume only if game was playing before opening settings and not game over
      if (_wasPlayingBeforeSettings && !isGameOver) {
        isPlaying = true;
        resumeEngine();
      }
    }
    notifyListeners();
  }

  void onArrowKey(Vector2 direction) {
    if (isPlaying && !isGameOver) {
      snake.changeDirection(direction);
    }
  }

  @override
  KeyEventResult onKeyEvent(
    KeyEvent event,
    Set<LogicalKeyboardKey> keysPressed,
  ) {
    if (event is KeyDownEvent) {
      if (keysPressed.contains(LogicalKeyboardKey.arrowUp)) {
        onArrowKey(Vector2(0, -1));
      } else if (keysPressed.contains(LogicalKeyboardKey.arrowDown)) {
        onArrowKey(Vector2(0, 1));
      } else if (keysPressed.contains(LogicalKeyboardKey.arrowLeft)) {
        onArrowKey(Vector2(-1, 0));
      } else if (keysPressed.contains(LogicalKeyboardKey.arrowRight)) {
        onArrowKey(Vector2(1, 0));
      } else if (keysPressed.contains(LogicalKeyboardKey.space)) {
        togglePause();
      }
    }
    return KeyEventResult.handled;
  }
}
