<#
HalalTown fast build / run helper.

  BUILD.bat              fast build, skips compiling when sources are unchanged
  BUILD.bat force        fast build, always recompile
  BUILD.bat full         full release build (DEBUG + full map), always recompile
  BUILD.bat run          fast build, then start the server
  BUILD.bat help         show this help
  RUN.bat                start the server using the existing .dmb, no compile
  RUN.bat -NoInit        start without subsystem initialization (instant)
  RUN.bat -Port 1338     start on another port
  RUN.bat -MapThreads 4  override map loading threads (0 = BYOND default)

Fast build uses -DFASTBUILD: no DEBUG mode, PRELOAD_RSC 1, low-memory
initialization and the small Roguetest map. The full build is unchanged.
#>
[CmdletBinding()]
param(
    [Parameter(Position = 0)]
    [ValidateSet('fast', 'force', 'full', 'run', 'serve', 'help')]
    [string]$Mode = 'fast',
    [int]$Port = 1337,
    [int]$MapThreads = -1,
    [switch]$NoInit
)

$ErrorActionPreference = 'Stop'
$root = Split-Path -Parent $PSScriptRoot
$dme = 'roguetown.dme'
$dmb = 'roguetown.dmb'
$marker = Join-Path $root 'tmp\.build-mode'
$sourceDirs = @('code', '_maps', 'icons', 'sound', 'html', 'interface',
                'strings', 'goon', 'config', 'tgui', 'tgui-next')

function Show-Help {
    Write-Host @'
HalalTown build helper
  BUILD.bat           fast build (skip compile if sources are unchanged)
  BUILD.bat force     fast build, force recompile
  BUILD.bat full      full release build (DEBUG + full map)
  BUILD.bat run       fast build + start server
  RUN.bat             start server only (existing .dmb)
  RUN.bat -NoInit     instant start without subsystem initialization
  RUN.bat -Port 1338  custom port
  RUN.bat -MapThreads 4  override map threads (0 = BYOND default)
'@
}

function Resolve-ByondBin {
    $cmd = Get-Command 'dm.exe' -ErrorAction SilentlyContinue
    if ($cmd) { return (Split-Path -Parent $cmd.Source) }
    $candidates = @(
        (Join-Path ${env:ProgramFiles(x86)} 'BYOND\bin'),
        (Join-Path $env:ProgramFiles 'BYOND\bin'),
        (Join-Path $env:LOCALAPPDATA 'Programs\BYOND\bin'),
        (Join-Path $env:USERPROFILE 'BYOND\bin')
    )
    foreach ($dir in $candidates) {
        if ($dir -and (Test-Path (Join-Path $dir 'dm.exe'))) { return $dir }
    }
    throw "BYOND (dm.exe) not found. Install BYOND or add its bin folder to PATH."
}

function Test-SourceChanged {
    if (-not (Test-Path (Join-Path $root $dmb))) { return $true }
    $dmbTime = (Get-Item (Join-Path $root $dmb)).LastWriteTimeUtc
    $files = @()
    foreach ($dir in $sourceDirs) {
        $full = Join-Path $root $dir
        if (Test-Path $full) {
            $files += Get-ChildItem -LiteralPath $full -Recurse -File -ErrorAction SilentlyContinue
        }
    }
    $files += Get-Item (Join-Path $root $dme)
    $ignored = @('.dmb', '.rsc', '.lk', '.log', '.sav', '.pyc', '.int', '.zip', '.dmi.bak')
    $files = $files | Where-Object {
        $_.Extension -notin $ignored -and $_.FullName -notmatch '\\(node_modules|__pycache__)\\'
    }
    $newest = ($files | Measure-Object -Property LastWriteTimeUtc -Maximum).Maximum
    return ($null -ne $newest -and $newest -gt $dmbTime)
}

if ($Mode -eq 'help') { Show-Help; exit 0 }

Push-Location $root
try {
    $bin = Resolve-ByondBin
    $dm = Join-Path $bin 'dm.exe'
    $dd = Join-Path $bin 'dd.exe'

    $targetMode = if ($Mode -eq 'full') { 'full' } else { 'fast' }
    $savedMode = ''
    if (Test-Path $marker) { $savedMode = (Get-Content -LiteralPath $marker -Raw).Trim() }

    $wantServer = ($Mode -eq 'run' -or $Mode -eq 'serve')
    $needBuild = $false
    if ($Mode -ne 'serve') {
        $needBuild = ($Mode -eq 'force') -or ($Mode -eq 'full') -or
                     ($savedMode -ne $targetMode) -or (Test-SourceChanged)
    }

    if ($needBuild) {
        $args = @()
        if ($targetMode -eq 'fast') { $args += '-DFASTBUILD' }
        $args += $dme
        Write-Host "== Compiling roguetown.dme [$targetMode] ==" -ForegroundColor Cyan
        $sw = [System.Diagnostics.Stopwatch]::StartNew()
        $output = & $dm @args 2>&1
        $sw.Stop()
        $output | ForEach-Object { Write-Host $_ }
        $text = $output | Out-String
        if ($text -match '[1-9][0-9]*\s+errors?') {
            throw "Compilation failed with errors. See output above."
        }
        if ($LASTEXITCODE -and $LASTEXITCODE -ne 0) {
            throw "dm.exe exited with code $LASTEXITCODE."
        }
        if (-not (Test-Path (Join-Path $root $dmb))) {
            throw "roguetown.dmb was not produced."
        }
        Write-Host ("Compile time: {0:N1} s" -f $sw.Elapsed.TotalSeconds) -ForegroundColor Green
        if (-not (Test-Path (Join-Path $root 'tmp'))) {
            New-Item -ItemType Directory -Path (Join-Path $root 'tmp') | Out-Null
        }
        Set-Content -LiteralPath $marker -Value $targetMode -NoNewline -Encoding ASCII
    }
    else {
        Write-Host "== Sources unchanged: using existing roguetown.dmb (compile skipped) ==" -ForegroundColor Green
    }

    if ($wantServer) {
        if (-not (Test-Path (Join-Path $root $dmb))) {
            throw "roguetown.dmb is missing. Run BUILD.bat first."
        }
        if (-not (Test-Path $dd)) {
            throw "dd.exe (DreamDaemon console) not found in $bin."
        }
        $activeMode = if ($needBuild) { $targetMode } else { $savedMode }
        $threads = $MapThreads
        if ($threads -lt 0) {
            # Map threading helps on the small dev map, but measurably slows
            # initialization on the full map (122 s vs 100 s in local tests).
            $threads = if ($activeMode -eq 'full') { 0 } else { [Environment]::ProcessorCount }
        }
        $params = 'log-directory=fastbuild'
        if ($NoInit) { $params += '&no-init=1' }
        $ddArgs = @($dmb, "$Port", '-trusted', '-safe', '-invisible', '-verbose')
        if ($threads -gt 0) { $ddArgs += @('-map-threads', "$threads") }
        $ddArgs += @('-params', $params)
        Write-Host "== Starting DreamDaemon on port $Port (mode $activeMode, map-threads $threads) ==" -ForegroundColor Cyan
        Write-Host ("   dd.exe " + ($ddArgs -join ' ')) -ForegroundColor DarkGray
        Write-Host "   Press Ctrl+C to stop the server." -ForegroundColor DarkGray
        & $dd @ddArgs
    }
}
finally {
    Pop-Location
}
