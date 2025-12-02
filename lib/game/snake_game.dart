import 'package:flame/components.dart';
import 'package:flame/game.dart';
import 'package:flame/input.dart';
import 'package:flutter/services.dart';
import 'package:flutter/material.dart';
import 'snake.dart';
import 'food.dart';
import 'theme.dart';

class SnakeGame extends FlameGame with KeyboardEvents {
  late Snake snake;
  late Food food;
  static const double gridSize = 20.0;

  double _timeSinceLastMove = 0;
  double speed = 0.15;

  int score = 0;
  int highScore = 0;

  // Game State
  bool isPlaying = false;
  bool isGameOver = false;

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

    // Initial State
    pauseEngine();
    overlays.add('MainMenu');
  }

  void startGame() {
    resetGameState();
    overlays.remove('MainMenu');
    overlays.remove('GameOver');
    overlays.add('GameOverlay');
    resumeEngine();
    isPlaying = true;
    isGameOver = false;
  }

  void resetGame() {
    startGame();
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
      food.respawn(size, gridSize);
      snake.grow();
      increaseSpeed();
      score++;
      if (score > highScore) {
        highScore = score;
      }
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
    overlays.remove('GameOverlay');
    overlays.add('GameOver');
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
        if (!isPlaying && !isGameOver) {
          startGame();
        } else if (isGameOver) {
          resetGame();
        }
      }
    }
    return KeyEventResult.handled;
  }
}

class GridBackground extends Component with HasGameRef<SnakeGame> {
  @override
  void render(Canvas canvas) {
    final paint = Paint()
      ..color = CyberpunkTheme.gridLine
      ..strokeWidth = 1
      ..style = PaintingStyle.stroke;

    // Draw Vertical Lines
    for (double x = 0; x <= gameRef.size.x; x += SnakeGame.gridSize) {
      canvas.drawLine(Offset(x, 0), Offset(x, gameRef.size.y), paint);
    }

    // Draw Horizontal Lines
    for (double y = 0; y <= gameRef.size.y; y += SnakeGame.gridSize) {
      canvas.drawLine(Offset(0, y), Offset(gameRef.size.x, y), paint);
    }
  }
}
