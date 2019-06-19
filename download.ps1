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

# Replace TARGET_DIR in unattend.xml.in with our target directory
((Get-Content -path unattend.xml.in -raw) -replace 'TARGET_DIR',$targetdir) | Set-Content -path unattend.xml

Start-Process -FilePath "$target" -ArgumentList "/quiet","/log","$logfile" -Wait
