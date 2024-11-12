const { app, BrowserWindow } = require('electron')

const createWindow = () => {
  // 创建窗口
  const win = new BrowserWindow({
    width: 800,
    height: 600
  })

  win.loadFile('index.html')
}

app.whenReady().then(createWindow)