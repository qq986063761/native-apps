# Flutter Demo（API · 父子路由 · 状态管理）

本目录为手写工程骨架（含 `lib/` 与 `pubspec.yaml`）。若尚未生成 Android / iOS 等平台目录，请在安装 [Flutter](https://docs.flutter.dev/get-started/install) 后在本目录执行：

```bash
cd /Users/wanpeng/Documents/work/native-apps/flutter-app
flutter create . --project-name flutter_app_demo
flutter pub get
flutter run
```

## 功能说明

| 能力 | 实现方式 |
|------|----------|
| **网络 API** | `http` 请求 [JSONPlaceholder](https://jsonplaceholder.typicode.com) `/posts`，列表展示标题与摘要 |
| **父子路由** | `go_router` 的 `ShellRoute`：父级统一 `Scaffold` + `AppBar`；子级 `/posts` 列表、`/posts/:id` 详情（`context.push` / `pop`） |
| **状态管理** | `provider`：`PostsProvider`（加载中/错误/列表）、`ThemeModeProvider`（明暗主题切换） |

## 目录结构（核心）

- `lib/main.dart` — 入口、`MultiProvider`、`MaterialApp.router`
- `lib/router/app_router.dart` — `ShellRoute` + 嵌套 `GoRoute`
- `lib/services/api_service.dart` — HTTP 封装
- `lib/providers/` — `ChangeNotifier` 状态
- `lib/screens/` — 列表页、详情页

## 依赖

见 `pubspec.yaml`：`http`、`provider`、`go_router`。
