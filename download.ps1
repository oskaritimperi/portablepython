# https://www.python.org/ftp/python/3.7.3/python-3.7.3-amd64.exe
# https://www.python.org/ftp/python/3.7.3/python-3.7.3.exe
# https://www.python.org/ftp/python/3.5.1/python-3.5.1-amd64.exe.asc

# https://www.python.org/ftp/python/3.5.1/python-3.5.1-amd64.exe
# https://www.python.org/ftp/python/3.5.1/python-3.5.1.exe
# https://www.python.org/ftp/python/3.5.1/python-3.5.1.exe.asc

if ($env:PYARCH -eq "64") {
    $filename = "python-${env:PYVERSION}-amd64.exe"
} else {
    $filename = "python-${env:PYVERSION}.exe"
}

$url = "https://www.python.org/ftp/python/${env:PYVERSION}/${filename}"
$target = $PSScriptRoot + "\" + $filename
$targetdir = $PSScriptRoot + "\Python-${env:PYVERSION}-${env:PYARCH}"
$logfile = $PSScriptRoot + "\install.log"

Write-Output "URL: $url"
Write-Output "Target: $target"
Write-Output "Target dir: $targetdir"
Write-Output "Log file: $logfile"

$client = New-Object System.Net.WebClient
$client.DownloadFile($url, $target)

((Get-Content -path unattend.xml.in -raw) -replace 'TARGET_DIR',$targetdir) | Set-Content -path unattend.xml

if (Test-Path env:CI) {
    Remove-Item -Force -Recurse HKCU:\Software\Python
    Remove-Item -Force -Recurse HKLM:\Software\Python
    Remove-Item -Force -Recurse HKLM:\Software\Wow6432Node\Python
}

Start-Process -FilePath "$target" -ArgumentList "/quiet","/log","$logfile" -Wait
