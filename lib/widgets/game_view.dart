import 'package:flame/game.dart' show GameWidget;
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:snake_game_flame/controllers/game_controller.dart';
import 'package:snake_game_flame/controllers/game_state.dart';
import 'package:snake_game_flame/game/snake_game.dart';
import 'package:snake_game_flame/game/theme.dart';
import 'package:snake_game_flame/overlays/game_over.dart';
import 'package:snake_game_flame/overlays/game_overlay.dart';
import 'package:snake_game_flame/utils/constants/app_strings.dart';
import 'package:snake_game_flame/widgets/action_button.dart';
import 'package:snake_game_flame/widgets/d_pad_widget.dart';
import 'package:snake_game_flame/widgets/score_card.dart';
import 'package:snake_game_flame/widgets/settings_menu.dart';
import 'package:snake_game_flame/widgets/theme_button_widget.dart';

class GameView extends StatelessWidget {
  const GameView({super.key, this.isMobile = false});

  final bool isMobile;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);
    return Consumer<GameController>(
      child: this,
      builder: (context, controller, _) {
        return Stack(
          children: [
            SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                spacing: 40,
                children: [
                  // Name and Scoew View
                  _buildNameScoreWidget(controller),

                  // Theme and sound options
                  _buildThemeAndActions(controller),

                  // Game  Grid Box
                  SizedBox(
                    height: size.height * .6  ,
                    width: double.infinity,
                    child: GameWidget<SnakeGame>(game: controller.game),
                  ),

                  // Control Pad (only for mobile)
                  if (isMobile) DPadWidget(),
                ],
              ),
            ),

            // Overlay
            _buildOverlay(controller),
          ],
        );
      },
    );
  }

  Row _buildThemeAndActions(GameController controller) {
    return Row(
      children: [
        Expanded(
          child: Wrap(
            spacing: 12,
            runSpacing: 12,
            alignment: WrapAlignment.start,
            children: [
              ThemeButtonWidget(theme: GameTheme.neonGreen),
              ThemeButtonWidget(theme: GameTheme.synthwave),
              ThemeButtonWidget(theme: GameTheme.oceanBlue),
              ThemeButtonWidget(theme: GameTheme.fireRed),
            ],
          ),
        ),
        ActionButton(
          icon: controller.isPlaying ? Icons.pause : Icons.play_arrow,
          tooltip: controller.isPlaying
              ? AppStrings.pauseWithShortCutKey
              : AppStrings.playWithShortCutKey,
          onTap: controller.togglePause,
        ),
        const SizedBox(width: 14),
        ActionButton(
          icon: Icons.settings,
          tooltip: AppStrings.settingsWithShortCutKey,
          onTap: controller.toggleSettings,
        ),
      ],
    );
  }

  Widget _buildNameScoreWidget(GameController controller) {
    return Row(
      children: [
        Text(
          AppStrings.neonSnack.toUpperCase(),
          style: CyberpunkTheme.pressStart2P.copyWith(
            fontSize: 36,
            color: Colors.white,
            shadows: [Shadow(blurRadius: 10, color: CyberpunkTheme.primary)],
          ),
        ),
        Spacer(),
        ScoreCard(
          label: AppStrings.score.toUpperCase(),
          value: controller.score,
        ),
        const SizedBox(width: 8),
        ScoreCard(
          label: AppStrings.best.toUpperCase(),
          value: controller.highScore,
        ),
      ],
    );
  }

  Widget _buildOverlay(GameController controller) {
    switch (controller.currentScreen) {
      case GameScreenState.gameOver:
        return const GameOverOverlay();
      case GameScreenState.gameHud:
        return const GameOverlay();
      case GameScreenState.settings:
        return SettingsMenu(onClose: () => controller.toggleSettings());
      case GameScreenState.mainMenu:
      case GameScreenState.none:
        return const SizedBox.shrink();
    }
  }
}
