import 'package:flutter/material.dart';
import '../game/snake_game.dart';
import '../game/theme.dart';
import 'package:flame/game.dart';

class GameOverlay extends StatelessWidget {
  final SnakeGame game;

  const GameOverlay({super.key, required this.game});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        // Scanlines (Pointer events none)
        const Positioned.fill(child: IgnorePointer(child: ScanlineWidget())),

        // HUD
        Positioned(
          top: 16,
          left: 16,
          right: 16,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _buildScoreBox('SCORE', game.score),
              _buildScoreBox('HI-SCORE', game.highScore),
            ],
          ),
        ),

        // Controls (Bottom)
        Positioned(
          bottom: 20,
          right: 10,
          child: Center(
            child: Opacity(
              opacity: 0.5, // Make it semi-transparent
              child: _buildDPad(game),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildScoreBox(String label, int value) {
    return Container(
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: Colors.black.withValues(alpha: 0.4),
        borderRadius: BorderRadius.circular(4),
        border: Border.all(
          color: const Color(0xFF14532D).withValues(alpha: 0.5),
        ), // green-900/50
      ),
      child: Column(
        children: [
          Text(label, style: CyberpunkTheme.hudScoreLabel),
          const SizedBox(height: 8),
          Text('$value', style: CyberpunkTheme.hudScoreValue),
        ],
      ),
    );
  }

  Widget _buildDPad(SnakeGame game) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        _buildControlBtn('▲', () => game.onArrowKey(Vector2(0, -1))),
        Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            _buildControlBtn('◀', () => game.onArrowKey(Vector2(-1, 0))),
            const SizedBox(width: 60), // Space for Down button in grid
            _buildControlBtn('▶', () => game.onArrowKey(Vector2(1, 0))),
          ],
        ),
        _buildControlBtn('▼', () => game.onArrowKey(Vector2(0, 1))),
      ],
    );
  }

  Widget _buildControlBtn(String label, VoidCallback onTap) {
    return GestureDetector(
      onTapDown: (_) => onTap(),
      child: Container(
        width: 60,
        height: 50,
        margin: const EdgeInsets.all(4),
        decoration: BoxDecoration(
          color: CyberpunkTheme.glassBackground,
          border: Border.all(color: CyberpunkTheme.glassBorder),
          borderRadius: BorderRadius.circular(4),
          boxShadow: [
            BoxShadow(
              color: CyberpunkTheme.primaryDim.withValues(alpha: 0.1),
              blurRadius: 5,
            ),
          ],
        ),
        child: Center(
          child: Text(
            label,
            style: TextStyle(color: CyberpunkTheme.primary, fontSize: 20),
          ),
        ),
      ),
    );
  }
}

class ScanlineWidget extends StatelessWidget {
  const ScanlineWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            Colors.transparent,
            Colors.transparent,
            Color.fromRGBO(0, 0, 0, 0.2),
            Color.fromRGBO(0, 0, 0, 0.2),
          ],
          stops: [0, 0.5, 0.5, 1],
          tileMode: TileMode.repeated,
        ),
      ),
      // We can use a CustomPainter for more complex scanlines if needed,
      // but a repeating gradient is a good CSS approximation.
      // However, LinearGradient doesn't support 'background-size' directly in BoxDecoration
      // the same way CSS does for repeating patterns easily without a shader.
      // Let's use a CustomPainter for the scanlines to be safe and accurate.
      child: CustomPaint(painter: ScanlinePainter()),
    );
  }
}

class ScanlinePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.black.withValues(alpha: 0.2)
      ..style = PaintingStyle.fill;

    for (double y = 0; y < size.height; y += 4) {
      canvas.drawRect(Rect.fromLTWH(0, y + 2, size.width, 2), paint);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
