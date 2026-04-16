@echo off
REM Add this file's directory to the PATH for the session
set "CF_CLI_PATH=C:\Users\jbeja\AppData\Roaming\Cloud Foundry"
set "PATH=%CF_CLI_PATH%;%PATH%"

echo Cloud Foundry CLI path added to PATH for this session.

echo You can now run: cf login

echo To make this permanent, add the above directory to your system PATH environment variable.
