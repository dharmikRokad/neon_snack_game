import 'package:flame/game.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:snake_game_flame/controllers/game_controller.dart';
import 'package:snake_game_flame/widgets/action_button.dart';

class DPadWidget extends StatelessWidget {
  const DPadWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = context.read<GameController>();
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        ActionButton(
          icon: Icons.arrow_upward,
          onTap: () => controller.onDirectionInput(Vector2(0, -1)),
        ),
        Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            ActionButton(
              icon: Icons.arrow_back,
              onTap: () => controller.onDirectionInput(Vector2(-1, 0)),
            ),
            const SizedBox(width: 60),
            ActionButton(
              icon: Icons.arrow_forward,
              onTap: () => controller.onDirectionInput(Vector2(1, 0)),
            ),
          ],
        ),
        ActionButton(
          icon: Icons.arrow_downward,
          onTap: () => controller.onDirectionInput(Vector2(0, 1)),
        ),
      ],
    );
  }
}
