import 'package:flutter/material.dart';
import '../game/snake_game.dart';
import '../game/theme.dart';

class GameOverOverlay extends StatelessWidget {
  final SnakeGame game;

  const GameOverOverlay({super.key, required this.game});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        padding: const EdgeInsets.all(20),
        color: Colors.black.withOpacity(0.85),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'SYSTEM FAILURE',
              style: CyberpunkTheme.pressStart2P.copyWith(
                fontSize: 30,
                color: CyberpunkTheme.errorRed,
                shadows: [const Shadow(blurRadius: 10, color: Colors.red)],
              ),
            ),
            const SizedBox(height: 24),
            Text(
              'FINAL SCORE: ${game.score}',
              style: CyberpunkTheme.pressStart2P.copyWith(
                fontSize: 20,
                color: Colors.white,
              ),
            ),
            const SizedBox(height: 32),
            MouseRegion(
              cursor: SystemMouseCursors.click,
              child: GestureDetector(
                onTap: () {
                  game.resetGame();
                },
                child: Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 32,
                    vertical: 16,
                  ),
                  decoration: BoxDecoration(
                    color: const Color(
                      0xFF7F1D1D,
                    ).withOpacity(0.2), // red-900/20
                    border: Border.all(color: CyberpunkTheme.errorRed),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.red.withOpacity(0.5),
                        blurRadius: 10,
                      ),
                    ],
                  ),
                  child: Text(
                    'REBOOT SYSTEM',
                    style: CyberpunkTheme.pressStart2P.copyWith(
                      color: CyberpunkTheme.errorRed,
                      fontSize: 14,
                      letterSpacing: 2,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
