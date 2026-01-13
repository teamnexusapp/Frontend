# APPLY LOCALIZATION CHANGES TO FRESH CLONE
# Instructions:
# 1. Open PowerShell as Administrator
# 2. Run: .\apply_localization.ps1

Write-Host "🚀 LOCALIZATION APPLICATION SCRIPT" -ForegroundColor Cyan
Write-Host "=" * 60

# Check if we're in the right place
if (-not (Test-Path "lib/l10n")) {
    Write-Host "❌ Not in Flutter project root. Please run from project root." -ForegroundColor Red
    exit 1
}

# Ask for confirmation
Write-Host "`n❓ This will overwrite existing localization files. Continue? (Y/N)" -ForegroundColor White -NoNewline
$response = Read-Host

if ($response -notmatch '^[Yy]') {
    Write-Host "❌ Cancelled." -ForegroundColor Red
    exit 1
}

# List of files to copy (relative to backup directory)
$files = @(
    "lib/l10n/app_en.arb",
    "lib/l10n/app_ig.arb", 
    "lib/l10n/app_yo.arb",
    "lib/l10n/app_ha.arb",
    "lib/main.dart",
    "lib/services/localization_provider.dart"
)

$sourceDir = "localization_backup"

foreach ($file in $files) {
    $sourcePath = "$sourceDir/$file"
    $destPath = $file
    
    if (Test-Path $sourcePath) {
        # Create destination directory if it doesn't exist
        $destDir = Split-Path $destPath -Parent
        if (-not (Test-Path $destDir)) {
            New-Item -ItemType Directory -Path $destDir -Force
        }
        
        # Backup existing file
        if (Test-Path $destPath) {
            Copy-Item $destPath "$destPath.backup_$(Get-Date -Format 'yyyyMMdd_HHmmss')" -Force
        }
        
        # Copy new file
        Copy-Item $sourcePath $destPath -Force
        Write-Host "✅ Applied: $file" -ForegroundColor Green
    } else {
        Write-Host "⚠️  Missing: $sourcePath" -ForegroundColor Yellow
    }
}

# Verify the changes
Write-Host "`n🔍 Verifying ARB files..." -ForegroundColor Cyan
if (Test-Path "lib/tools/check_arb_keys.dart") {
    dart run lib/tools/check_arb_keys.dart
} else {
    Write-Host "ℹ️  Checker tool not found. Files copied but not verified." -ForegroundColor Yellow
}

Write-Host "`n🎯 LOCALIZATION APPLIED SUCCESSFULLY!" -ForegroundColor Green
Write-Host "=" * 60
Write-Host "Next steps:" -ForegroundColor Cyan
Write-Host "1. Run: flutter gen-l10n" -ForegroundColor White
Write-Host "2. Test the app: flutter run" -ForegroundColor White
Write-Host "3. Commit and push changes" -ForegroundColor White
Write-Host "=" * 60
