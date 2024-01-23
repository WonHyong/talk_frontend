import 'package:flutter/material.dart';

import 'package:lotalk_frontend/src/model/page_response.dart';
import 'package:lotalk_frontend/src/model/post.dart';
import 'package:lotalk_frontend/src/repository/post_repository.dart';

class PostListView extends StatefulWidget {
  const PostListView({Key? key}) : super(key: key);

  @override
  _PostListViewState createState() => _PostListViewState();
}

class _PostListViewState extends State<PostListView> {
  late PostRepository postRepository;

  @override
  void initState() {
    super.initState();
    postRepository = PostRepository();
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
    return Scaffold(
      appBar: AppBar(
        title: const Text('ALL POSTS'),
      ),
      body: FutureBuilder(
        future: postRepository.getPosts(),
        initialData: [],
        builder: (_, AsyncSnapshot snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          PageResponse<Post> page = snapshot.data;
          List<Post> posts = page.content;

          return ListView.builder(
            itemCount: posts.length,
            itemBuilder: (_, index) => postCard(post: posts[index]),
          );
        },
      )
    );
  }

}