import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:snake_game_flame/controllers/game_controller.dart';
import 'package:snake_game_flame/utils/constants/app_strings.dart';
import '../game/theme.dart';

/// Main menu overlay using Provider for state management.
class MainMenuOverlay extends StatefulWidget {
  const MainMenuOverlay({super.key});

  @override
  State<MainMenuOverlay> createState() => _MainMenuOverlayState();
}

class _MainMenuOverlayState extends State<MainMenuOverlay> {
  GameTheme _selectedTheme = GameTheme.neonGreen;

  void _changeTheme(GameTheme theme) {
    setState(() {
      _selectedTheme = theme;
      context.read<GameController>().changeTheme(theme);
    });
  }

  @override
  Widget build(BuildContext context) {
    final controller = context.read<GameController>();
    final currentThemeData = CyberpunkTheme.current;

    return Stack(
      children: [
        // Main content
        Center(
          child: Container(
            padding: const EdgeInsets.all(20),
            width: double.infinity,
            height: double.infinity,
            color: Colors.black.withValues(alpha: 0.85),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ShaderMask(
                  shaderCallback: (bounds) => LinearGradient(
                    colors: currentThemeData.titleGradient,
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                  ).createShader(bounds),
                  child: Text(
                    AppStrings.neonSnack.toUpperCase(),
                    style: CyberpunkTheme.pressStart2P.copyWith(
                      fontSize: 36,
                      color: Colors.white,
                      shadows: [
                        Shadow(blurRadius: 10, color: CyberpunkTheme.primary),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 8),
                Container(
                  height: 1,
                  width: 128,
                  decoration: BoxDecoration(
                    color: CyberpunkTheme.primary,
                    boxShadow: [
                      BoxShadow(
                        color: CyberpunkTheme.primary,
                        blurRadius: 10,
                        spreadRadius: 1,
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 32),
                Text(
                  '${AppStrings.objective.toUpperCase()}\n'
                  '${AppStrings.avoid.toUpperCase()}\n'
                  '${AppStrings.controls.toUpperCase()}\n',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontFamily: 'Courier',
                    color: CyberpunkTheme.textGray,
                    fontSize: 12,
                    height: 2,
                    letterSpacing: 1.2,
                  ),
                ),
                const SizedBox(height: 32),

                // Theme Selection Section
                Text(
                  AppStrings.selectTheme.toUpperCase(),
                  style: CyberpunkTheme.pressStart2P.copyWith(
                    fontSize: 12,
                    color: CyberpunkTheme.textGray,
                  ),
                ),
                const SizedBox(height: 16),
                Wrap(
                  spacing: 12,
                  runSpacing: 12,
                  alignment: WrapAlignment.center,
                  children: [
                    _buildThemeButton(
                      GameTheme.neonGreen,
                      GameThemeData.neonGreen,
                    ),
                    _buildThemeButton(
                      GameTheme.synthwave,
                      GameThemeData.synthwave,
                    ),
                    _buildThemeButton(
                      GameTheme.oceanBlue,
                      GameThemeData.oceanBlue,
                    ),
                    _buildThemeButton(GameTheme.fireRed, GameThemeData.fireRed),
                  ],
                ),
                const SizedBox(height: 32),

                // Start Button
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
                        color: CyberpunkTheme.primary.withValues(alpha: 0.1),
                        border: Border.all(color: CyberpunkTheme.primary),
                        boxShadow: [
                          BoxShadow(
                            color: CyberpunkTheme.primary.withValues(
                              alpha: 0.3,
                            ),
                            blurRadius: 15,
                          ),
                        ],
                      ),
                      child: Text(
                        AppStrings.letsPlay.toUpperCase(),
                        style: CyberpunkTheme.pressStart2P.copyWith(
                          color: CyberpunkTheme.primary,
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
        ),
        // Settings button in top-right corner
        Positioned(
          top: 16,
          right: 16,
          child: MouseRegion(
            cursor: SystemMouseCursors.click,
            child: GestureDetector(
              onTap: () => controller.toggleSettings(),
              child: Container(
                width: 48,
                height: 48,
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
                child: Icon(
                  Icons.settings,
                  color: CyberpunkTheme.primary,
                  size: 24,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildThemeButton(GameTheme theme, GameThemeData themeData) {
    final isSelected = CyberpunkTheme.current == themeData;

    return MouseRegion(
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
        onTap: () => _changeTheme(theme),
        child: Container(
          width: 140,
          padding: const EdgeInsets.all(12),
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
