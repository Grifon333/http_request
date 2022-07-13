import 'dart:convert';
import 'dart:io';

import 'package:http_request/domain/entity/post.dart';

class ApiClient {
  final client = HttpClient();

  Future<List<dynamic>> getPosts() async {
    final json = await getJson('https://jsonplaceholder.typicode.com/posts');

    final posts = json
        .map((dynamic e) => Post.fromJson(e))
        .toList();
    return posts;
  }

  Future<dynamic> getJson(String urlJson) async {
    final url = Uri.parse(urlJson);
    final request = await client.getUrl(url);
    final response = await request.close();

    final jsonStrings = await response.transform(utf8.decoder).toList();
    final jsonString = jsonStrings.join();
    final json = jsonDecode(jsonString);
    return json;
  }
}