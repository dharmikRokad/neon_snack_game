import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:snake_game_flame/controllers/game_controller.dart';
import '../game/theme.dart';

/// Game over overlay using Provider for state management.
class GameOverOverlay extends StatelessWidget {
  const GameOverOverlay({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = context.watch<GameController>();

    return Center(
      child: Container(
        padding: const EdgeInsets.all(50),
        color: Colors.black.withValues(alpha: 0.85),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'GAME OVER',
              style: CyberpunkTheme.pressStart2P.copyWith(
                fontSize: 30,
                color: CyberpunkTheme.errorRed,
                shadows: [const Shadow(blurRadius: 10, color: Colors.red)],
              ),
            ),
            const SizedBox(height: 24),
            Text(
              'FINAL SCORE: ${controller.score}',
              style: CyberpunkTheme.pressStart2P.copyWith(
                fontSize: 20,
                color: Colors.white,
              ),
            ),
            const SizedBox(height: 32),
            MouseRegion(
              cursor: SystemMouseCursors.click,
              child: GestureDetector(
                onTap: () => controller.startGame(),
                child: Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 32,
                    vertical: 16,
                  ),
                  decoration: BoxDecoration(
                    color: const Color(0xFF7F1D1D).withValues(alpha: 0.2),
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
                onTap: () => controller.restartFromMain(),
                child: Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 32,
                    vertical: 16,
                  ),
                  decoration: BoxDecoration(
                    color: const Color(0xFF7F1D1D).withValues(alpha: 0.2),
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
