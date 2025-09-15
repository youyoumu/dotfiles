# Define audio device mappings per host
$devices = @{
  "chocola-swimsuit" = @(
    "Digital Audio (S/PDIF) (2- High Definition Audio Device)",
    "Headphones (Arctis 5 Game)",
    "1 - Mi Monitor (2- AMD High Definition Audio Device)"
  )
}

# Get current hostname
$hostname = (hostname)

# Check if hostname exists in mapping
if (-not $devices.ContainsKey($hostname))
{
  Write-Error "No audio device mapping defined for host: $hostname"
  exit 1
}

# Get the list of devices for this host
$deviceList = $devices[$hostname]

# Get current playback device
$Audio = Get-AudioDevice -Playback
Write-Output "Audio device was: $($Audio.Name)"

# Find current device index in the list
$currentIndex = -1
for ($i = 0; $i -lt $deviceList.Count; $i++)
{
  if ($Audio.Name.StartsWith($deviceList[$i]))
  {
    $currentIndex = $i
    break
  }
}

if ($currentIndex -eq -1)
{
  Write-Warning "Current device not found in mapping. Defaulting to first device."
  $nextIndex = 0
} else
{
  # Cycle to next index
  $nextIndex = ($currentIndex + 1) % $deviceList.Count
}

$nextDevice = $deviceList[$nextIndex]
Write-Output "Audio device now set to: $nextDevice"

(Get-AudioDevice -List | Where-Object Name -like ("$nextDevice*") | Set-AudioDevice).Name

