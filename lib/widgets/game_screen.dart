import 'package:flutter/material.dart';
import 'package:flame/game.dart';
import 'package:snake_game_flame/game/theme.dart';
import '../game/snake_game.dart';
import '../overlays/main_menu.dart';
import '../overlays/game_over.dart';
import '../overlays/game_overlay.dart';
import '../widgets/settings_menu.dart';
import 'control_panel.dart';

/// The main game screen with responsive two-panel layout.
/// - Desktop (width >= 768px): Game on left, controls on right
/// - Mobile (width < 768px): Game on top, controls on bottom
class GameScreen extends StatefulWidget {
  const GameScreen({super.key});

  @override
  State<GameScreen> createState() => _GameScreenState();
}

class _GameScreenState extends State<GameScreen> {
  late SnakeGame _game;

  @override
  void initState() {
    super.initState();
    _game = SnakeGame();
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final isDesktop = constraints.maxWidth >= 768;

        if (isDesktop) {
          return _buildDesktopLayout(constraints);
        } else {
          return _buildMobileLayout(constraints);
        }
      },
    );
  }

  Widget _buildDesktopLayout(BoxConstraints constraints) {
    // Calculate proportions: game area gets ~70%, control panel gets ~30%
    final controlPanelWidth = constraints.maxWidth * 0.25;
    final minControlPanelWidth = 200.0;
    final maxControlPanelWidth = 280.0;
    final actualControlPanelWidth = controlPanelWidth.clamp(
      minControlPanelWidth,
      maxControlPanelWidth,
    );

    // Only show control panel when actively playing (no MainMenu or GameOver)
    final activeOverlays = _game.overlays.activeOverlays;
    final shouldShowControlPanel =
        !activeOverlays.contains('MainMenu') &&
        !activeOverlays.contains('GameOver');

    return Row(
      children: [
        // Game Area (left panel)
        Expanded(child: _buildGameWidget()),
        // Control Panel (right panel) - only show when playing
        if (shouldShowControlPanel)
          SizedBox(
            width: actualControlPanelWidth,
            child: ListenableBuilder(
              listenable: _game,
              builder: (context, _) {
                return ControlPanel(game: _game, isVertical: false);
              },
            ),
          ),
      ],
    );
  }

  Widget _buildMobileLayout(BoxConstraints constraints) {
    // Calculate proportions: game area gets ~65%, control panel gets ~35%
    final controlPanelHeight = constraints.maxHeight * 0.30;
    final minControlPanelHeight = 160.0;
    final maxControlPanelHeight = 220.0;
    final actualControlPanelHeight = controlPanelHeight.clamp(
      minControlPanelHeight,
      maxControlPanelHeight,
    );

    // Only show control panel when actively playing (no MainMenu or GameOver)
    final activeOverlays = _game.overlays.activeOverlays;
    final shouldShowControlPanel =
        !activeOverlays.contains('MainMenu') &&
        !activeOverlays.contains('GameOver');

    return Column(
      children: [
        // Game Area (top panel)
        Expanded(child: _buildGameWidget()),
        // Control Panel (bottom panel) - only show when playing
        if (shouldShowControlPanel)
          SizedBox(
            height: actualControlPanelHeight,
            child: ListenableBuilder(
              listenable: _game,
              builder: (context, _) {
                return ControlPanel(game: _game, isVertical: true);
              },
            ),
          ),
      ],
    );
  }

  Widget _buildGameWidget() {
    return Container(
      color: CyberpunkTheme.background,
      padding: EdgeInsets.all(8),
      child: ClipRect(
        child: GameWidget<SnakeGame>(
          game: _game,
          overlayBuilderMap: {
            'MainMenu': (_, game) => MainMenuOverlay(game: game),
            'GameOver': (_, game) => GameOverOverlay(game: game),
            'GameOverlay': (_, game) => GameOverlay(game: game),
            'Settings': (_, game) => SettingsMenu(onClose: game.toggleSettings),
          },
          initialActiveOverlays: const ['MainMenu'],
        ),
      ),
    );
  }
}
