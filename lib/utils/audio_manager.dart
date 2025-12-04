    import 'package:flame_audio/flame_audio.dart';

    /// Singleton class to manage all audio in the game
    class AudioManager {
      static final AudioManager _instance = AudioManager._internal();

      factory AudioManager() => _instance;

      AudioManager._internal();

      bool _initialized = false;
      bool _isMuted = false;

      /// Initialize audio files
      Future<void> initialize() async {
        if (_initialized) return;

        try {
          // Preload all audio files for better performance
          await Future.wait([
            FlameAudio.audioCache.load('eat.wav'),
            FlameAudio.audioCache.load('game_over.wav'),
            FlameAudio.audioCache.load('background.mp3'),
          ]);

          _initialized = true;
        } catch (e) {
          // Silently fail if audio can't be loaded
          // This prevents the game from crashing on platforms without audio support
          print('Failed to initialize audio: $e');
        }
      }

      /// Play the eat sound effect
      void playEatSound() {
        if (!_initialized || _isMuted) return;
        try {
          FlameAudio.play('eat.wav', volume: 0.5);
        } catch (e) {
          print('Failed to play eat sound: $e');
        }
      }

      /// Play the game over sound effect
      void playGameOverSound() {
        if (!_initialized || _isMuted) return;
        try {
          FlameAudio.play('game_over.wav', volume: 0.6);
        } catch (e) {
          print('Failed to play game over sound: $e');
        }
      }

          /// Start background music (looping)
          Future<void> startBackgroundMusic() async {
            if (!_initialized || _isMuted) return;
            try {
              await FlameAudio.bgm.play('background.mp3', volume: 0.3);
            } catch (e) {
              print('Failed to play background music: $e');
            }
          }

      /// Stop background music
      void stopBackgroundMusic() {
        if (!_initialized) return;
        try {
          FlameAudio.bgm.stop();
        } catch (e) {
          print('Failed to stop background music: $e');
        }
      }

      /// Pause background music
      void pauseBackgroundMusic() {
        if (!_initialized) return;
        try {
          FlameAudio.bgm.pause();
        } catch (e) {
          print('Failed to pause background music: $e');
        }
      }

      /// Resume background music
      void resumeBackgroundMusic() {
        if (!_initialized || _isMuted) return;
        try {
          FlameAudio.bgm.resume();
        } catch (e) {
          print('Failed to resume background music: $e');
        }
      }

      /// Toggle mute state
      void toggleMute() {
        _isMuted = !_isMuted;
        if (_isMuted) {
          pauseBackgroundMusic();
        } else {
          resumeBackgroundMusic();
        }
      }

      /// Get current mute state
      bool get isMuted => _isMuted;

      /// Dispose audio resources
      void dispose() {
        stopBackgroundMusic();
        FlameAudio.audioCache.clearAll();
        _initialized = false;
      }
    }
