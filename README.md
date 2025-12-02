# 🐍 Neon Snake Game

A retro cyberpunk-themed snake game built with Flutter and Flame engine, featuring multiple color themes and smooth gameplay.

![Neon Snake Game](https://img.shields.io/badge/Flutter-Web%20Game-blue?style=for-the-badge&logo=flutter)
![License](https://img.shields.io/badge/License-MIT-green?style=for-the-badge)

## 🎮 Play Online

**[Play the Game →](https://dharmikRokad.github.io/neon_snack_game/)**

## ✨ Features

- 🎨 **4 Cyberpunk Themes**: Choose from Neon Green, Synthwave, Ocean Blue, or Fire Red
- 📱 **Responsive Design**: Play on any device - desktop, tablet, or mobile
- 🕹️ **Multiple Control Options**: Keyboard arrows, on-screen D-pad, or swipe gestures
- 💾 **High Score Tracking**: Beat your personal best
- ⚡ **Progressive Difficulty**: Snake speeds up as you eat more food
- 🌐 **PWA Ready**: Install as an app on your phone
- 🎯 **Retro Aesthetic**: CRT scanlines, neon glow effects, and pixel-perfect rendering

## 🎨 Available Themes

| Theme | Colors | Vibe |
|-------|--------|------|
| **Neon Green** | Green & Magenta | Classic Terminal |
| **Synthwave** | Magenta & Cyan | Retro 80s |
| **Ocean Blue** | Cyan & Orange | Deep Sea |
| **Fire Red** | Red & Yellow | Intense Heat |

## 🚀 Quick Start

### Prerequisites
- Flutter SDK (3.24.5 or higher)
- Chrome/Firefox/Safari (for web testing)

### Run Locally

```bash
# Clone the repository
git clone https://github.com/dharmikRokad/neon_snack_game.git
cd neon_snack_game

# Install dependencies
flutter pub get

# Run on Chrome
flutter run -d chrome
```

## 📦 Build & Deploy

### Build for Web
```bash
flutter build web --release --base-href "/neon_snack_game/"
```

### Quick Deploy (GitHub Pages)
```bash
# Make deploy script executable (one-time)
chmod +x deploy.sh

# Deploy to GitHub Pages
./deploy.sh
```

Or use the automated GitHub Actions workflow (push to main branch and it auto-deploys).

See [DEPLOYMENT_GUIDE.md](DEPLOYMENT_GUIDE.md) for more deployment options (Firebase, Netlify, Vercel).

## 🎯 How to Play

1. **Select Your Theme** - Choose your favorite color scheme from the main menu
2. **Start the Game** - Click "INITIALIZE SYSTEM" or press Space
3. **Control the Snake**:
   - **Desktop**: Arrow keys ⬆️⬇️⬅️➡️
   - **Mobile**: On-screen D-pad or swipe gestures
4. **Eat the Food** (glowing pink/cyan squares) to grow and score points
5. **Avoid**:
   - Hitting the walls
   - Running into yourself
6. **Beat Your High Score!**

## 🛠️ Tech Stack

- **Framework**: Flutter 3.24.5
- **Game Engine**: Flame
- **Font**: Press Start 2P (Google Fonts)
- **Deployment**: GitHub Pages / Firebase / Netlify
- **Language**: Dart

## 📂 Project Structure

```
lib/
├── game/
│   ├── snake_game.dart    # Main game logic
│   ├── snake.dart          # Snake entity
│   ├── food.dart           # Food/collectible entity
│   └── theme.dart          # Theme system with 4 presets
├── overlays/
│   ├── main_menu.dart      # Start screen with theme selector
│   ├── game_over.dart      # Game over screen
│   └── game_overlay.dart   # HUD and controls
└── main.dart               # App entry point
```

## 🎨 Customization

### Add a New Theme

1. Add enum value in `lib/game/theme.dart`
2. Create `GameThemeData` const with your colors
3. Add case in `fromEnum()` method
4. Add theme button in `main_menu.dart`

Example:
```dart
static const myTheme = GameThemeData(
  name: 'MY THEME',
  primary: Color(0xFFFF00AA),
  secondary: Color(0xFF00FFAA),
  // ... other colors
);
```

## 📝 Contributing

Contributions are welcome! Feel free to:
- Report bugs
- Suggest new features
- Submit pull requests
- Add more themes

## 📄 License

This project is open source and available under the MIT License.

## 🙏 Credits

- Original HTML/CSS/JS version by dharmikRokad
- Font: [Press Start 2P](https://fonts.google.com/specimen/Press+Start+2P) by CodeMan38
- Built with [Flutter](https://flutter.dev/) and [Flame](https://flame-engine.org/)

## 🔗 Links

- **Live Demo**: [Play Now](https://dharmikRokad.github.io/neon_snack_game/)
- **GitHub**: [Source Code](https://github.com/dharmikRokad/neon_snack_game)
- **Documentation**: See [THEME_SYSTEM.md](THEME_SYSTEM.md) for theme details

---

Made with 💚 by dharmikRokad | Enjoy the game! 🎮
