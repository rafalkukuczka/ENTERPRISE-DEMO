<#
.SYNOPSIS
Copies an environment file into the Orders.Api bin directory.

.DESCRIPTION
Copies the selected env file from the repository root, or from an absolute
path, into the built Orders.Api output directory as `.env`.

The script does not build or run the application. Build the API first so the
target bin directory exists.

.PARAMETER Env
Path to the source env file. Relative paths are resolved from the repository
root. Defaults to `.env`.

.PARAMETER Configuration
Build configuration used to locate the application bin directory. Defaults to
`Debug`.

.PARAMETER Framework
Target framework used to locate the application bin directory. Defaults to
`net8.0`.

.EXAMPLE
.\scripts\win\go.ps1

Copies the root `.env` file to `src\Orders.Api\Orders.Api\bin\Debug\net8.0\.env`.

.EXAMPLE
.\scripts\win\go.ps1 -Env ".env.local"

Copies `.env.local` from the repository root to the default Debug bin directory.

.EXAMPLE
.\scripts\win\go.ps1 -Env "D:\secrets\orders.env" -Configuration Release

Copies an absolute env file path to the Release bin directory.
#>

param(
    [string]$Env = ".env",
    [string]$Configuration = "Debug",
    [string]$Framework = "net8.0"
)

$ErrorActionPreference = "Stop"

$scriptDir = Split-Path -Parent $MyInvocation.MyCommand.Path
$rootDir = Resolve-Path (Join-Path $scriptDir "..\..")

if ([System.IO.Path]::IsPathRooted($Env)) {
    $envPath = $Env
} else {
    $envPath = Join-Path $rootDir $Env
}

if (-not (Test-Path -LiteralPath $envPath)) {
    throw "Env file not found: $envPath"
}

$binDir = Join-Path $rootDir "src\Orders.Api\Orders.Api\bin\$Configuration\$Framework"

if (-not (Test-Path -LiteralPath $binDir)) {
    throw "Application bin directory not found: $binDir"
}

Copy-Item -LiteralPath $envPath -Destination (Join-Path $binDir ".env") -Force
Write-Host "Copied env file to $binDir\.env"
