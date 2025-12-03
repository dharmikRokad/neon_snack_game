import 'dart:math';
import 'package:flame/components.dart';
import 'package:flutter/material.dart';
import 'snake_game.dart';

import 'theme.dart';

class Food extends PositionComponent {
  Vector2 gridPosition = Vector2(10, 10);
  final Random _rnd = Random();
  double _time = 0;

  @override
  void update(double dt) {
    super.update(dt);
    _time += dt;
  }

  @override
  void render(Canvas canvas) {
    // Pulsing effect
    final sizeOffset = sin(_time * 5) * 2;

    // Glow
    final glowPaint = Paint()
      ..color = CyberpunkTheme.neonPink.withValues(alpha: 0.6)
      ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 10);

    canvas.drawRect(
      Rect.fromLTWH(
        gridPosition.x * SnakeGame.gridSize - 2,
        gridPosition.y * SnakeGame.gridSize - 2,
        SnakeGame.gridSize + 4,
        SnakeGame.gridSize + 4,
      ),
      glowPaint,
    );

    // Core
    final paint = Paint()..color = CyberpunkTheme.neonPink;

    canvas.drawRect(
      Rect.fromLTWH(
        gridPosition.x * SnakeGame.gridSize + 2 - sizeOffset / 2,
        gridPosition.y * SnakeGame.gridSize + 2 - sizeOffset / 2,
        SnakeGame.gridSize - 4 + sizeOffset,
        SnakeGame.gridSize - 4 + sizeOffset,
      ),
      paint,
    );
  }

  void respawn(Vector2 gameSize, double gridSize) {
    final maxX = (gameSize.x / gridSize).floor();
    final maxY = (gameSize.y / gridSize).floor();

    gridPosition = Vector2(
      _rnd.nextInt(maxX).toDouble(),
      _rnd.nextInt(maxY).toDouble(),
    );
  }
}
