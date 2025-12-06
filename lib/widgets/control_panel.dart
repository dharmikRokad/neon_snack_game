import 'package:flutter/material.dart';
import 'package:flame/game.dart';
import '../game/snake_game.dart';
import '../game/theme.dart';
import 'settings_menu.dart';

class ControlPanel extends StatefulWidget {
  final SnakeGame game;
  final bool isVertical; // true for mobile layout (horizontal strip at bottom)

  const ControlPanel({super.key, required this.game, this.isVertical = false});

  @override
  State<ControlPanel> createState() => _ControlPanelState();
}

class _ControlPanelState extends State<ControlPanel> {
  bool _showSettings = false;

  void _toggleSettings() {
    setState(() {
      _showSettings = !_showSettings;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          decoration: BoxDecoration(
            color: Colors.black.withValues(alpha: 0.8),
            border: Border(
              left: widget.isVertical
                  ? BorderSide.none
                  : BorderSide(color: CyberpunkTheme.glassBorder, width: 1),
              top: widget.isVertical
                  ? BorderSide(color: CyberpunkTheme.glassBorder, width: 1)
                  : BorderSide.none,
            ),
          ),
          child: widget.isVertical
              ? _buildHorizontalLayout()
              : _buildVerticalLayout(),
        ),
        if (_showSettings)
          Positioned.fill(child: SettingsMenu(onClose: _toggleSettings)),
      ],
    );
  }

  // Desktop layout - vertical arrangement in right panel
  Widget _buildVerticalLayout() {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // Score section
          _buildScoreBox('SCORE', widget.game.score),
          const SizedBox(height: 16),
          _buildScoreBox('HI-SCORE', widget.game.highScore),

          const Spacer(),

          // Action buttons
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _buildActionButton(
                icon: widget.game.isPlaying ? Icons.pause : Icons.play_arrow,
                onTap: widget.game.togglePause,
              ),
              const SizedBox(width: 16),
              _buildActionButton(icon: Icons.settings, onTap: _toggleSettings),
            ],
          ),
          const SizedBox(height: 24),

          // D-Pad
          Center(child: _buildDPad()),
          const SizedBox(height: 16),
        ],
      ),
    );
  }

  // Mobile layout - horizontal arrangement in bottom panel
  Widget _buildHorizontalLayout() {
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
                    _buildCompactScoreBox('SCORE', widget.game.score),
                    _buildCompactScoreBox('HI-SCORE', widget.game.highScore),
                  ],
                ),
                const SizedBox(height: 12),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    _buildActionButton(
                      icon: widget.game.isPlaying
                          ? Icons.pause
                          : Icons.play_arrow,
                      onTap: widget.game.togglePause,
                      size: 36,
                    ),
                    const SizedBox(width: 12),
                    _buildActionButton(
                      icon: Icons.settings,
                      onTap: _toggleSettings,
                      size: 36,
                    ),
                  ],
                ),
              ],
            ),
          ),

          // Right side: D-Pad
          Expanded(flex: 2, child: Center(child: _buildCompactDPad())),
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
    double size = 48,
  }) {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
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
    );
  }

  Widget _buildDPad() {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        _buildControlBtn('▲', () => widget.game.onArrowKey(Vector2(0, -1))),
        Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            _buildControlBtn('◀', () => widget.game.onArrowKey(Vector2(-1, 0))),
            const SizedBox(width: 60),
            _buildControlBtn('▶', () => widget.game.onArrowKey(Vector2(1, 0))),
          ],
        ),
        _buildControlBtn('▼', () => widget.game.onArrowKey(Vector2(0, 1))),
      ],
    );
  }

  Widget _buildCompactDPad() {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        _buildControlBtn(
          '▲',
          () => widget.game.onArrowKey(Vector2(0, -1)),
          size: 40,
        ),
        Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            _buildControlBtn(
              '◀',
              () => widget.game.onArrowKey(Vector2(-1, 0)),
              size: 40,
            ),
            const SizedBox(width: 44),
            _buildControlBtn(
              '▶',
              () => widget.game.onArrowKey(Vector2(1, 0)),
              size: 40,
            ),
          ],
        ),
        _buildControlBtn(
          '▼',
          () => widget.game.onArrowKey(Vector2(0, 1)),
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
