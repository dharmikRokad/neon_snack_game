#!/bin/bash

echo "🎮 Deploying Neon Snake Game..."

# Build the web version
echo "📦 Building web version..."
flutter build web --release --base-href "/neon_snack_game/"

# Check if gh-pages is installed
if ! command -v gh-pages &> /dev/null
then
    echo "📥 Installing gh-pages..."
    npm install -g gh-pages
fi

# Deploy to GitHub Pages
echo "🚀 Deploying to GitHub Pages..."
gh-pages -d build/web

echo "✅ Deployment complete!"
echo "🌐 Your game will be available at: https://dharmikRokad.github.io/neon_snack_game/"
echo ""
echo "Note: It may take a few minutes for GitHub Pages to update."
