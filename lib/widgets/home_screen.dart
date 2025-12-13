import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:snake_game_flame/controllers/game_controller.dart';
import 'package:snake_game_flame/game/theme.dart';
import 'package:snake_game_flame/widgets/game_view.dart';

/// The main game screen with responsive two-panel layout.
/// Uses Provider for state management.
class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
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

        final widget = (isDesktop)
            ? _buildDesktopLayout(context, constraints)
            : _buildMobileLayout(context, constraints);

        return widget;
      },
    );
  }

  Widget _buildDesktopLayout(BuildContext context, BoxConstraints constraints) {
    return Row(
      children: [
        Container(
          color: Colors.grey,
          width: constraints.maxWidth * 0.20,
          height: constraints.maxHeight,
        ),

        Expanded(
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 100, vertical: 10),
            color: CyberpunkTheme.background,
            height: constraints.maxHeight,
            child: GameView(),
          ),
        ),

        Container(
          color: Colors.grey,
          width: constraints.maxWidth * 0.20,
          height: constraints.maxHeight,
        ),
      ],
    );
  }

  Widget _buildMobileLayout(BuildContext context, BoxConstraints constraints) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 30, vertical: 10),
      color: CyberpunkTheme.background,
      height: constraints.maxHeight,
      child: GameView(isMobile: true),
    );
  }
}
