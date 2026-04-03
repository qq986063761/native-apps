import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

import 'package:flutter_app_demo/providers/posts_provider.dart';
import 'package:flutter_app_demo/screens/post_detail_screen.dart';
import 'package:flutter_app_demo/screens/posts_list_screen.dart';

/// 父路由：带统一 Scaffold（AppBar）；子路由：列表 `/posts`、详情 `/posts/:id`（父子嵌套）。
class AppRouter {
  AppRouter._();

  static GoRouter create() {
    return GoRouter(
      initialLocation: '/posts',
      routes: [
        ShellRoute(
          builder: (context, state, child) => _PostsShell(child: child),
          routes: [
            GoRoute(
              path: '/posts',
              pageBuilder: (context, state) => NoTransitionPage<void>(
                key: state.pageKey,
                child: const PostsListScreen(),
              ),
              routes: [
                GoRoute(
                  path: ':id',
                  pageBuilder: (context, state) {
                    final idStr = state.pathParameters['id']!;
                    final id = int.tryParse(idStr) ?? 0;
                    return MaterialPage<void>(
                      key: state.pageKey,
                      child: PostDetailScreen(postId: id),
                    );
                  },
                ),
              ],
            ),
          ],
        ),
      ],
    );
  }
}

class _PostsShell extends StatelessWidget {
  const _PostsShell({required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    final posts = context.watch<PostsProvider>();
    return Scaffold(
      appBar: AppBar(
        title: const Text('Flutter Demo'),
        actions: [
          if (posts.loading)
            const Padding(
              padding: EdgeInsets.only(right: 16),
              child: Center(
                child: SizedBox(
                  width: 22,
                  height: 22,
                  child: CircularProgressIndicator(strokeWidth: 2),
                ),
              ),
            ),
        ],
      ),
      body: child,
    );
  }
}
