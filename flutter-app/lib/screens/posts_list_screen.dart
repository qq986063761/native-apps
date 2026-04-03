import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

import 'package:flutter_app_demo/providers/posts_provider.dart';
import 'package:flutter_app_demo/providers/theme_mode_provider.dart';

class PostsListScreen extends StatefulWidget {
  const PostsListScreen({super.key});

  @override
  State<PostsListScreen> createState() => _PostsListScreenState();
}

class _PostsListScreenState extends State<PostsListScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<PostsProvider>().load();
    });
  }

  @override
  Widget build(BuildContext context) {
    final posts = context.watch<PostsProvider>();
    final themeMode = context.watch<ThemeModeProvider>();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(16, 8, 16, 8),
          child: Row(
            children: [
              const Expanded(
                child: Text(
                  'JSONPlaceholder 帖子（点击进子页）',
                  style: TextStyle(fontWeight: FontWeight.w600),
                ),
              ),
              IconButton(
                tooltip: '切换明暗主题（Provider）',
                onPressed: () => themeMode.toggle(),
                icon: Icon(
                  Theme.of(context).brightness == Brightness.dark
                      ? Icons.light_mode
                      : Icons.dark_mode,
                ),
              ),
            ],
          ),
        ),
        if (posts.error != null)
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: MaterialBanner(
              content: Text('加载失败：${posts.error}'),
              actions: [
                TextButton(
                  onPressed: () => posts.load(),
                  child: const Text('重试'),
                ),
              ],
            ),
          ),
        Expanded(
          child: posts.loading && posts.posts.isEmpty
              ? const Center(child: CircularProgressIndicator())
              : ListView.builder(
                  padding: const EdgeInsets.only(bottom: 24),
                  itemCount: posts.posts.length,
                  itemBuilder: (context, index) {
                    final p = posts.posts[index];
                    return ListTile(
                      leading: CircleAvatar(child: Text('${p.id}')),
                      title: Text(
                        p.title,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                      subtitle: Text(
                        p.body,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                      onTap: () => context.push('/posts/${p.id}'),
                    );
                  },
                ),
        ),
      ],
    );
  }
}
