import 'package:flutter/widgets.dart';
import 'package:snake_game_flame/utils/shared_prefs.dart';
import 'package:snake_game_flame/widgets/game_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SharedPrefs().init();

  runApp(
    const Directionality(textDirection: TextDirection.ltr, child: GameScreen()),
  );
}
