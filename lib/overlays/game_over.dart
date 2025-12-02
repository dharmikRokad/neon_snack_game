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
        padding: const EdgeInsets.all(50),
        color: Colors.black.withValues(alpha: 0.85),
        child: Column(
          mainAxisSize: MainAxisSize.min,
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
                    ).withValues(alpha: 0.2), // red-900/20
                    border: Border.all(color: CyberpunkTheme.errorRed),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.red.withValues(alpha: 0.5),
                        blurRadius: 10,
                      ),
                    ],
                  ),
                  child: Text(
                    'PLAY AGAIN',
                    style: CyberpunkTheme.pressStart2P.copyWith(
                      color: CyberpunkTheme.errorRed,
                      fontSize: 14,
                      letterSpacing: 2,
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 32),
            MouseRegion(
              cursor: SystemMouseCursors.click,
              child: GestureDetector(
                onTap: () {
                  game.overlays.remove('GameOver');
                  game.overlays.add('MainMenu');
                },
                child: Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 32,
                    vertical: 16,
                  ),
                  decoration: BoxDecoration(
                    color: const Color(
                      0xFF7F1D1D,
                    ).withValues(alpha: 0.2), // red-900/20
                    border: Border.all(color: CyberpunkTheme.errorRed),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.red.withValues(alpha: 0.5),
                        blurRadius: 10,
                      ),
                    ],
                  ),
                  child: Text(
                    'BACK TO MENU',
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
