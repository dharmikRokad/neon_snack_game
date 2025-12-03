import 'package:shared_preferences/shared_preferences.dart';
import 'package:snake_game_flame/game/theme.dart';

class SharedPrefs {
  // Private Constructor
  SharedPrefs._();

  // Private static instance
  static final _instance = SharedPrefs._();

  // singleton factory constructor
  factory SharedPrefs() => _instance;

  late final SharedPreferences _prefs;

  final String _highScoreKey = "high_score";
  final String _themeKey = "theme";

  Future<void> init() async {
    _prefs = await SharedPreferences.getInstance();
  }

  void setTheme(GameTheme theme) => _prefs.setString(_themeKey, theme.name);

  GameTheme getTheme() {
    return GameTheme.values.firstWhere(
      (e) => e.name == _prefs.getString(_themeKey),
      orElse: () => GameTheme.neonGreen,
    );
  }

  void setHighScore(int score) => _prefs.setInt(_highScoreKey, score);

  int getHighScore() => _prefs.getInt(_highScoreKey) ?? 0;
}
