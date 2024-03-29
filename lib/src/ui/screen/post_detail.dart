import 'package:flutter/material.dart';
import 'package:lotalk_frontend/src/model/post.dart';
import 'package:lotalk_frontend/src/repository/post_repository.dart';

class PostDetail extends StatefulWidget {
  const PostDetail({Key? key, required this.post, required this.repository})
      : super(key: key);

  final PostRepository repository;
  final Post post;

  @override
  _PostDetailState createState() => _PostDetailState();
}

class _PostDetailState extends State<PostDetail> {
  late Post _post;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.post.title),
      ),
      body: FutureBuilder(
          future: widget.repository.getPostDetail(widget.post.id),
          initialData: widget.post,
          builder: (_, AsyncSnapshot snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
            _post = snapshot.data;
            return _buildPostDetail(context);
          }),
    );
  }

  Widget _buildPostDetail(BuildContext context) {
    return Center(
      child: Text(_post.content ?? "None"),
    );
  }
}
