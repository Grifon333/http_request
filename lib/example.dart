import 'package:flutter/material.dart';
import 'package:http_request/domain/api_clients/api_client.dart';

class Example extends StatelessWidget {
  const Example({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    ApiClient().getPosts();
    return const Scaffold();
  }
}
