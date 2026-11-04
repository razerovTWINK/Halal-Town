@echo off
rem HalalTown build helper. Run "BUILD.bat help" for usage.
powershell -NoProfile -ExecutionPolicy Bypass -File "%~dp0tools\fastbuild.ps1" %*
exit /b %ERRORLEVEL%
