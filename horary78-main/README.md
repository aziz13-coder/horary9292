# Horary App Docker Instructions

This repository contains the backend and frontend for the Horary astrology application. The project structure was simplified so the backend now lives in the `backend/` directory and the frontend in `frontend/`. A `Dockerfile` is provided to build a container that bundles both parts and serves the API via Gunicorn.

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

## Local Development on Windows

Before running the application manually make sure the following software is installed:

- **Python 3.10+** (available in your `PATH`)
- **Node.js 16+** with npm

The backend reads optional environment variables:

- `HORARY_CONFIG` – path to a custom `horary_constants.yaml`. Defaults to the
  file in `backend/`.
- `HORARY_DISABLE_AUTO_LOGGING` – set to `true` to disable startup logging.
- `HORARY_CONFIG_SKIP_VALIDATION` – set to `true` to skip validation at start.

### Start the Backend

From the repository root run:

```bash
cd backend
python app.py
```

The API will be available on `http://localhost:5000`.

### Start the Frontend

Open a second terminal and run:

```bash
cd frontend
npm install      # only once
npm run dev
```

This launches the Vite development server. If you have packaged the frontend
with Electron you can run that executable instead.

### start.bat

A convenient `start.bat` script is included at the project root to launch both
services. Double-click it or run it from a command prompt to start the backend
and frontend together.
