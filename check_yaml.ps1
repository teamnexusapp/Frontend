# PowerShell YAML syntax checker
$yamlFile = ".github/workflows/flutter_ci.yml"

# Check for common errors
$content = Get-Content $yamlFile -Raw

# 1. Check for proper indentation (2 spaces)
$lines = $content -split "`n"
for ($i = 0; $i -lt $lines.Count; $i++) {
    $line = $lines[$i]
    if ($line -match '^\t') {
        Write-Host "ERROR Line $($i+1): Uses tabs instead of spaces" -ForegroundColor Red
        break
    }
}

# 2. Check for basic structure
$requiredSections = @('name:', 'on:', 'jobs:')
foreach ($section in $requiredSections) {
    if ($content -notmatch "^$section") {
        Write-Host "WARNING: Missing required section '$section'" -ForegroundColor Yellow
    }
}

# 3. Check line 5 specifically
if ($lines.Count -ge 5) {
    $line5 = $lines[4]
    Write-Host "Line 5 content: '$line5'" -ForegroundColor Cyan
}
