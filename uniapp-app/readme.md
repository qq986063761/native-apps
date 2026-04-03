# uni-app Vue3 Demo

Vue3 + Vite + Pinia，演示 uni API、路由跳转、分包父子页、全局状态。

## 安装与运行

```bash
cd uniapp-app
npm install
npm run dev:h5
```

浏览器打开终端提示的本地地址。微信小程序：`npm run dev:mp-weixin`，用微信开发者工具导入 `dist/dev/mp-weixin`。

## 功能说明

| 页面 | 说明 |
|------|------|
| `pages/index/index` | 首页入口，展示 Pinia 摘要 |
| `pages/api-demo/index` | Toast / Modal / Loading、Storage、系统信息、返回 |
| `pages/store-demo/index` | Pinia 计数与昵称（昵称写入 `uni.setStorageSync`） |
| `pages/nested/*` | 分包：父页 → 子页 A/B，`navigateTo` / `navigateBack` / `reLaunch` |

## 技术栈

- [uni-app](https://uniapp.dcloud.net.cn/)（Vue3 + Vite）
- [Pinia](https://pinia.vuejs.org/) 状态管理
