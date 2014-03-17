<# 
 .Synopsis
  The MegaSample-module.

 .Description
  MegaSample-module

 .Example
   # Get the path to SqlMetal.exe. Returns $null if not found.
   Get-SqlMetalBinPath

 .Example
   # Get the path to MSBuild.exe. Returns $null if not found.
   Get-MsBuildBinPath
#>

#
# Finds full path to a file. Returns $null if not found
#
function Get-PathToExe
{
	param(
		[ValidateNotNullOrEmpty()]
		[String]$Path=$(throw "Path must be set in search for file."),

		[ValidateNotNullOrEmpty()]
		[String]$Name=$(throw "Name must be set in search for file.")
	)
	$res = Get-ChildItem -Path $Path -Recurse $Name -ErrorAction SilentlyContinue
	$pathObj = $res | Select-Object -Last 1
	return $pathObj.FullName
}

function Set-EnvToExe
{
	param(
			$Executable=$(throw "Executable missing"),
			$SearchPath=$(throw "Path missing"),
			$EnvVar=$(throw "EnvVar missing")
		)
	$path = Get-Content Env:\$EnvVar -ErrorAction SilentlyContinue
	if($?)
	{
		"Found $Executable @ $path"
	}
	else
	{
	    "Looking for $Executable"
		$path = Get-PathToExe -Path $SearchPath -Name $Executable
		if($path -ne $null)
		{
			[Environment]::SetEnvironmentVariable($EnvVar, $path, "Process")
			"Found $Executable @ $path"
		}
		else 
		{
		    Write-Warning "No $Executable found in $SearchPath skipping..."
		}
	}
}


## TODO: Check if all paths allready are set
#
function Get-MegaSampleToolPaths
{
	Set-EnvToExe -Executable csc.exe -SearchPath C:\Windows\Microsoft.NET -EnvVar CscBinPath
	Set-EnvToExe -Executable msbuild.exe -SearchPath C:\Windows\Microsoft.NET -EnvVar MsBuildBinPath
	Set-EnvToExe -Executable SqlMetal.Exe -SearchPath C:\Progra* -EnvVar SqlMetalBinPath	
	Set-EnvToExe -Executable node.exe -SearchPath C:\Progra* -EnvVar NodeBinPath
	Set-EnvToExe -Executable node.exe -SearchPath C:\Node -EnvVar NodeBinPath
	Set-EnvToExe -Executable npm.cmd -SearchPath C:\Progra* -EnvVar NpmBinPath
	Set-EnvToExe -Executable npm.cmd -SearchPath C:\Node* -EnvVar NpmBinPath
}

Export-ModuleMember -Function Get-MegaSampleToolPaths

