if ($env:PYVERSION -like "3.*") {
    if ($env:PYARCH -eq "64") {
        $filename = "python-${env:PYVERSION}-amd64.exe"
    } else {
        $filename = "python-${env:PYVERSION}.exe"
    }
} else {
    if ($env:PYARCH -eq "64") {
        $filename = "python-${env:PYVERSION}.amd64.msi"
    } else {
        $filename = "python-${env:PYVERSION}.msi"
    }
}

$url = "https://www.python.org/ftp/python/${env:PYVERSION}/${filename}"
$target = $PSScriptRoot + "\" + $filename
$targetdir = $PSScriptRoot + "\Python-${env:PYVERSION}-${env:PYARCH}"
$logfile = $PSScriptRoot + "\install.log"

Write-Output "URL: $url"
Write-Output "Target: $target"
Write-Output "Target dir: $targetdir"
Write-Output "Log file: $logfile"

Write-Output "Downloading $url"
$client = New-Object System.Net.WebClient
$client.DownloadFile($url, $target)

if ($env:PYVERSION -like "3.*") {
    # Replace TARGET_DIR in unattend.xml.in with our target directory
    ((Get-Content -path unattend.xml.in -raw) -replace 'TARGET_DIR',$targetdir) | Set-Content -path unattend.xml

    Write-Output "Installing Python to $targetdir"
    Start-Process -FilePath "$target" -ArgumentList "/quiet","/log","$logfile" -Wait

    # Remove all __pycache__ directories
    Write-Output "Removing __pycache__ directories"
    Get-ChildItem -Include __pycache__ -Recurse -Force | Remove-Item -Force -Recurse
} else {
    Write-Output "Removing existing Python installation if there is one"
    Start-Process -FilePath msiexec -ArgumentList "/qn","/x","$target" -Wait
    
    Write-Output "Installing Python to $targetdir"
    Start-Process -FilePath msiexec -ArgumentList "/qn","/i","$target","/L*V","$logfile","TARGETDIR=$targetdir","ADDLOCAL=DefaultFeature,TclTk,Documentation,Tools","REMOVE=Extensions,Testsuite" -Wait
    
    Write-Output "Removing .pyc files"
    Get-ChildItem -Include "*.pyc" -Recurse -Force | Remove-Item -Force
}

if (Test-Path $targetdir\Scripts) {
    Write-Output "Removing $targetdir\Scripts"
    Remove-Item -Recurse -Force $targetdir\Scripts
}
