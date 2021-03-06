﻿function Chocolatey-RubyGem {
param(
  [string] $packageName, 
  [string] $version ='', 
  [string] $installerArguments =''
)

  Chocolatey-InstallIfMissing 'ruby'
  
@"
$h1
Chocolatey ($chocVer) is installing Ruby Gem `'$packageName`' (using RubyGems.org). By installing you accept the license for the package you are installing (please run chocolatey /? for full license acceptance terms).
$h1
"@ | Write-Host
  
  if ($($env:Path).ToLower().Contains("ruby") -eq $false) {
    $env:Path = [Environment]::GetEnvironmentVariable('Path',[System.EnvironmentVariableTarget]::Machine);
  }
  
  $packageArgs = "/c gem install $packageName"
  if ($version -notlike '') {
    $packageArgs = $packageArgs + " -v $version";
  }
  & cmd.exe $packageArgs
  
  if ($installerArguments -ne '') {
    $packageArgs = $packageArgs + " -v $version $installerArguments";
  }

@"
$h1
Chocolatey has finished installing `'$packageName`' - check log for errors.
$h1
"@ | Write-Host
}