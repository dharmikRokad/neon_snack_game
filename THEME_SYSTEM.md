# Snake Game - Theme System Implementation

## Overview
The Flutter snake game now supports multiple cyberpunk-themed color schemes that users can select from the main menu.

## Features Implemented

### 1. **Multi-Theme System**
Created a flexible theme system with 4 distinct cyberpunk color presets:

#### **Neon Green** (Classic)
- Primary: Bright Green (#00FF00)
- Secondary: Magenta (#FF00FF)
- Grid: Dark Green (#0F1F0F)
- The original classic cyberpunk terminal look

#### **Synthwave** (Purple/Pink)
- Primary: Magenta (#FF00FF)
- Secondary: Cyan (#00FFFF)
- Grid: Dark Purple (#1F0F1F)
- Retro 80s synthwave aesthetic

#### **Ocean Blue** (Cyan/Orange)
- Primary: Bright Cyan (#00CCFF)
- Secondary: Orange (#FFAA00)
- Grid: Dark Blue (#0F1F2F)
- Cool ocean depths with warm accents

#### **Fire Red** (Red/Yellow)
- Primary: Red-Orange (#FF3300)
- Secondary: Yellow (#FFDD00)
- Grid: Dark Red (#2F0F0F)
- Intense fire and heat vibes

### 2. **Theme Selection UI**
- Added theme selector to the main menu
- Each theme button shows:
  - Theme name in retro font
  - Color preview swatches (primary + secondary)
  - Glow effect when selected
  - Hover effects for better UX

### 3. **Dynamic Theme Application**
- Themes apply to ALL game elements:
  - Snake body (primary colors with gradients)
  - Food/collectibles (secondary color)
  - Grid lines (themed subtle colors)
  - UI overlays (HUD, buttons, text)
  - Glow effects and shadows
  - Title gradient on main menu

### 4. **Real-time Theme Switching**
- Instant visual feedback when selecting themes
- No need to restart the game
- Theme persists during gameplay (add localStorage for persistence if needed)

## Technical Implementation

### Files Modified/Created:
1. **lib/game/theme.dart** - Complete theme system with presets
2. **lib/overlays/main_menu.dart** - Added theme selection UI (StatefulWidget)
3. **lib/game/snake_game.dart** - Added `refreshTheme()` method
4. All visual components automatically adapt to current theme

### Theme Architecture:
```dart
GameTheme enum → GameThemeData class → CyberpunkTheme static accessor
```

The `CyberpunkTheme` class provides getters that return theme-dependent colors, ensuring all components automatically use the current theme.

## How to Use

### For Users:
1. Launch the game
2. On the main menu, find "SELECT THEME" section
3. Click/tap any theme preset to preview
4. Colors update immediately across the entire UI
5. Click "INITIALIZE SYSTEM" to start playing

### For Developers:
To add a new theme:
1. Add enum value to `GameTheme`
2. Create `GameThemeData` const in theme.dart
3. Add case in `GameThemeData.fromEnum()`
4. Add button in `main_menu.dart`

## Future Enhancements (Optional)
- Save selected theme to localStorage
- Custom theme creator (let users pick their own colors)
- Animated theme transitions
- More theme presets (Matrix, Tron, etc.)
- Theme-specific sound effects
