import 'package:flutter/material.dart';
import '../game/snake_game.dart';
import '../game/theme.dart';

class MainMenuOverlay extends StatelessWidget {
  final SnakeGame game;

  const MainMenuOverlay({super.key, required this.game});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        padding: const EdgeInsets.all(20),
        color: Colors.black.withOpacity(0.85),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ShaderMask(
              shaderCallback: (bounds) => const LinearGradient(
                colors: [
                  Color(0xFF4ADE80),
                  Color(0xFF166534),
                ], // green-400 to green-800
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
              ).createShader(bounds),
              child: Text(
                'NEON SNAKE',
                style: CyberpunkTheme.pressStart2P.copyWith(
                  fontSize: 36,
                  color: Colors.white, // Required for ShaderMask
                  shadows: [
                    const Shadow(
                      blurRadius: 10,
                      color: CyberpunkTheme.neonGreen,
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 8),
            Container(
              height: 1,
              width: 128,
              decoration: const BoxDecoration(
                color: Color(0xFF22C55E), // green-500
                boxShadow: [
                  BoxShadow(
                    color: CyberpunkTheme.neonGreen,
                    blurRadius: 10,
                    spreadRadius: 1,
                  ),
                ],
              ),
            ),
            const SizedBox(height: 32),
            Text(
              '// OBJECTIVE: CONSUME DATA PACKETS\n'
              '// AVOID: SYSTEM WALLS & SELF-INTERSECTION\n'
              '// CONTROLS: ARROWS / SWIPE',
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontFamily: 'Courier', // Monospace font for code look
                color: CyberpunkTheme.textGray,
                fontSize: 12,
                height: 1.5,
                letterSpacing: 1.2,
              ),
            ),
            const SizedBox(height: 32),
            MouseRegion(
              cursor: SystemMouseCursors.click,
              child: GestureDetector(
                onTap: () {
                  game.startGame();
                },
                child: Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 32,
                    vertical: 16,
                  ),
                  decoration: BoxDecoration(
                    color: CyberpunkTheme.neonGreen.withOpacity(0.1),
                    border: Border.all(
                      color: const Color(0xFF22C55E),
                    ), // green-500
                    boxShadow: [
                      BoxShadow(
                        color: CyberpunkTheme.neonGreen.withOpacity(0.3),
                        blurRadius: 15,
                      ),
                    ],
                  ),
                  child: Text(
                    'INITIALIZE SYSTEM',
                    style: CyberpunkTheme.pressStart2P.copyWith(
                      color: const Color(0xFF4ADE80), // green-400
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
