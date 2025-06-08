const { app, BrowserWindow } = require('electron');
const path = require('path');

function createWindow() {
  const win = new BrowserWindow({
    width: 800,
    height: 600,
    webPreferences: {
      contextIsolation: true,
    }
  });

  const startUrl = process.env.ELECTRON_START_URL || path.join(__dirname, 'dist', 'index.html');
  if (startUrl.startsWith('http')) {
    win.loadURL(startUrl);
  } else {
    win.loadFile(startUrl);
  }
}

app.whenReady().then(createWindow);

app.on('window-all-closed', () => {
  if (process.platform !== 'darwin') {
    app.quit();
  }
});
