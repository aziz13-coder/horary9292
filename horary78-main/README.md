# Horary App Docker Instructions

This repository contains the backend and frontend for the Horary astrology application. The project structure was simplified so the backend now lives in the `backend/` directory and the frontend in `frontend/`. A `Dockerfile` is provided to build a container that bundles both parts and serves the API via Gunicorn.

## Install Dependencies

For local development, install the Python packages using the requirements file in the backend directory:

```bash
pip install -r backend/requirements.txt
```
The requirements file lists core packages like Flask and now includes
`watchdog>=3.0.0` for file change monitoring.

## Build the Image

From the repository root run:

```bash
docker build -t horary-app .
```

## Run the Container

After building the image, start the application with:

```bash
docker run -p 5000:5000 horary-app
```

The API will be available on `http://localhost:5000`.

## Local Start Scripts

If you prefer to run the backend directly instead of using Docker, two helper
scripts are provided. On Unix systems run `start.sh`:

```bash
./start.sh
```

Windows users can start the API with `start.bat`:

```bat
start.bat
```

Both scripts expect the `PORT` environment variable to be defined and will
install Python dependencies on first run if they are not already cached.

## Windows Packaging

If you want to distribute the application through the Microsoft Store you can
wrap the backend executable and built frontend into an `.appx` package.

1. **Build the executable**

   Use PyInstaller to generate a standalone binary:

   ```bash
   pyinstaller --onefile backend/app.py
   ```

   The resulting `app.exe` will be placed in the `dist/` directory.

2. **Create the `.appx` package**

   After building the frontend (e.g. `npm run build`), use Microsoft's MSIX
   Packaging Tool or `makeappx.exe` to combine `dist/app.exe` and the frontend
   `dist/` folder into a single `.appx` file.

3. **Sign and upload**

   Sign the package with your code signing certificate and submit it to the
   Microsoft Store for distribution.

## Electron Desktop App

An Electron wrapper can be used to run the built frontend as a desktop
application.

1. Install dependencies:

   ```bash
   cd frontend && npm install
   ```

2. Start Electron in development mode which runs the Vite dev server and
   launches Electron once the server is ready:

   ```bash
   npm run electron:dev
   ```

3. Build a distributable desktop package:

   ```bash
   npm run electron:build
   ```

The resulting binaries will be placed in `frontend/dist` and packaged by
`electron-builder`.
