import 'package:flutter/material.dart';
import '../game/theme.dart';
import '../utils/audio_manager.dart';

class SettingsMenu extends StatefulWidget {
  final VoidCallback onClose;

  const SettingsMenu({super.key, required this.onClose});

  @override
  State<SettingsMenu> createState() => _SettingsMenuState();
}

class _SettingsMenuState extends State<SettingsMenu>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _scaleAnimation;
  late Animation<double> _fadeAnimation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 200),
      vsync: this,
    );
    _scaleAnimation = Tween<double>(begin: 0.8, end: 1.0).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.easeOutBack),
    );
    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.easeOut),
    );
    _animationController.forward();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  Future<void> _closeWithAnimation() async {
    await _animationController.reverse();
    widget.onClose();
  }

  @override
  Widget build(BuildContext context) {
    return FadeTransition(
      opacity: _fadeAnimation,
      child: GestureDetector(
        onTap: _closeWithAnimation,
        child: Container(
          color: Colors.black.withValues(alpha: 0.7),
          child: Center(
            child: ScaleTransition(
              scale: _scaleAnimation,
              child: GestureDetector(
                onTap: () {}, // Prevent tap from closing when tapping content
                child: Container(
                  width: 280,
                  padding: const EdgeInsets.all(24),
                  decoration: BoxDecoration(
                    color: CyberpunkTheme.background,
                    border: Border.all(
                      color: CyberpunkTheme.glassBorder,
                      width: 2,
                    ),
                    borderRadius: BorderRadius.circular(8),
                    boxShadow: [
                      BoxShadow(
                        color: CyberpunkTheme.primary.withValues(alpha: 0.3),
                        blurRadius: 20,
                        spreadRadius: 2,
                      ),
                    ],
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      // Title
                      Text(
                        'SETTINGS',
                        style: CyberpunkTheme.pressStart2P.copyWith(
                          fontSize: 16,
                          color: CyberpunkTheme.primary,
                          shadows: [
                            Shadow(
                              blurRadius: 10,
                              color: CyberpunkTheme.primary,
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 24),

                      // Sound Effects Toggle
                      _buildToggleRow(
                        label: 'SOUND FX',
                        value: !AudioManager().isSfxMuted,
                        onChanged: (_) {
                          setState(() {
                            AudioManager().toggleSfx();
                          });
                        },
                      ),
                      const SizedBox(height: 16),

                      // Music Toggle
                      _buildToggleRow(
                        label: 'MUSIC',
                        value: !AudioManager().isMusicMuted,
                        onChanged: (_) {
                          setState(() {
                            AudioManager().toggleMusic();
                          });
                        },
                      ),
                      const SizedBox(height: 24),

                      // Close Button
                      MouseRegion(
                        cursor: SystemMouseCursors.click,
                        child: GestureDetector(
                          onTap: _closeWithAnimation,
                          child: Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 24,
                              vertical: 12,
                            ),
                            decoration: BoxDecoration(
                              color: CyberpunkTheme.primary.withValues(
                                alpha: 0.1,
                              ),
                              border: Border.all(color: CyberpunkTheme.primary),
                              borderRadius: BorderRadius.circular(4),
                            ),
                            child: Text(
                              'CLOSE',
                              style: CyberpunkTheme.pressStart2P.copyWith(
                                fontSize: 10,
                                color: CyberpunkTheme.primary,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildToggleRow({
    required String label,
    required bool value,
    required ValueChanged<bool> onChanged,
  }) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: CyberpunkTheme.pressStart2P.copyWith(
            fontSize: 10,
            color: CyberpunkTheme.textGray,
          ),
        ),
        MouseRegion(
          cursor: SystemMouseCursors.click,
          child: GestureDetector(
            onTap: () => onChanged(!value),
            child: Container(
              width: 60,
              height: 30,
              decoration: BoxDecoration(
                color: value
                    ? CyberpunkTheme.primary.withValues(alpha: 0.2)
                    : Colors.black.withValues(alpha: 0.5),
                border: Border.all(
                  color: value
                      ? CyberpunkTheme.primary
                      : CyberpunkTheme.textGray.withValues(alpha: 0.5),
                ),
                borderRadius: BorderRadius.circular(4),
              ),
              child: Stack(
                children: [
                  AnimatedPositioned(
                    duration: const Duration(milliseconds: 150),
                    left: value ? 32 : 4,
                    top: 4,
                    child: Container(
                      width: 22,
                      height: 20,
                      decoration: BoxDecoration(
                        color: value
                            ? CyberpunkTheme.primary
                            : CyberpunkTheme.textGray,
                        borderRadius: BorderRadius.circular(2),
                        boxShadow: value
                            ? [
                                BoxShadow(
                                  color: CyberpunkTheme.primary,
                                  blurRadius: 6,
                                ),
                              ]
                            : null,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
