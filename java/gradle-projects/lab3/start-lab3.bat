@echo off
setlocal
chcp 65001 >nul
cd /d "%~dp0"
if not defined SERVER_PORT set SERVER_PORT=8083
if not exist "build\libs\raspisa-lab3.jar" (
    call gradlew.bat bootJar --console=plain
    if errorlevel 1 (
        pause
        exit /b 1
    )
)
echo.
echo Откройте http://localhost:%SERVER_PORT%/login
echo Для остановки нажмите Ctrl+C
echo.
java -jar "build\libs\raspisa-lab3.jar"
if errorlevel 1 pause
