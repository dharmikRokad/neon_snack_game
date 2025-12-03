import 'package:flame/components.dart';
import 'package:flutter/material.dart';
import 'snake_game.dart';
import 'theme.dart';

class Snake extends PositionComponent with HasGameRef<SnakeGame> {
  final List<Vector2> body = [Vector2(5, 5), Vector2(4, 5), Vector2(3, 5)];
  Vector2 direction = Vector2(1, 0);
  Vector2 _nextDirection = Vector2(1, 0);

  Vector2 get head => body.first;

  @override
  void render(Canvas canvas) {
    for (int i = 0; i < body.length; i++) {
      final segment = body[i];
      final isHead = i == 0;
      final isTail = i == body.length - 1;

      final paint = Paint();

      if (isHead) {
        paint.color = CyberpunkTheme.primaryBright;
        paint.maskFilter = const MaskFilter.blur(
          BlurStyle.solid,
          2,
        ); // Slight blur for glow
        // Note: Canvas.drawRect doesn't support box-shadow directly like CSS.
        // We can simulate it by drawing a blurred rect behind or using MaskFilter.
        // Or just use the color.
      } else if (isTail) {
        paint.color = CyberpunkTheme.primaryDim;
      } else {
        paint.color = CyberpunkTheme.primary;
      }

      // Draw Glow (Shadow)
      if (isHead || i < 10) {
        // Glow for head and first few segments
        final glowPaint = Paint()
          ..color = CyberpunkTheme.primary.withValues(alpha: 0.6)
          ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 8);

        canvas.drawRect(
          Rect.fromLTWH(
            segment.x * SnakeGame.gridSize,
            segment.y * SnakeGame.gridSize,
            SnakeGame.gridSize,
            SnakeGame.gridSize,
          ),
          glowPaint,
        );
      }

      // Draw Segment
      canvas.drawRect(
        Rect.fromLTWH(
          segment.x * SnakeGame.gridSize + 1,
          segment.y * SnakeGame.gridSize + 1,
          SnakeGame.gridSize - 2,
          SnakeGame.gridSize - 2,
        ),
        paint,
      );
    }
  }

  void move() {
    direction = _nextDirection;
    final newHead = head + direction;
    body.insert(0, newHead);
    body.removeLast();
  }

  void grow() {
    final tail = body.last;
    body.add(tail);
  }

  void changeDirection(Vector2 newDir) {
    // Prevent 180 degree turns
    if (newDir.x != -direction.x || newDir.y != -direction.y) {
      _nextDirection = newDir;
    }
  }

  bool checkCollisionWithSelf() {
    for (int i = 1; i < body.length; i++) {
      if (head == body[i]) return true;
    }
    return false;
  }

  bool checkCollisionWithWalls(Vector2 gameSize, double gridSize) {
    if (head.x < 0 || head.y < 0) return true;

    final maxX = (gameSize.x / gridSize).floor();
    final maxY = (gameSize.y / gridSize).floor();

    if (head.x >= maxX || head.y >= maxY) return true;

    return false;
  }

  void reset() {
    body.clear();
    body.addAll([Vector2(5, 5), Vector2(4, 5), Vector2(3, 5)]);
    direction = Vector2(1, 0);
    _nextDirection = Vector2(1, 0);
  }
}
