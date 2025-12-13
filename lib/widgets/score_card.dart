import 'package:flutter/material.dart';
import 'package:snake_game_flame/game/theme.dart';

class ScoreCard extends StatelessWidget {
  const ScoreCard({super.key, required this.label, required this.value});

  final String label;
  final int value;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: CyberpunkTheme.glassBackground,
        borderRadius: BorderRadius.circular(4),
        border: Border.all(color: CyberpunkTheme.glassBorder),
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
}
