import 'package:flutter/material.dart';
import 'package:flame/game.dart';
import 'package:provider/provider.dart';
import 'package:snake_game_flame/controllers/game_controller.dart';
import 'package:snake_game_flame/controllers/game_state.dart';
import 'package:snake_game_flame/game/theme.dart';
import '../game/snake_game.dart';
import '../overlays/main_menu.dart';
import '../overlays/game_over.dart';
import '../overlays/game_overlay.dart';
import '../widgets/settings_menu.dart';
import 'control_panel.dart';

/// The main game screen with responsive two-panel layout.
/// Uses Provider for state management.
class GameScreen extends StatefulWidget {
  const GameScreen({super.key});

  @override
  State<GameScreen> createState() => _GameScreenState();
}

class _GameScreenState extends State<GameScreen> {
  @override
  void initState() {
    super.initState();
    // Initialize after first frame to ensure context is available
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<GameController>().initialize();
    });
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final isDesktop = constraints.maxWidth >= 768;

        if (isDesktop) {
          return _buildDesktopLayout(context, constraints);
        } else {
          return _buildMobileLayout(context, constraints);
        }
      },
    );
  }

  Widget _buildDesktopLayout(BuildContext context, BoxConstraints constraints) {
    final controller = context.watch<GameController>();

    // Calculate proportions
    final controlPanelWidth = constraints.maxWidth * 0.25;
    final minControlPanelWidth = 200.0;
    final maxControlPanelWidth = 280.0;
    final actualControlPanelWidth = controlPanelWidth.clamp(
      minControlPanelWidth,
      maxControlPanelWidth,
    );

    return Row(
      children: [
        // Game Area (left panel)
        Expanded(child: _buildGameWidget(context, controller)),
        // Control Panel (right panel) - only show when playing
        if (controller.shouldShowControlPanel)
          SizedBox(
            width: actualControlPanelWidth,
            child: const ControlPanel(isVertical: false),
          ),
      ],
    );
  }

  Widget _buildMobileLayout(BuildContext context, BoxConstraints constraints) {
    final controller = context.watch<GameController>();

    // Calculate proportions
    final controlPanelHeight = constraints.maxHeight * 0.30;
    final minControlPanelHeight = 160.0;
    final maxControlPanelHeight = 220.0;
    final actualControlPanelHeight = controlPanelHeight.clamp(
      minControlPanelHeight,
      maxControlPanelHeight,
    );

    return Column(
      children: [
        // Game Area (top panel)
        Expanded(child: _buildGameWidget(context, controller)),
        // Control Panel (bottom panel) - only show when playing
        if (controller.shouldShowControlPanel)
          SizedBox(
            height: actualControlPanelHeight,
            child: const ControlPanel(isVertical: true),
          ),
      ],
    );
  }

  Widget _buildGameWidget(BuildContext context, GameController controller) {
    return Container(
      color: CyberpunkTheme.background,
      padding: const EdgeInsets.all(8),
      child: ClipRect(
        child: Stack(
          children: [
            // Flame game - no overlays managed by Flame
            GameWidget<SnakeGame>(game: controller.game),
            // Flutter overlays based on controller state
            _buildOverlay(context, controller),
          ],
        ),
      ),
    );
  }

  Widget _buildOverlay(BuildContext context, GameController controller) {
    switch (controller.currentScreen) {
      case GameScreenState.mainMenu:
        return const MainMenuOverlay();
      case GameScreenState.gameOver:
        return const GameOverOverlay();
      case GameScreenState.gameHud:
        return const GameOverlay();
      case GameScreenState.settings:
        return SettingsMenu(onClose: () => controller.toggleSettings());
      case GameScreenState.none:
        return const SizedBox.shrink();
    }
  }
}
