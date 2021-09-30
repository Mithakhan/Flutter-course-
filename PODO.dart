import 'package:http/http.dart';

class PostList {
  final List<Post>? posts;

  PostList({this.posts});
  factory PostList.fromJson(List<dynamic> parsedJson) {
    List<Post> posts = <Post>[];
    posts = parsedJson.map((e) => Post.fromJson(e)).toList();
    return new PostList(posts: posts);
  }
}

class Post {
  int? id;
  int? userId;
  String? title;
  String? body;
  Post({
    this.id,
    this.userId,
    this.title,
    this.body,
  });
  factory Post.fromJson(Map<String, dynamic> json) {
    return Post(
        id: json['id'],
        userId: json['userId'],
        title: json['title'],
        body: json['body']);
  }
}
