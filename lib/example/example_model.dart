import 'package:flutter/material.dart';
import 'package:http_request/domain/api_clients/api_client.dart';
import 'package:http_request/domain/entity/post.dart';

class ExampleWidgetModel extends ChangeNotifier {
  final apiClient = ApiClient();
  var _posts = const <Post>[];

  List<Post> get posts => _posts;

  Future<void> reloadPosts() async {
    final posts = await apiClient.getPosts();
    _posts += posts;
    notifyListeners();
  }

  void createPosts() async {
    final posts = await apiClient.createPost(
        title: 'Biography',
        body: 'I am is a great programmer'
    );
  }
}

class ExampleModelProvider extends InheritedNotifier {
  final ExampleWidgetModel model;

  const ExampleModelProvider({
    Key? key,
    required this.model,
    required Widget child,
  }) : super(key: key, notifier: model, child: child);

  static ExampleModelProvider? watch(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<ExampleModelProvider>();
  }

  static ExampleModelProvider? read(BuildContext context) {
    final widget = context
        .getElementForInheritedWidgetOfExactType<ExampleModelProvider>()
        ?.widget;
    return widget is ExampleModelProvider ? widget : null;
  }
}
