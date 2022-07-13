import 'dart:convert';
import 'dart:io';

import 'package:http_request/domain/entity/post.dart';

class ApiClient {
  final client = HttpClient();

  Future<List<Post>> getPosts() async {
    final json = await getJson('https://jsonplaceholder.typicode.com/posts');

    final posts = json
        .map((dynamic e) => Post.fromJson(e as Map<String, dynamic>))
        .toList();
    return posts;
  }

  Future<List<dynamic>> getJson(String urlJson) async {
    final url = Uri.parse(urlJson);
    final request = await client.getUrl(url);
    final response = await request.close();

    final jsonStrings = await response.transform(utf8.decoder).toList();
    final jsonString = jsonStrings.join();
    final json = jsonDecode(jsonString) as List<dynamic>;
    return json;
  }

  Future<Post> createPost({
    required String title,
    required String body
  }) async {
    Map<String, dynamic> json = await getJsonForCreate(title, body);
    final post = Post.fromJson(json);
    return post;
  }

  Future<Map<String, dynamic>> getJsonForCreate(String title, String body) async {
    final url = Uri.parse('https://jsonplaceholder.typicode.com/posts');
    final parameters = <String, dynamic> {
      'title': title,
      'body': body,
      'userId': 333
    };
    final request = await client.postUrl(url);
    request.headers.set('Content-type', 'application/json; charset=UTF-8');
    request.write(jsonEncode(parameters));
    final response = await request.close();
    final jsonStrings = await response.transform(utf8.decoder).toList();
    final jsonString = jsonStrings.join();
    final json = jsonDecode(jsonString) as Map<String, dynamic>;
    return json;
  }
}
