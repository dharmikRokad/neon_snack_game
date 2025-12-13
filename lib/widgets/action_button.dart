import 'package:flutter/material.dart';
import 'package:snake_game_flame/game/theme.dart';

class ActionButton extends StatelessWidget {
  const ActionButton({
    super.key,
    required this.icon,
    this.tooltip,
    this.onTap,
    this.size = 48,
  });

  final IconData icon;
  final String? tooltip;
  final VoidCallback? onTap;
  final double size;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      child: Tooltip(
        message: tooltip ?? '',
        child: GestureDetector(
          onTap: onTap,
          child: Container(
            width: size,
            height: size,
            decoration: BoxDecoration(
              color: CyberpunkTheme.glassBackground,
              border: Border.all(color: CyberpunkTheme.glassBorder),
              borderRadius: BorderRadius.circular(4),
              boxShadow: [
                BoxShadow(
                  color: CyberpunkTheme.primary.withValues(alpha: 0.2),
                  blurRadius: 8,
                ),
              ],
            ),
            child: Icon(icon, color: CyberpunkTheme.primary, size: size * 0.5),
          ),
        ),
      ),
    );
  }
}
