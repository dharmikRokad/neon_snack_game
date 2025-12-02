#!/bin/bash

echo "🎮 Deploying Neon Snake Game..."

# Build the web version
echo "📦 Building web version..."
flutter build web --release --base-href "/neon_snack_game/"

# Deploy to GitHub Pages using npx (no global install needed)
echo "🚀 Deploying to GitHub Pages..."
npx -y gh-pages -d build/web

echo "✅ Deployment complete!"
echo "🌐 Your game will be available at: https://dharmikRokad.github.io/neon_snack_game/"
echo ""
echo "Note: It may take a few minutes for GitHub Pages to update."

