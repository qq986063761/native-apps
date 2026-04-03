import 'dart:convert';

import 'package:flutter_app_demo/models/post.dart';
import 'package:http/http.dart' as http;

/// 使用 JSONPlaceholder 作为公开演示 API。
class ApiService {
  ApiService({http.Client? client}) : _client = client ?? http.Client();

  static const _base = 'https://jsonplaceholder.typicode.com';
  final http.Client _client;

  Future<List<Post>> fetchPosts({int limit = 20}) async {
    final uri = Uri.parse('$_base/posts?_limit=$limit');
    final response = await _client.get(uri);
    if (response.statusCode != 200) {
      throw ApiException(response.statusCode, response.body);
    }
    final list = jsonDecode(response.body) as List<dynamic>;
    return list.map((e) => Post.fromJson(e as Map<String, dynamic>)).toList();
  }

  Future<Post> fetchPost(int id) async {
    final uri = Uri.parse('$_base/posts/$id');
    final response = await _client.get(uri);
    if (response.statusCode != 200) {
      throw ApiException(response.statusCode, response.body);
    }
    final map = jsonDecode(response.body) as Map<String, dynamic>;
    return Post.fromJson(map);
  }
}

class ApiException implements Exception {
  ApiException(this.statusCode, this.body);
  final int statusCode;
  final String body;

  @override
  String toString() => 'ApiException($statusCode): $body';
}
