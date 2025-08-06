Invoke-Expression (&starship init powershell)
Invoke-Expression (& { (zoxide init powershell | Out-String) })

# Simple override for `ls`
Remove-Alias -Name ls
Set-Alias list Get-ChildItem
function ls { eza.exe --long --icons --git --all --header --binary --no-permissions --no-user --mounts --grid --group-directories-first }

# Long listing with groups
function lsl { eza.exe --long --icons --header --all --binary --mounts --group-directories-first --group }

# Tree views
function lt  { eza.exe --tree --icons --all --group-directories-first }
function lt2 { eza.exe --tree --level=2 --icons --all --group-directories-first }
function lt3 { eza.exe --tree --level=3 --icons --all --group-directories-first }
function lt4 { eza.exe --tree --level=4 --icons --all --group-directories-first }
function lt5 { eza.exe --tree --level=5 --icons --all --group-directories-first }

function lg { lazygit.exe }
function n { nvim.exe }
function p { pnpm.exe }
function j { just.exe }
