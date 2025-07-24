# song_detector.ps1
$scriptFolder = $PSScriptRoot
$outputFile = "$scriptFolder\current_song.txt"
$ugRegex = '(?:\(\d+\)\s*)?(.+?)\s*CHORDS(?:\s*\(ver\s*\d+\))?\s*by\s*(.+?)(?:\s*@|$)'

function Convert-ToTitleCase {
    param([string]$text)
    $textInfo = (Get-Culture).TextInfo
    return $textInfo.ToTitleCase($text.ToLower())
}

Set-Content -Path $outputFile -Value "No song detected"
Write-Host "Song detector started (Watching Zen Browser)"
Write-Host "Output file: $outputFile"
Write-Host "Press Ctrl+C to stop"

while ($true) {
    try {
        # Zen Browser-specific detection
        $zenProcess = Get-Process -Name "zen" -ErrorAction SilentlyContinue | 
                      Where-Object { $_.MainWindowTitle -ne "" }
        
        if ($zenProcess) {
            $windowTitle = $zenProcess.MainWindowTitle
            
            if ($windowTitle -match $ugRegex) {
                $song = Convert-ToTitleCase $matches[1].Trim()
                $artist = Convert-ToTitleCase $matches[2].Trim()
                $displayText = """$song"" by $artist"
                Set-Content -Path $outputFile -Value $displayText
                Write-Host "Detected: $displayText" -ForegroundColor Green
            }
            else {
                Set-Content -Path $outputFile -Value "No song detected"
                Write-Host "Waiting for song tab..." -ForegroundColor Yellow
            }
        }
        else {
            Set-Content -Path $outputFile -Value "Zen Browser not focused"
            Write-Host "Zen Browser window not found" -ForegroundColor Yellow
        }
    }
    catch {
        Write-Host "Error: $_" -ForegroundColor Red
        Set-Content -Path $outputFile -Value "Error detecting song"
    }
    
    Start-Sleep -Seconds 3
}