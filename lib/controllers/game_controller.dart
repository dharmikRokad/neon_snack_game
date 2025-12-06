import 'package:flame/game.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:snake_game_flame/controllers/game_state.dart';
import 'package:snake_game_flame/game/snake_game.dart';
import 'package:snake_game_flame/game/theme.dart';
import 'package:snake_game_flame/utils/audio_manager.dart';
import 'package:snake_game_flame/utils/shared_prefs.dart';

/// GameController manages all UI state and game lifecycle.
/// Uses Provider/ChangeNotifier pattern for reactive UI updates.
class GameController extends ChangeNotifier {
  late SnakeGame _game;

  // Game State
  bool _isPlaying = false;
  bool _isGameOver = false;
  bool _wasPlayingBeforeSettings = false;

  // Score
  int _score = 0;
  int _highScore = SharedPrefs().getHighScore();

  // Track what screen was active before settings
  GameScreenState _previousScreen = GameScreenState.mainMenu;
  // Current screen
  GameScreenState _currentScreen = GameScreenState.mainMenu;

  // Getters
  SnakeGame get game => _game;
  bool get isPlaying => _isPlaying;
  bool get isGameOver => _isGameOver;
  int get score => _score;
  int get highScore => _highScore;
  GameScreenState get currentScreen => _currentScreen;

  /// Whether the control panel should be visible
  bool get shouldShowControlPanel =>
      _currentScreen != GameScreenState.mainMenu &&
      _currentScreen != GameScreenState.gameOver;

  GameController() {
    _game = SnakeGame(
      onFoodEaten: _onFoodEaten,
      onGameOver: _onGameOver,
      onKeyboardKey: _onKeyboardKey,
    );
  }

  /// Initialize the game - call this after game is loaded
  Future<void> initialize() async {
    await AudioManager().initialize();
    _game.pauseEngine();
    _currentScreen = GameScreenState.mainMenu;
    notifyListeners();
  }

  /// Start a new game
  Future<void> startGame() async {
    _game.resetGameState();
    _score = 0;
    _isPlaying = true;
    _isGameOver = false;
    _currentScreen = GameScreenState.gameHud;
    _game.resumeEngine();
    notifyListeners();

    await AudioManager().startBackgroundMusic();
  }

  /// Return to main menu from game over
  void restartFromMain() {
    _currentScreen = GameScreenState.mainMenu;
    notifyListeners();
  }

  /// Toggle pause state
  void togglePause() {
    if (_isGameOver) return;

    if (_isPlaying) {
      _isPlaying = false;
      _game.pauseEngine();
      AudioManager().pauseBackgroundMusic();
    } else {
      _isPlaying = true;
      _game.resumeEngine();
      _currentScreen = GameScreenState.gameHud;
      AudioManager().resumeBackgroundMusic();
    }
    notifyListeners();
  }

  /// Toggle settings overlay
  void toggleSettings() {
    if (_currentScreen == GameScreenState.settings) {
      // Closing settings - restore to previous screen
      _currentScreen = _previousScreen;
      // Resume game if was playing before
      if (_wasPlayingBeforeSettings && !_isGameOver) {
        _isPlaying = true;
        _game.resumeEngine();
      }
    } else {
      // Opening settings - save current state
      _previousScreen = _currentScreen;
      _wasPlayingBeforeSettings = _isPlaying;
      if (_isPlaying) {
        _isPlaying = false;
        _game.pauseEngine();
      }
      _currentScreen = GameScreenState.settings;
    }
    notifyListeners();
  }

  /// Handle direction input
  void onDirectionInput(Vector2 direction) {
    if (_isPlaying && !_isGameOver) {
      _game.snake.changeDirection(direction);
    }
  }

  /// Refresh theme across game
  void refreshTheme() {
    notifyListeners();
  }

  /// Change theme
  void changeTheme(GameTheme theme) {
    CyberpunkTheme.setTheme(theme);
    notifyListeners();
  }

  // Private callbacks from game
  void _onFoodEaten() {
    _score++;
    if (_score > _highScore) {
      _highScore = _score;
      SharedPrefs().setHighScore(_highScore);
    }
    AudioManager().playEatSound();
    notifyListeners();
  }

  void _onGameOver() {
    _isPlaying = false;
    _isGameOver = true;
    _game.pauseEngine();
    _currentScreen = GameScreenState.gameOver;

    AudioManager().playGameOverSound();
    AudioManager().pauseBackgroundMusic();
    notifyListeners();
  }

  KeyEventResult _onKeyboardKey(
    KeyEvent event,
    Set<LogicalKeyboardKey> keysPressed,
  ) {
    if (event is KeyDownEvent) {
      if (keysPressed.contains(LogicalKeyboardKey.arrowUp)) {
        onDirectionInput.call(Vector2(0, -1));
      } else if (keysPressed.contains(LogicalKeyboardKey.arrowDown)) {
        onDirectionInput.call(Vector2(0, 1));
      } else if (keysPressed.contains(LogicalKeyboardKey.arrowLeft)) {
        onDirectionInput.call(Vector2(-1, 0));
      } else if (keysPressed.contains(LogicalKeyboardKey.arrowRight)) {
        onDirectionInput.call(Vector2(1, 0));
      } else if (keysPressed.contains(LogicalKeyboardKey.space)) {
        togglePause();
      } else if (keysPressed.contains(LogicalKeyboardKey.f1)) {
        toggleSettings();
      }
    }
    return KeyEventResult.handled;
  }
}
