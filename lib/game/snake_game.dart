import 'package:flame/game.dart';
import 'package:flame/input.dart';
import 'package:flutter/services.dart';
import 'package:flutter/material.dart';
import 'package:snake_game_flame/game/grid_background.dart';
import 'snake.dart';
import 'food.dart';
import 'theme.dart';

/// SnakeGame is now a pure Flame engine - handling only game loop and rendering.
/// UI state is managed by GameController.
class SnakeGame extends FlameGame with KeyboardEvents {
  late Snake snake;
  late Food food;
  static const double gridSize = 20.0;

  double _timeSinceLastMove = 0;
  double speed = 0.15;

  // Callbacks to notify controller
  final VoidCallback? onFoodEaten;
  final VoidCallback? onGameOver;
  final KeyEventResult Function(KeyEvent, Set<LogicalKeyboardKey>) onKeyboardKey;

  SnakeGame({
    this.onFoodEaten,
    this.onGameOver,
    required this.onKeyboardKey,
  });

  @override
  Color backgroundColor() => CyberpunkTheme.background;

  @override
  Future<void> onLoad() async {
    // Grid Background
    add(GridBackground());

    snake = Snake();
    food = Food();
    add(snake);
    add(food);

    // Initial State - paused until controller starts game
    pauseEngine();
  }

  void resetGameState() {
    snake.reset();
    food.respawn(size, gridSize);
    speed = 0.125; // 8 FPS approx (1000/8 = 125ms)
    _timeSinceLastMove = 0;
  }

  @override
  void update(double dt) {
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
      food.respawn(size, gridSize);
      snake.grow();
      increaseSpeed();
      onFoodEaten?.call();
    }

    if (snake.checkCollisionWithSelf() ||
        snake.checkCollisionWithWalls(size, gridSize)) {
      onGameOver?.call();
    }
  }

  void increaseSpeed() {
    // Cap speed at some point
    if (speed > 0.03) {
      speed -= 0.002;
    }
  }

  @override
  KeyEventResult onKeyEvent(
    KeyEvent event,
    Set<LogicalKeyboardKey> keysPressed,
  )  => onKeyboardKey(event, keysPressed);
}
