# Script to apply translation bundle
param(
    [string]$BundlePath = "translations-bundle.bundle"
)

Write-Host "🌍 Applying translation bundle..." -ForegroundColor Cyan

if (-not (Test-Path $BundlePath)) {
    Write-Host "❌ Bundle file not found: $BundlePath" -ForegroundColor Red
    exit 1
}

# Fetch the bundle
Write-Host "📥 Fetching translations from bundle..." -ForegroundColor Yellow
git fetch $BundlePath HEAD:translation-updates

# Checkout the branch
Write-Host "🔀 Checking out translation updates..." -ForegroundColor Yellow
git checkout translation-updates

# Copy ARB files to current branch
Write-Host "📋 Copying ARB files..." -ForegroundColor White
Copy-Item lib/l10n/app_*.arb -Destination ../lib/l10n/ -Force

# Go back to original branch
git checkout -

Write-Host "✅ Translations applied successfully!" -ForegroundColor Green
Write-Host "💡 Run: dart run lib/tools/check_arb_keys.dart" -ForegroundColor White
Write-Host "💡 Run: flutter gen-l10n" -ForegroundColor White
