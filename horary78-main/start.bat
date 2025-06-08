@echo off
rem Render start script for Windows
set PORT=%PORT%

echo Starting Horary Astrology API on port %PORT%

if not exist "C:\opt\render\project\.venv" (
    echo Installing dependencies...
    pip install -r backend\requirements.txt
)

call gunicorn wsgi:application ^
    --bind 0.0.0.0:%PORT% ^
    --workers 1 ^
    --timeout 120 ^
    --access-logfile - ^
    --error-logfile -
