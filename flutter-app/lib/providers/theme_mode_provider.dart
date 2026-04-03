import 'package:flutter/material.dart';

/// 演示用全局 UI 状态（明暗主题切换）。
class ThemeModeProvider extends ChangeNotifier {
  ThemeMode _mode = ThemeMode.system;

  ThemeMode get mode => _mode;

  void toggle() {
    _mode = switch (_mode) {
      ThemeMode.light => ThemeMode.dark,
      ThemeMode.dark => ThemeMode.light,
      ThemeMode.system => ThemeMode.dark,
    };
    notifyListeners();
  }

  void useSystem() {
    _mode = ThemeMode.system;
    notifyListeners();
  }
}
