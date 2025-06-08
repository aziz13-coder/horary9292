@echo off
rem Start both backend and frontend for development

if "%HORARY_CONFIG%"=="" (
    set HORARY_CONFIG=backend\horary_constants.yaml
)

echo Starting backend using %HORARY_CONFIG%
start "Horary Backend" cmd /K "python backend\app.py"

cd frontend
npm run dev
