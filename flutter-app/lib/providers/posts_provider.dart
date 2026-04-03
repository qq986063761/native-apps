import 'package:flutter/foundation.dart';
import 'package:flutter_app_demo/models/post.dart';
import 'package:flutter_app_demo/services/api_service.dart';

/// 帖子列表：网络请求 + 加载/错误状态。
class PostsProvider extends ChangeNotifier {
  PostsProvider(this._api);

  final ApiService _api;

  List<Post> _posts = [];
  bool _loading = false;
  String? _error;

  List<Post> get posts => List.unmodifiable(_posts);
  bool get loading => _loading;
  String? get error => _error;

  Future<void> load() async {
    if (_loading) return;
    _loading = true;
    _error = null;
    notifyListeners();
    try {
      _posts = await _api.fetchPosts();
    } catch (e, st) {
      _error = e.toString();
      debugPrintStack(stackTrace: st);
    } finally {
      _loading = false;
      notifyListeners();
    }
  }

  Post? findById(int id) {
    try {
      return _posts.firstWhere((p) => p.id == id);
    } catch (_) {
      return null;
    }
  }
}
