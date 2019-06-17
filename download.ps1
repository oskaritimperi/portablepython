# https://www.python.org/ftp/python/3.7.3/python-3.7.3-amd64.exe
# https://www.python.org/ftp/python/3.7.3/python-3.7.3.exe
# https://www.python.org/ftp/python/3.5.1/python-3.5.1-amd64.exe.asc

# https://www.python.org/ftp/python/3.5.1/python-3.5.1-amd64.exe
# https://www.python.org/ftp/python/3.5.1/python-3.5.1.exe
# https://www.python.org/ftp/python/3.5.1/python-3.5.1.exe.asc

if ($env:PYARCH -eq "amd64") {
    $filename = "python-${env:PYVERSION}-amd64.exe"
    $arch = "64"
} else {
    $filename = "python-${env:PYVERSION}.exe"
    $arch = "32"
}

$url = "https://www.python.org/ftp/python/${env:PYVERSION}/${filename}"
$target = $PSScriptRoot + "\" + $filename
$targetdir = $PSScriptRoot + "\Python-${env:PYVERSION}-${arch}"
$logfile = $PSScriptRoot + "\install.log"

Write-Output "URL: $url"
Write-Output "Target: $target"
Write-Output "Target dir: $targetdir"
Write-Output "Log file: $logfile"

# $client = New-Object System.Net.WebClient
# $client.DownloadFile($url, $target)

# ((Get-Content -path unattend.xml.in -raw) -replace 'TARGET_DIR',$targetdir) | Set-Content -path unattend.xml

# & "$target" /quiet /log "$logfile"

Start-Process -FilePath "$target" -ArgumentList "/quiet","/log","$logfile" -Wait
