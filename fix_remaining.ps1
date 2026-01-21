# fix_remaining.ps1
Write-Host "Fixing remaining common issues..." -ForegroundColor Yellow

# 1. Fix all remaining TextTheme issues
Get-ChildItem -Path "lib" -Filter "*.dart" -Recurse -File | ForEach-Object {
    $content = Get-Content $_.FullName -Raw
    $original = $content
    
    # Fix any remaining button widget issues
    $content = $content -replace 'ElevatedlabelLarge', 'ElevatedButton'
    $content = $content -replace 'TextlabelLarge', 'TextButton'
    $content = $content -replace 'OutlinedlabelLarge', 'OutlinedButton'
    $content = $content -replace 'IconlabelLarge', 'IconButton'
    $content = $content -replace 'DropdownlabelLarge', 'DropdownButton'
    $content = $content -replace 'FloatingActionlabelLarge', 'FloatingActionButton'
    
    # Fix TextTheme references
    $content = $content -replace 'textTheme\.labelLarge\b', 'textTheme.labelLarge'
    
    if ($content -ne $original) {
        Set-Content -Path $_.FullName -Value $content -Encoding UTF8
    }
}

# 2. Fix AppLocalizations imports
$filesWithLoc = Get-ChildItem -Path "lib" -Filter "*.dart" -Recurse -File | Where-Object {
    (Get-Content $_.FullName -Raw) -match 'AppLocalizations'
}

foreach ($file in $filesWithLoc) {
    $content = Get-Content $file.FullName -Raw
    $lines = $content -split "`n"
    $hasImport = $false
    
    foreach ($line in $lines) {
        if ($line -match 'import.*app_localizations\.dart') {
            $hasImport = $true
            break
        }
    }
    
    if (-not $hasImport) {
        # Add import if missing
        $newContent = "import 'package:flutter_gen/gen_l10n/app_localizations.dart';`n" + $content
        Set-Content -Path $file.FullName -Value $newContent -Encoding UTF8
        Write-Host "Added AppLocalizations import to $($file.Name)" -ForegroundColor Green
    }
}

Write-Host "Done! Run 'flutter analyze' to check remaining issues." -ForegroundColor Green
