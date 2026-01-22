# fix_localization_final.ps1
Write-Host "=== FINAL LOCALIZATION FIX ===" -ForegroundColor Cyan

# Step 1: Check which files have the 'continue' keyword
Write-Host "`n1. Searching for 'continue' keyword issues..." -ForegroundColor Yellow
$search = Select-String -Path "lib" -Pattern "String get continue" -Recurse
if ($search) {
    Write-Host "Found files with 'continue' keyword:" -ForegroundColor Red
    $search | ForEach-Object {
        Write-Host "  - $($_.Path): Line $($_.LineNumber)" -ForegroundColor Gray
    }
} else {
    Write-Host "No 'continue' keyword found (good!)" -ForegroundColor Green
}

# Step 2: Fix the files
Write-Host "`n2. Fixing localization files..." -ForegroundColor Yellow
$filesToFix = @(
    "lib/l10n/app_localizations.dart",
    "lib/l10n/app_localizations_en.dart",
    "lib/l10n/app_localizations_ha.dart",
    "lib/l10n/app_localizations_ig.dart",
    "lib/l10n/app_localizations_pcm.dart",
    "lib/l10n/app_localizations_pt.dart",
    "lib/l10n/app_localizations_yo.dart"
)

foreach ($file in $filesToFix) {
    if (Test-Path $file) {
        $content = Get-Content $file -Raw
        $fixed = $content -replace 'String get continue', 'String get continueText'
        $fixed | Set-Content $file -Encoding UTF8
        Write-Host "  Fixed: $file" -ForegroundColor Green
    }
}

# Step 3: Clean and test
Write-Host "`n3. Cleaning and testing..." -ForegroundColor Yellow
flutter clean
flutter pub get

Write-Host "`n4. Testing build..." -ForegroundColor Yellow
Write-Host "If no errors appear, localization is fixed!" -ForegroundColor Gray

Write-Host "`n=== NEXT STEPS ===" -ForegroundColor Cyan
Write-Host "1. Run: flutter run" -ForegroundColor White
Write-Host "2. If it works, commit: git add . && git commit -m 'FIX: Localization - rename continue to continueText'" -ForegroundColor White
Write-Host "3. Push: git push" -ForegroundColor White
