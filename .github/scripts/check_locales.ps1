# PowerShell script to check locale files
$ErrorActionPreference = "Stop"
$ALLOWED = @("app_en", "app_yo", "app_ig", "app_ha")
$foundDisallowed = @()
$arbFiles = Get-ChildItem -Path "lib/l10n" -Filter "app_*.arb" -ErrorAction SilentlyContinue
foreach ($file in $arbFiles) {
    $baseName = $file.BaseName
    $isAllowed = $false
    foreach ($allowedName in $ALLOWED) {
        if ($baseName -eq $allowedName) { $isAllowed = $true; break }
    }
    if (-not $isAllowed) { $foundDisallowed += $file.FullName }
}
if ($foundDisallowed.Count -gt 0) {
    Write-Host "Found disallowed locale files:" -ForegroundColor Red
    foreach ($f in $foundDisallowed) { Write-Host " - $f" -ForegroundColor Red }
    Write-Host "Only these locales are allowed: $($ALLOWED -join ', ')" -ForegroundColor Red
    exit 1
}
Write-Host "Locale check passed. Only allowed locale files present." -ForegroundColor Green
exit 0
