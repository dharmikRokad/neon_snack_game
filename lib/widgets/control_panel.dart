import 'package:flutter/material.dart';
import 'package:flame/game.dart';
import 'package:provider/provider.dart';
import 'package:snake_game_flame/controllers/game_controller.dart';
import 'package:snake_game_flame/utils/constants/app_strings.dart';
import '../game/theme.dart';

/// Control panel widget that uses Provider to access GameController.
class ControlPanel extends StatelessWidget {
  final bool isVertical; // true for mobile layout (horizontal strip at bottom)

  const ControlPanel({super.key, this.isVertical = false});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.black.withValues(alpha: 0.8),
        border: Border(
          left: isVertical
              ? BorderSide.none
              : BorderSide(color: CyberpunkTheme.glassBorder, width: 1),
          top: isVertical
              ? BorderSide(color: CyberpunkTheme.glassBorder, width: 1)
              : BorderSide.none,
        ),
      ),
      child: isVertical
          ? _buildHorizontalLayout(context)
          : _buildVerticalLayout(context),
    );
  }

  // Desktop layout - vertical arrangement in right panel
  Widget _buildVerticalLayout(BuildContext context) {
    final controller = context.watch<GameController>();

    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // Score section
          _buildScoreBox('SCORE', controller.score),
          const SizedBox(height: 16),
          _buildScoreBox('HI-SCORE', controller.highScore),

          const Spacer(),

          // Action buttons
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _buildActionButton(
                icon: controller.isPlaying ? Icons.pause : Icons.play_arrow,
                tooltip: controller.isPlaying
                    ? AppStrings.pauseWithShortCutKey
                    : AppStrings.playWithShortCutKey,
                onTap: controller.togglePause,
              ),
              const SizedBox(width: 16),
              _buildActionButton(
                icon: Icons.settings,
                tooltip: AppStrings.settingsWithShortCutKey,
                onTap: controller.toggleSettings,
              ),
            ],
          ),
          const SizedBox(height: 24),

          // D-Pad
          Center(child: _buildDPad(context)),
          const SizedBox(height: 16),
        ],
      ),
    );
  }

  // Mobile layout - horizontal arrangement in bottom panel
  Widget _buildHorizontalLayout(BuildContext context) {
    final controller = context.watch<GameController>();

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          // Left side: Score + buttons
          Expanded(
            flex: 2,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    _buildCompactScoreBox(
                      AppStrings.score.toUpperCase(),
                      controller.score,
                    ),
                    _buildCompactScoreBox(
                      AppStrings.hiScore.toUpperCase(),
                      controller.highScore,
                    ),
                  ],
                ),
                const SizedBox(height: 12),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    _buildActionButton(
                      icon: controller.isPlaying
                          ? Icons.pause
                          : Icons.play_arrow,
                      tooltip: controller.isPlaying
                          ? AppStrings.pauseWithShortCutKey
                          : AppStrings.playWithShortCutKey,
                      onTap: controller.togglePause,
                      size: 36,
                    ),
                    const SizedBox(width: 12),
                    _buildActionButton(
                      icon: Icons.settings,
                      tooltip: AppStrings.settingsWithShortCutKey,
                      onTap: controller.toggleSettings,
                      size: 36,
                    ),
                  ],
                ),
              ],
            ),
          ),

          // Right side: D-Pad
          Expanded(flex: 2, child: Center(child: _buildCompactDPad(context))),
        ],
      ),
    );
  }

  Widget _buildScoreBox(String label, int value) {
    return Container(
      padding: const EdgeInsets.all(16),
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

  Widget _buildCompactScoreBox(String label, int value) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: BoxDecoration(
        color: CyberpunkTheme.glassBackground,
        borderRadius: BorderRadius.circular(4),
        border: Border.all(color: CyberpunkTheme.glassBorder),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            label,
            style: CyberpunkTheme.pressStart2P.copyWith(
              fontSize: 6,
              color: CyberpunkTheme.textGray,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            '$value',
            style: CyberpunkTheme.pressStart2P.copyWith(
              fontSize: 14,
              color: CyberpunkTheme.primary,
              shadows: [Shadow(blurRadius: 5, color: CyberpunkTheme.primary)],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildActionButton({
    required IconData icon,
    required VoidCallback onTap,
    String? tooltip,
    double size = 48,
  }) {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      child: Tooltip(
        message: tooltip,
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

  Widget _buildDPad(BuildContext context) {
    final controller = context.read<GameController>();
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        _buildControlBtn(
          '▲',

          () => controller.onDirectionInput(Vector2(0, -1)),
        ),
        Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            _buildControlBtn(
              '◀',
              () => controller.onDirectionInput(Vector2(-1, 0)),
            ),
            const SizedBox(width: 60),
            _buildControlBtn(
              '▶',
              () => controller.onDirectionInput(Vector2(1, 0)),
            ),
          ],
        ),
        _buildControlBtn('▼', () => controller.onDirectionInput(Vector2(0, 1))),
      ],
    );
  }

  Widget _buildCompactDPad(BuildContext context) {
    final controller = context.read<GameController>();
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        _buildControlBtn(
          '▲',
          () => controller.onDirectionInput(Vector2(0, -1)),
          size: 40,
        ),
        Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            _buildControlBtn(
              '◀',
              () => controller.onDirectionInput(Vector2(-1, 0)),
              size: 40,
            ),
            const SizedBox(width: 44),
            _buildControlBtn(
              '▶',
              () => controller.onDirectionInput(Vector2(1, 0)),
              size: 40,
            ),
          ],
        ),
        _buildControlBtn(
          '▼',
          () => controller.onDirectionInput(Vector2(0, 1)),
          size: 40,
        ),
      ],
    );
  }

  Widget _buildControlBtn(
    String label,
    VoidCallback onTap, {
    double size = 60,
  }) {
    return GestureDetector(
      onTapDown: (_) => onTap(),
      child: Container(
        width: size,
        height: size * 0.8,
        margin: const EdgeInsets.all(3),
        decoration: BoxDecoration(
          color: CyberpunkTheme.glassBackground,
          border: Border.all(color: CyberpunkTheme.glassBorder),
          borderRadius: BorderRadius.circular(4),
          boxShadow: [
            BoxShadow(
              color: CyberpunkTheme.primaryDim.withValues(alpha: 0.1),
              blurRadius: 5,
            ),
          ],
        ),
        child: Center(
          child: Text(
            label,
            style: TextStyle(
              color: CyberpunkTheme.primary,
              fontSize: size * 0.35,
            ),
          ),
        ),
      ),
    );
  }
}
