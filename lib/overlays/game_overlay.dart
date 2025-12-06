import 'package:flutter/material.dart';

/// Game overlay with scanline effect - displayed during gameplay.
class GameOverlay extends StatelessWidget {
  const GameOverlay({super.key});

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
