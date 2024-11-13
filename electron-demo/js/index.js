
let js = document.createElement('script')
js.src = './lib/vconsole.min.js'
js.onload = () => {
  new window.VConsole()
}

document.body.appendChild(js)