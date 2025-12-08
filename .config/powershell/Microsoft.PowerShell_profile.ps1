Invoke-Expression (&starship init powershell)
Invoke-Expression (& { (zoxide init powershell | Out-String) })

$pathsToAdd = @(
  "C:\Program Files\7-Zip",
  "C:\Program Files\KeePassXC",
  "C:\Program Files (x86)\GnuWin32\bin"
  "$env:USERPROFILE\dotfiles\windows\script"
)
foreach ($p in $pathsToAdd)
{
  if (-not ($env:Path -split ";" | Where-Object { $_ -eq $p }))
  {
    $env:Path = "$p;$env:Path"
  }
}

Set-PSReadlineKeyHandler -Key ctrl+d -Function DeleteCharOrExit
Set-PsFzfOption -PSReadlineChordProvider 'Ctrl+t' -PSReadlineChordReverseHistory 'Ctrl+r'
Set-PSReadLineKeyHandler -Key Tab -ScriptBlock { Invoke-FzfTabCompletion }

# Simple override for `ls`
Remove-Alias -Name ls
Set-Alias list Get-ChildItem
function ls
{ eza.exe --long --icons --git --all --header --binary --no-permissions --no-user --mounts --grid --group-directories-first 
}

# Long listing with groups
function lsl
{ eza.exe --long --icons --header --all --binary --mounts --group-directories-first --group 
}

# Tree views
function lt
{ eza.exe --tree --icons --all --group-directories-first 
}
function lt2
{ eza.exe --tree --level=2 --icons --all --group-directories-first 
}
function lt3
{ eza.exe --tree --level=3 --icons --all --group-directories-first 
}
function lt4
{ eza.exe --tree --level=4 --icons --all --group-directories-first 
}
function lt5
{ eza.exe --tree --level=5 --icons --all --group-directories-first 
}

Set-Alias lg lazygit.exe
Set-Alias n nvim.exe
Set-Alias j just.exe
Set-Alias p pnpm.exe

function realpath
{
  param(
    [Parameter(Mandatory=$true, ValueFromRemainingArguments=$true)]
    [string[]]$Paths
  )
  foreach ($p in $Paths)
  {
    Resolve-Path -LiteralPath $p | ForEach-Object { $_.Path }
  }
}


function which
{
  param(
    [Parameter(Mandatory = $true, ValueFromRemainingArguments = $true)]
    [string[]] $Name
  )

  foreach ($n in $Name)
  {
    $cmd = Get-Command $n -ErrorAction SilentlyContinue
    if ($cmd)
    {
      $cmd.Path
    }
  }
}
