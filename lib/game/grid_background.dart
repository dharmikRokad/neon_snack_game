import 'package:flame/components.dart';
import 'package:flutter/material.dart';
import 'package:snake_game_flame/game/snake_game.dart';
import 'package:snake_game_flame/game/theme.dart';

class GridBackground extends Component with HasGameReference<SnakeGame> {
  @override
  void render(Canvas canvas) {
    final paint = Paint()
      ..color = CyberpunkTheme.gridLine
      ..strokeWidth = 1
      ..style = PaintingStyle.stroke;

    final borderPaint = Paint()
      ..color = CyberpunkTheme.primary
      ..strokeWidth = 5
      ..style = PaintingStyle.stroke;

    // Draw Vertical Lines
    for (double x = 0; x <= game.size.x; x += SnakeGame.gridSize) {
      canvas.drawLine(
        Offset(x, 0),
        Offset(x, game.size.y),
        (x == 0 || x == game.size.x) ? borderPaint : paint,
      );
    }

    // Draw Horizontal Lines
    for (double y = 0; y <= game.size.y; y += SnakeGame.gridSize) {
      canvas.drawLine(
        Offset(0, y),
        Offset(game.size.x, y),
        (y == 0 || y == game.size.y) ? borderPaint : paint,
      );
    }
  }
}
