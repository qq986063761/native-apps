const { app, BrowserWindow } = require('electron')

const createWindow = () => {
  // 创建窗口
  const win = new BrowserWindow({
    width: 800,
    height: 600
  })

  win.loadFile('index.html')
}

// 事件
app.on('window-all-closed', () => {
  if (process.platform !== 'darwin') app.quit()
})

// 应用进程准备完毕
app.whenReady().then(() => {
  createWindow()

  // 激活后，如果窗口打开失败，则重新打开
  app.on('activate', () => {
    if (BrowserWindow.getAllWindows().length === 0) createWindow()
  })
})