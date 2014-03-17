
$invocationPath = Split-Path $MyInvocation.MyCommand.Path


Write-Host "Checking prereqs..."
Import-Module .\PowerShell\MegaSample.psm1
Get-MegaSampleToolPaths

Write-Host "Clean up..."
Remove-Item (Join-Path $invocationPath Temp\* )
Remove-Item (Join-Path $invocationPath CSharp\Temp\* )


Write-Host "Build..."
cd (Join-Path $invocationPath CSharp )
& (Get-Content Env:\MSBuildBinPath)

Write-Host "Executing..."
.\MegaSample.exe



Remove-Module MegaSample

cd $invocationPath
