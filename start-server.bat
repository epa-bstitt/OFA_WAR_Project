@echo off
REM Batch script to start the Next.js server on port 3000
REM Recognize Cloud Foundry CLI at specified path
set CF_CLI="C:\Users\jbeja\AppData\Roaming\Cloud Foundry\cf8.exe"

if exist %CF_CLI% (
    echo Cloud Foundry CLI found at %CF_CLI%.
) else (
    echo Cloud Foundry CLI not found at %CF_CLI%.
)

REM Check if port 3000 is in use
netstat -ano | findstr :3000 >nul
if %ERRORLEVEL%==0 (
    echo Port 3000 is in use. Killing all node.exe processes...
    taskkill /F /IM node.exe
) else (
    echo Port 3000 is free.
)

REM Start the server
npm run dev
