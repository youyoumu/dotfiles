$dotfiles = "$env:USERPROFILE\dotfiles"

$links = @(
  @{
    Source = "$dotfiles\.config\powershell\Microsoft.PowerShell_profile.ps1"
    Target = "$env:USERPROFILE\Documents\PowerShell\Microsoft.PowerShell_profile.ps1"
  },
  @{
    Source = "$dotfiles\.config\nvim"
    Target = "$env:LOCALAPPDATA\nvim"
  },
  @{
    Source = "$dotfiles\.gitconfig"
    Target = "$env:USERPROFILE\.gitconfig"
  }
  @{
    Source = "$dotfiles\windows\windows-terminal\settings.json"
    Target = "$env:LOCALAPPDATA\Packages\Microsoft.WindowsTerminal_8wekyb3d8bbwe\LocalState\settings.json"
  }
  @{
    Source = "$dotfiles\.gitconfig.windows"
    Target = "$env:USERPROFILE\.gitconfig.windows"
  }
  @{
    Source = "$dotfiles\.gitconfig.linux"
    Target = "$env:USERPROFILE\.gitconfig.linux"
  }
  @{
    Source = "$dotfiles\windows\chezmoi\chezmoi.toml"
    Target = "$env:USERPROFILE\.config\chezmoi\chezmoi.toml"
  }
  @{
    Source = "$dotfiles\windows\komorebi\komorebi.json"
    Target = "$env:USERPROFILE\komorebi.json"
  }
  @{
    Source = "$dotfiles\windows\komorebi\komorebi.bar.json"
    Target = "$env:USERPROFILE\komorebi.bar.json"
  }
  @{
    Source = "$dotfiles\windows\whkdrc\whkdrc"
    Target = "$env:USERPROFILE\.config\whkdrc"
  }
  @{
    Source = "$dotfiles\windows\yasb"
    Target = "$env:USERPROFILE\.config\yasb"
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
