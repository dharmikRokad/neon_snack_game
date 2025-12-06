import 'package:flutter/material.dart';
import '../game/snake_game.dart';

class GameOverlay extends StatelessWidget {
  final SnakeGame game;

  const GameOverlay({super.key, required this.game});

  @override
  Widget build(BuildContext context) {
    // Only show scanlines overlay - HUD is now in ControlPanel
    return const Positioned.fill(child: IgnorePointer(child: ScanlineWidget()));
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
