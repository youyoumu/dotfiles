$device = (Get-AudioDevice -Playback).Name

if ($device -eq "Digital Audio (S/PDIF) (2- High Definition Audio Device)")
{
  Write-Output "Samsung Soundbar"
} elseif ($device -eq "1 - Mi Monitor (2- AMD High Definition Audio Device)")
{
  Write-Output "Xiomi Monitor"
} else
{
  Write-Output $device
}
