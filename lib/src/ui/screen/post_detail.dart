import 'package:flutter/material.dart';
import 'package:lotalk_frontend/src/model/post.dart';
import 'package:lotalk_frontend/src/repository/post_repository.dart';

class PostDetail extends StatefulWidget {
  const PostDetail({Key? key, required this.post}) : super(key: key);

  final Post post;

  @override
  _PostDetailState createState() => _PostDetailState();
}

class _PostDetailState extends State<PostDetail> {
  late PostRepository _postRepository;
  late Post _post;

  @override
  void initState() {
    super.initState();
    _postRepository = PostRepository();
    _post = widget.post;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_post.title),
      ),
      body: FutureBuilder(
          future: _postRepository.getPostDetail(_post.id),
          initialData: widget.post,
          builder: (_, AsyncSnapshot snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
            return _buildPostDetail(context, snapshot.data);
          }),
    );
  }

  Widget _buildPostDetail(BuildContext context, Post post) {
    _post = post;

    return Center(
      child: Text(_post.content ?? "None"),
    );
  }
}
