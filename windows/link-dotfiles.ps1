$dotfiles = "$env:USERPROFILE\dotfiles"
$env:XDG_CONFIG_HOME = "C:\Users\yym\.config"

$links = @(
  @{
    Source = "$dotfiles\.config\powershell\Microsoft.PowerShell_profile.ps1"
    Target = "$env:USERPROFILE\Documents\PowerShell\Microsoft.PowerShell_profile.ps1"
  },
  @{
    Source = "$dotfiles\windows\windows-terminal\settings.json"
    Target = "$env:LOCALAPPDATA\Packages\Microsoft.WindowsTerminal_8wekyb3d8bbwe\LocalState\settings.json"
  },
  @{
    Source = "$dotfiles\.config\nvim"
    Target = "$env:XDG_CONFIG_HOME\nvim"
  },
  @{
    Source = "$dotfiles\.config\lazygit"
    Target = "$env:XDG_CONFIG_HOME\lazygit"
  },
  @{
    Source = "$dotfiles\.config\git"
    Target = "$env:XDG_CONFIG_HOME\git"
  }
)

foreach ($link in $links)
{
  $src = $link.Source
  $dst = $link.Target

  if (Test-Path $dst)
  {
    Write-Host "Removing existing: $dst"
    Remove-Item $dst -Force -Recurse
  }

  $dstParent = Split-Path $dst
  if (-not (Test-Path $dstParent))
  {
    New-Item -ItemType Directory -Path $dstParent -Force | Out-Null
  }

  Write-Host "Linking: $dst → $src"
  New-Item -ItemType SymbolicLink -Path $dst -Target $src | Out-Null
}
