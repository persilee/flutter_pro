import 'package:flutter/material.dart';
import 'package:pro_flutter/http/api_client.dart';
import 'package:pro_flutter/models/post_model.dart';

class PostsViewModel with ChangeNotifier {
  Future<void> getPosts() async {
    try {
      PostModel posts = await ApiClient().getPosts('1', '6');
    } catch (e) {
      print(e);
    }
  }
}
