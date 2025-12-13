import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:snake_game_flame/controllers/game_controller.dart';
import 'package:snake_game_flame/utils/shared_prefs.dart';
import 'package:snake_game_flame/widgets/home_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SharedPrefs().init();

  runApp(
    ChangeNotifierProvider(
      create: (_) => GameController(),
      child: MaterialApp(
        home: Scaffold(
          body: const Directionality(
            textDirection: TextDirection.ltr,
            child: HomeScreen(),
          ),
        ),
      ),
    ),
  );
}
