#!/bin/bash
# Flutter Web Deployment Test Script for Render
# This script helps verify the build will work on Render

set -e

echo "================================"
echo "🧪 Flutter Web Deployment Test"
echo "================================"
echo ""

# Check Flutter version
echo "✓ Checking Flutter version..."
flutter --version
echo ""

# Check Dart version
echo "✓ Checking Dart version..."
dart --version
echo ""

# Clean previous builds
echo "🧹 Cleaning previous builds..."
flutter clean
echo ""

# Get dependencies
echo "📦 Getting dependencies..."
flutter pub get
echo ""

# Check pubspec
echo "✓ Verifying pubspec.yaml..."
flutter pub list --format=json > /dev/null 2>&1 && echo "  Dependencies OK" || echo "  ⚠ Warning: Some dependencies may have issues"
echo ""

# Build for web
echo "🔨 Building for web (release mode)..."
echo "   This is what Render will do..."
echo ""

flutter build web \
  --release \
  --web-renderer html \
  --dart-define=FLUTTER_WEB_USE_SKIA=false

echo ""
echo "================================"
echo "✅ Build Successful!"
echo "================================"
echo ""
echo "Build output location:"
echo "  → build/web/"
echo ""
echo "Next steps:"
echo "  1. Test locally: cd build/web && python3 -m http.server 8000"
echo "  2. Open browser: http://localhost:8000"
echo "  3. Press F12 and check Console for errors"
echo "  4. If successful, push to GitHub"
echo "  5. Render will auto-deploy from main branch"
echo ""
