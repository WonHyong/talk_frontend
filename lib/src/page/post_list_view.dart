import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:lotalk_frontend/src/api/api_boards.dart';

import 'package:lotalk_frontend/src/model/post.dart';

class PostListView extends StatefulWidget {
  const PostListView({Key? key}) : super(key: key);

  @override
  _PostListViewState createState() => _PostListViewState();
}

class _PostListViewState extends State<PostListView> {
  late BoardClient client;
  Dio dio = Dio();

  @override
  void initState() {
    super.initState();
    client = BoardClient(dio);
  }

  postCard({
    required Post post,
  }) {
    return Card(
      child: Column(
        children: [
          Text(post.title),
        ]),
    );
  }

  @override
  Widget build(BuildContext context) {
    const token = "eyJhbGciOiJIUzUxMiJ9.eyJzdWIiOiJBRE1JTiIsInJvbGUiOiJBRE1JTiIsImlkIjoiMSIsImlhdCI6MTcwNjAxNjE2OSwiZXhwIjoxNzA2MDE5MTY5fQ.1ZD8YnVXVRAjFEQpXDNjm3FGbIxYPDHOHIsKvwU-fZKU8UlpB5rSLETqYN-C0msoDSRmp-KK82-Jopt5ZapvDQ";
    return Scaffold(
      appBar: AppBar(
        title: const Text('ALL POSTS'),
      ),
      body: FutureBuilder(
        future: client.getAllPosts(token),
        initialData: [],
        builder: (_, AsyncSnapshot snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          List<Post> posts = snapshot.data.content;
          return ListView.builder(
            itemCount: posts.length,
            itemBuilder: (_, index) => postCard(post: posts[index]),
          );
        },
      )
    );
  }

}