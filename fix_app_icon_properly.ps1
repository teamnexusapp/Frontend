# fix_app_icon_properly.ps1
Write-Host "=== Properly Fixing App Icon ===" -ForegroundColor Cyan

# Step 1: Check if we have the Nexus logo somewhere
Write-Host "Step 1: Searching for Nexus logo files..." -ForegroundColor Yellow

# Search for any file with "nexus" or "logo" in the name
$possibleLogoFiles = Get-ChildItem -Path "." -Filter "*logo*" -Recurse -File -ErrorAction SilentlyContinue |
    Where-Object { $_.Extension -in @('.png', '.jpg', '.jpeg', '.svg') -and $_.FullName -notmatch 'build|\.dart_tool|backup' }

if ($possibleLogoFiles.Count -gt 0) {
    Write-Host "Found potential logo files:" -ForegroundColor Green
    $possibleLogoFiles | ForEach-Object {
        Write-Host "  - $($_.FullName.Replace("$PWD\", "")) ($([math]::Round($_.Length/1024)) KB)" -ForegroundColor Gray
    }
    
    # Choose the most likely logo (largest PNG file with "logo" in name)
    $mainLogo = $possibleLogoFiles | 
        Where-Object { $_.Extension -eq '.png' -and $_.Name -match 'logo' } |
        Sort-Object Length -Descending | 
        Select-Object -First 1
    
    if ($mainLogo) {
        Write-Host "`nSelected main logo: $($mainLogo.FullName.Replace("$PWD\", ""))" -ForegroundColor Green
        $logoPath = $mainLogo.FullName
    } else {
        Write-Host "`nNo suitable PNG logo found. Will create a placeholder." -ForegroundColor Yellow
        $logoPath = $null
    }
} else {
    Write-Host "No logo files found. Will create a placeholder." -ForegroundColor Yellow
    $logoPath = $null
}

# Step 2: Create assets directory and copy/place logo
Write-Host "`nStep 2: Setting up logo in assets directory..." -ForegroundColor Yellow

# Create assets directory if it doesn't exist
New-Item -ItemType Directory -Path "assets" -Force | Out-Null

$targetLogoPath = "assets/logo.png"

if ($logoPath -and $logoPath -ne $targetLogoPath) {
    Write-Host "Copying logo to $targetLogoPath" -ForegroundColor Green
    Copy-Item -Path $logoPath -Destination $targetLogoPath -Force
} elseif (-not (Test-Path $targetLogoPath)) {
    Write-Host "Creating a placeholder Nexus logo..." -ForegroundColor Yellow
    
    # Create a simple Nexus-themed logo (green with heart and text)
    try {
        # Try to create using System.Drawing if available
        Add-Type -AssemblyName System.Drawing
        
        $width = 1024
        $height = 1024
        $bitmap = New-Object System.Drawing.Bitmap($width, $height)
        $graphics = [System.Drawing.Graphics]::FromImage($bitmap)
        
        # Green background
        $graphics.Clear([System.Drawing.Color]::FromArgb(76, 175, 80))
        
        # Draw a heart
        $heartPath = New-Object System.Drawing.Drawing2D.GraphicsPath
        $heartPath.AddBezier($width/2, $height/2 + 200, $width/2 - 150, $height/2 - 100, $width/2 - 300, $height/2, $width/2, $height/2 + 100)
        $heartPath.AddBezier($width/2, $height/2 + 200, $width/2 + 150, $height/2 - 100, $width/2 + 300, $height/2, $width/2, $height/2 + 100)
        $heartPath.CloseFigure()
        
        $heartBrush = New-Object System.Drawing.SolidBrush([System.Drawing.Color]::White)
        $graphics.FillPath($heartBrush, $heartPath)
        
        # Add "NEXUS" text
        $font = New-Object System.Drawing.Font("Arial", 120, [System.Drawing.FontStyle]::Bold)
        $textBrush = New-Object System.Drawing.SolidBrush([System.Drawing.Color]::White)
        $textSize = $graphics.MeasureString("NEXUS", $font)
        $textX = ($width - $textSize.Width) / 2
        $textY = $height/2 - 300
        $graphics.DrawString("NEXUS", $font, $textBrush, $textX, $textY)
        
        # Add "Fertility" text
        $smallFont = New-Object System.Drawing.Font("Arial", 60, [System.Drawing.FontStyle]::Regular)
        $smallTextSize = $graphics.MeasureString("FERTILITY", $smallFont)
        $smallTextX = ($width - $smallTextSize.Width) / 2
        $smallTextY = $height/2 + 350
        $graphics.DrawString("FERTILITY", $smallFont, $textBrush, $smallTextX, $smallTextY)
        
        $graphics.Dispose()
        $bitmap.Save($targetLogoPath, [System.Drawing.Imaging.ImageFormat]::Png)
        $bitmap.Dispose()
        
        Write-Host "Created placeholder logo at $targetLogoPath" -ForegroundColor Green
    } catch {
        Write-Host "Could not create logo with System.Drawing. Creating a simple text file as fallback." -ForegroundColor Red
        # Fallback: create a simple text file (won't work as icon but will help with configuration)
        "Nexus Fertility Logo" | Out-File $targetLogoPath -Encoding UTF8
    }
} else {
    Write-Host "Logo already exists at $targetLogoPath" -ForegroundColor Green
}

# Step 3: Update pubspec.yaml with correct configuration
Write-Host "`nStep 3: Updating pubspec.yaml configuration..." -ForegroundColor Yellow

$pubspecPath = "pubspec.yaml"
$pubspecContent = Get-Content $pubspecPath -Raw

# Ensure we have proper flutter_launcher_icons configuration
if ($pubspecContent -notmatch 'flutter_icons:') {
    Write-Host "Adding flutter_launcher_icons configuration..." -ForegroundColor Green
    
    $iconConfig = @"

flutter_icons:
  android: true
  ios: true
  image_path: "assets/logo.png"
  min_sdk_android: 21
  web:
    generate: true
    image_path: "assets/logo.png"
    background_color: "#4CAF50"
    theme_color: "#4CAF50"
"@
    
    # Add to the end of the file
    $pubspecContent += "`n`n$iconConfig"
} else {
    Write-Host "Updating existing flutter_icons configuration..." -ForegroundColor Green
    # Update the image_path if it's wrong
    $pubspecContent = $pubspecContent -replace 'image_path:.*', 'image_path: "assets/logo.png"'
}

# Ensure we have proper flutter_native_splash configuration
if ($pubspecContent -notmatch 'flutter_native_splash:') {
    Write-Host "Adding flutter_native_splash configuration..." -ForegroundColor Green
    
    $splashConfig = @"

flutter_native_splash:
  color: "#4CAF50"
  image: "assets/logo.png"
  android: true
  ios: true
  android_12:
    color: "#4CAF50"
    image: "assets/logo.png"
    icon_background_color: "#4CAF50"
  web: true
"@
    
    $pubspecContent += "`n`n$splashConfig"
} else {
    Write-Host "Updating existing flutter_native_splash configuration..." -ForegroundColor Green
    # Update the image if it's wrong
    $pubspecContent = $pubspecContent -replace '(?s)flutter_native_splash:(.*?)image:.*', 'flutter_native_splash:$1image: "assets/logo.png"'
}

# Save updated pubspec
$pubspecContent | Out-File $pubspecPath -Encoding UTF8
Write-Host "Updated pubspec.yaml" -ForegroundColor Green

# Step 4: Generate the icons and splash screen
Write-Host "`nStep 4: Generating app icons and splash screen..." -ForegroundColor Yellow

# Clean and get dependencies
Write-Host "Getting dependencies..." -ForegroundColor Gray
flutter clean
flutter pub get

# Generate icons
Write-Host "Generating app icons..." -ForegroundColor Gray
flutter pub run flutter_launcher_icons:main

# Generate splash screen
Write-Host "Generating splash screen..." -ForegroundColor Gray
flutter pub run flutter_native_splash:create

Write-Host "`n=== ICON FIX COMPLETE ===" -ForegroundColor Green
Write-Host "App icon and splash screen have been configured." -ForegroundColor Green
Write-Host "`nTo test the app icon:" -ForegroundColor Cyan
Write-Host "1. Uninstall the app from your device/emulator" -ForegroundColor White
Write-Host "2. Run: flutter run --release" -ForegroundColor White
Write-Host "3. Check if the app icon shows the Nexus logo" -ForegroundColor White
Write-Host "`nNote: On Android, you may need to clear the app cache or reinstall." -ForegroundColor Yellow
Write-Host "Note: On iOS, you may need to clean build: flutter clean && flutter build ios" -ForegroundColor Yellow
