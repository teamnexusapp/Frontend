# fix_app_icon.ps1
Write-Host "=== Fixing App Icon ===" -ForegroundColor Cyan

# Step 1: Make sure we have the required packages in pubspec.yaml
Write-Host "Step 1: Checking pubspec.yaml..." -ForegroundColor Yellow

$pubspecPath = "pubspec.yaml"
if (Test-Path $pubspecPath) {
    $pubspec = Get-Content $pubspecPath -Raw
    
    # Check if flutter_launcher_icons is in dependencies
    if ($pubspec -notmatch "flutter_launcher_icons:") {
        Write-Host "Adding flutter_launcher_icons package..." -ForegroundColor Green
        
        # Add to dev_dependencies
        if ($pubspec -match "dev_dependencies:") {
            $pubspec = $pubspec -replace "dev_dependencies:", "dev_dependencies:`n  flutter_launcher_icons: ^0.13.1"
        } else {
            # Add dev_dependencies section
            $pubspec = $pubspec -replace "flutter:", "dev_dependencies:`n  flutter_launcher_icons: ^0.13.1`n`nflutter:"
        }
    }
    
    # Check if flutter_native_splash is in dependencies
    if ($pubspec -notmatch "flutter_native_splash:") {
        Write-Host "Adding flutter_native_splash package..." -ForegroundColor Green
        
        # Add to dev_dependencies
        if ($pubspec -match "flutter_launcher_icons:") {
            $pubspec = $pubspec -replace "flutter_launcher_icons:.*", "flutter_launcher_icons: ^0.13.1`n  flutter_native_splash: ^2.4.7"
        }
    }
    
    # Save updated pubspec
    $pubspec | Out-File $pubspecPath -Encoding UTF8
    Write-Host "Updated pubspec.yaml" -ForegroundColor Green
}

# Step 2: Create flutter_launcher_icons configuration
Write-Host "Step 2: Creating icon configuration..." -ForegroundColor Yellow

# First, let's find a logo file
$possibleLogos = @("assets/logo.png", "assets/icon.png", "logo.png", "icon.png", "assets/images/logo.png")
$logoPath = $null

foreach ($logo in $possibleLogos) {
    if (Test-Path $logo) {
        $logoPath = $logo
        Write-Host "Found logo at: $logoPath" -ForegroundColor Green
        break
    }
}

if (-not $logoPath) {
    Write-Host "ERROR: No logo file found!" -ForegroundColor Red
    Write-Host "Please place your logo in one of these locations:" -ForegroundColor Yellow
    $possibleLogos | ForEach-Object { Write-Host "  - $_" -ForegroundColor Gray }
    exit 1
}

# Step 3: Add flutter_launcher_icons configuration to pubspec.yaml
Write-Host "Step 3: Adding icon configuration to pubspec.yaml..." -ForegroundColor Yellow

$pubspec = Get-Content $pubspecPath -Raw

# Check if flutter_icons configuration already exists
if ($pubspec -notmatch "flutter_icons:") {
    # Add configuration at the end of the file
    $iconConfig = @"

flutter_icons:
  android: "launcher_icon"
  ios: true
  image_path: "$logoPath"
  adaptive_icon_background: "#FFFFFF"
  adaptive_icon_foreground: "$logoPath"
"@
    
    $pubspec += "`n`n$iconConfig"
    $pubspec | Out-File $pubspecPath -Encoding UTF8
    Write-Host "Added icon configuration" -ForegroundColor Green
}

# Step 4: Add flutter_native_splash configuration
Write-Host "Step 4: Adding splash screen configuration..." -ForegroundColor Yellow

if ($pubspec -notmatch "flutter_native_splash:") {
    $splashConfig = @"

flutter_native_splash:
  color: "#4CAF50"
  image: "$logoPath"
  android: true
  ios: true
  android_12:
    color: "#4CAF50"
    image: "$logoPath"
    icon_background_color: "#4CAF50"
"@
    
    $pubspec += "`n`n$splashConfig"
    $pubspec | Out-File $pubspecPath -Encoding UTF8
    Write-Host "Added splash screen configuration" -ForegroundColor Green
}

# Step 5: Run the packages
Write-Host "Step 5: Running packages to generate icons..." -ForegroundColor Yellow

# Get dependencies
Write-Host "Getting dependencies..." -ForegroundColor Gray
flutter pub get 2>&1 | Out-Null

# Generate icons
Write-Host "Generating app icons..." -ForegroundColor Gray
flutter pub run flutter_launcher_icons:main 2>&1 | Out-Null

# Generate splash screen
Write-Host "Generating splash screen..." -ForegroundColor Gray
flutter pub run flutter_native_splash:create 2>&1 | Out-Null

Write-Host "`n=== COMPLETE ===" -ForegroundColor Green
Write-Host "App icons and splash screen have been configured." -ForegroundColor Green
Write-Host "Check the following directories:" -ForegroundColor Yellow
Write-Host "  - android/app/src/main/res/mipmap-*/" -ForegroundColor Gray
Write-Host "  - ios/Runner/Assets.xcassets/AppIcon.appiconset/" -ForegroundColor Gray
Write-Host "`nTo test, build the app:" -ForegroundColor Cyan
Write-Host "  flutter build apk --release" -ForegroundColor White
Write-Host "  OR" -ForegroundColor White
Write-Host "  flutter build ios --release" -ForegroundColor White
