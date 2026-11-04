@echo off
rem HalalTown: start the server using the existing roguetown.dmb (no compile).
rem Options: -Port 1338, -NoInit (instant start without subsystem initialization)
powershell -NoProfile -ExecutionPolicy Bypass -File "%~dp0tools\fastbuild.ps1" serve %*
exit /b %ERRORLEVEL%
