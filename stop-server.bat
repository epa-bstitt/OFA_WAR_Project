@echo off
REM Batch script to stop all node servers (Next.js)

REM Recognize Cloud Foundry CLI at specified path
set CF_CLI="C:\Users\jbeja\AppData\Roaming\Cloud Foundry\cf8.exe"

if exist %CF_CLI% (
	echo Cloud Foundry CLI found at %CF_CLI%.
) else (
	echo Cloud Foundry CLI not found at %CF_CLI%.
)

echo Stopping all node.exe processes...
taskkill /F /IM node.exe
