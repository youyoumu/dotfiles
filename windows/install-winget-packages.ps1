Install-Module powershell-yaml -Scope CurrentUser
Install-Module -Name Microsoft.WinGet.Client -Scope CurrentUser

$packageFile = "$PSScriptRoot\winget-packages.yaml"
$yamlContent = Get-Content $packageFile -Raw | ConvertFrom-Yaml
$packages = $yamlContent.packages

Write-Host "📄 Fetching installed Winget packages..."
$installedPackages = Get-WinGetPackage -ErrorAction SilentlyContinue

function Is-PackageInstalled($id) {
    $match = $installedPackages | Where-Object { $_.Id -eq $id }
    if ($null -ne $match) {
        Write-Host "✅ Package '$id' is already installed. (📦 Version: $($match.InstalledVersion))"
        return $true
    } else {
        Write-Host "🔴 Package '$id' is not installed."
        return $false
    }
}

foreach ($pkg in $packages) {
    Write-Host "`n📦 Package ID: $pkg"

    if (Is-PackageInstalled $pkg) {
        Write-Host "✅ Already installed. Skipping..."
        continue
    }

    Write-Host "📦 Fetching package info from Winget..."
    $info = winget show --id $pkg --exact | Select-String '^(Version|Description):'

    if ($info) {
        $info | ForEach-Object { $_.Line }
    } else {
        Write-Host "🔴 Could not fetch summary for $pkg."
        continue
    }

    $choice = Read-Host "Install this package? (y/n)"

    switch ($choice.ToLower()) {
        "y" {
            Write-Host "🚧 Installing $pkg..."
            winget install --id $pkg -e
            if ($LASTEXITCODE -eq 0) {
                Write-Host "✅ Installed $pkg successfully."
            } else {
                Write-Host "🔴 Failed to install $pkg. Exit code: $LASTEXITCODE"
            }
        }
        "n" {
            Write-Host "🚧 Skipping $pkg..."
        }
        default {
            Write-Host "⚠️ Invalid input. Skipping $pkg..."
        }
    }

    Write-Host "`n--------------------------"
}

