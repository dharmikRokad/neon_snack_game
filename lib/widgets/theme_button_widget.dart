import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:snake_game_flame/controllers/game_controller.dart';
import 'package:snake_game_flame/game/theme.dart';

class ThemeButtonWidget extends StatelessWidget {
  ThemeButtonWidget({super.key, required this.theme}) {
    themeData = GameThemeData.fromEnum(theme);
  }

  final GameTheme theme;
  late final GameThemeData themeData;

  @override
  Widget build(BuildContext context) {
    final isSelected = CyberpunkTheme.current == themeData;

    return MouseRegion(
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
        onTap: () => context.read<GameController>().changeTheme(theme),
        child: Container(
          height: 60,
          width: 120,
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: isSelected
                ? themeData.primary.withValues(alpha: 0.2)
                : Colors.black.withValues(alpha: 0.5),
            border: Border.all(
              color: isSelected
                  ? themeData.primary
                  : themeData.primary.withValues(alpha: 0.3),
              width: isSelected ? 2 : 1,
            ),
            boxShadow: isSelected
                ? [
                    BoxShadow(
                      color: themeData.primary.withValues(alpha: 0.5),
                      blurRadius: 10,
                    ),
                  ]
                : null,
          ),
          child: Column(
            children: [
              Text(
                themeData.name,
                style: CyberpunkTheme.pressStart2P.copyWith(
                  fontSize: 8,
                  color: isSelected
                      ? themeData.primary
                      : CyberpunkTheme.textGray,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 8),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    width: 16,
                    height: 16,
                    decoration: BoxDecoration(
                      color: themeData.primary,
                      boxShadow: [
                        BoxShadow(color: themeData.primary, blurRadius: 5),
                      ],
                    ),
                  ),
                  const SizedBox(width: 4),
                  Container(
                    width: 16,
                    height: 16,
                    decoration: BoxDecoration(
                      color: themeData.secondary,
                      boxShadow: [
                        BoxShadow(color: themeData.secondary, blurRadius: 5),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
