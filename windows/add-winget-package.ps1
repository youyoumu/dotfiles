param(
  [Parameter(Mandatory, Position = 0)]
  [string]$Id
)

$ErrorActionPreference = "Stop"
$packageFile = Join-Path $PSScriptRoot "winget-packages.yaml"

if (!(Test-Path $packageFile)) {
  Write-Host "🔴 Package file not found: $packageFile" -ForegroundColor Red
  exit 1
}

winget show --id $Id --exact | Out-Null
if ($LASTEXITCODE -ne 0) {
  Write-Host "🔴 No winget package found for '$Id'. Aborting." -ForegroundColor Red
  exit 1
}

$content = Get-Content $packageFile

$exists = $content | Where-Object { $_ -match "^\s*-\s*" -and $_.TrimStart("- ").Trim() -ieq $Id }
if ($exists) {
  Write-Host "⚠️ '$Id' is already in $packageFile. Aborting." -ForegroundColor Yellow
  exit 0
}

$entry = "  - $Id"
$sectionIndex = [Array]::IndexOf($content, "UnsortedPackages:")

if ($sectionIndex -eq -1) {
  $trimmed = @($content | Where-Object { $_.Trim() -ne "" })
  $lines = @()
  foreach ($line in $trimmed) { $lines += $line }
  $lines += ""
  $lines += "UnsortedPackages:"
  $lines += $entry
  Set-Content -Path $packageFile -Value $lines -Encoding utf8
  Write-Host "✅ Added '$Id' to UnsortedPackages (section created)." -ForegroundColor Green
  exit 0
}

$insertAfter = $sectionIndex
for ($i = $sectionIndex + 1; $i -lt $content.Count; $i++) {
  if ($content[$i] -match "^  - ") {
    $insertAfter = $i
  }
}

$lines = @()
for ($i = 0; $i -lt $content.Count; $i++) {
  $lines += $content[$i]
  if ($i -eq $insertAfter) {
    $lines += $entry
  }
}

Set-Content -Path $packageFile -Value $lines -Encoding utf8
Write-Host "✅ Added '$Id' to UnsortedPackages." -ForegroundColor Green