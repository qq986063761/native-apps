import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

import 'package:flutter_app_demo/providers/posts_provider.dart';
import 'package:flutter_app_demo/providers/theme_mode_provider.dart';
import 'package:flutter_app_demo/router/app_router.dart';
import 'package:flutter_app_demo/services/api_service.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  final api = ApiService();
  runApp(
    MultiProvider(
      providers: [
        Provider<ApiService>.value(value: api),
        ChangeNotifierProvider(create: (_) => ThemeModeProvider()),
        ChangeNotifierProvider(
          create: (c) => PostsProvider(c.read<ApiService>()),
        ),
      ],
      child: const FlutterDemoApp(),
    ),
  );
}

class FlutterDemoApp extends StatefulWidget {
  const FlutterDemoApp({super.key});

  @override
  State<FlutterDemoApp> createState() => _FlutterDemoAppState();
}

class _FlutterDemoAppState extends State<FlutterDemoApp> {
  late final GoRouter _router = AppRouter.create();

  @override
  Widget build(BuildContext context) {
    final themeMode = context.watch<ThemeModeProvider>();
    return MaterialApp.router(
      title: 'Flutter Demo',
      themeMode: themeMode.mode,
      theme: ThemeData(
        colorSchemeSeed: Colors.indigo,
        useMaterial3: true,
        brightness: Brightness.light,
      ),
      darkTheme: ThemeData(
        colorSchemeSeed: Colors.indigo,
        useMaterial3: true,
        brightness: Brightness.dark,
      ),
      routerConfig: _router,
    );
  }
}
