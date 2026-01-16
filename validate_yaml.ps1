# Simple YAML validation
$yamlFile = ".github/workflows/flutter_ci.yml"

if (Test-Path $yamlFile) {
    $content = Get-Content $yamlFile
    
    Write-Host "=== YAML VALIDATION ==="
    Write-Host "File exists with $($content.Count) lines"
    
    # Check required sections
    $hasName = $content | Where-Object { $_ -match '^name:' } | Measure-Object | Select-Object -ExpandProperty Count
    $hasOn = $content | Where-Object { $_ -match '^on:' } | Measure-Object | Select-Object -ExpandProperty Count
    $hasJobs = $content | Where-Object { $_ -match '^jobs:' } | Measure-Object | Select-Object -ExpandProperty Count
    
    if ($hasName -gt 0) { Write-Host "✓ Has 'name:' section" } else { Write-Host "✗ Missing 'name:' section" }
    if ($hasOn -gt 0) { Write-Host "✓ Has 'on:' section" } else { Write-Host "✗ Missing 'on:' section" }
    if ($hasJobs -gt 0) { Write-Host "✓ Has 'jobs:' section" } else { Write-Host "✗ Missing 'jobs:' section" }
    
    # Check line 5
    if ($content.Count -ge 5) {
        $line5 = $content[4]
        Write-Host "Line 5: '$line5'"
        if ($line5.Trim() -eq 'push:') {
            Write-Host "✓ Line 5 is correct"
        } else {
            Write-Host "✗ Line 5 might be incorrect"
        }
    }
} else {
    Write-Host "YAML file not found: $yamlFile"
}
