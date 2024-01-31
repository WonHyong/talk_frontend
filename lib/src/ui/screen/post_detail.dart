import 'package:flutter/material.dart';
import 'package:lotalk_frontend/src/model/create_comment.dart';
import 'package:lotalk_frontend/src/model/post.dart';
import 'package:lotalk_frontend/src/repository/post_repository.dart';
import 'package:lotalk_frontend/src/ui/screen/post_modify.dart';

import '../../model/detail_post.dart';
import '../../preferences.dart';

class PostDetail extends StatefulWidget {
  const PostDetail({Key? key, required this.postId, required this.repository})
      : super(key: key);

  final PostRepository repository;
  final int postId;

  @override
  _PostDetailState createState() => _PostDetailState();
}

class _PostDetailState extends State<PostDetail> {
  PostRepository get _repository => widget.repository;
  late Future<DetailPost> _postDetailFuture;
  late TextEditingController _commentController;

  String userId = SharedPrefs().username;

  @override
  void initState() {
    super.initState();
    _postDetailFuture = _repository.getPostDetail(widget.postId);
    _commentController = TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('게시물 상세보기'),
        actions: [
          FutureBuilder<DetailPost>(
            future: _postDetailFuture,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Container();
              } else if (snapshot.hasData) {
                final post = snapshot.data!;
                print('username: $userId, post Writer: ${post.writer}');
                if (userId == post.writer) {
                  print('username: $userId, post Writer: ${post.writer}');
                  return IconButton(
                    icon: Icon(Icons.edit),
                    onPressed: () {
                      _moveToModify();
                    },
                  );
                }
              }
              return Container();
            },
          ),
        ],
      ),
      body: FutureBuilder<DetailPost>(
          future: _postDetailFuture,
          builder: (context, snapshot){
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(
                child: CircularProgressIndicator(),
              );
            } else if (snapshot.hasError) {
              return Center(
                child: Text('Error: ${snapshot.error}'),
              );
            } else if (snapshot.hasData) {
              final post = snapshot.data!;
              return Padding(
                padding: EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      post.title,
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 8),
                    Text(
                      post.content,
                      style: TextStyle(
                        fontSize: 18,
                      ),
                    ),
                    SizedBox(height: 16),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          '댓글',
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        if (userId == post.writer)
                          ElevatedButton(
                            onPressed: () {
                              _deletePost();
                            },
                            child: Text('삭제'),
                          ),
                      ],
                    ),
                    SizedBox(height: 8),
                    _buildCommentInput(),
                    Expanded(
                      child: ListView.builder(
                        itemCount: post.comments.length,
                        itemBuilder: (context, index) {
                          final comment = post.comments[index];
                          return ListTile(
                            title: Text(comment.content),
                            subtitle: Text(comment.writer),
                          );
                        },
                      ),
                    ),
                  ],
                ),
              );
            } else {
              return Center(
                child: Text('No data'),
              );
            }
          },
      ),
    );
  }
  Widget _buildCommentInput() {
    return Row(
      children: [
        Expanded(
          child: TextField(
            controller: _commentController,
            decoration: InputDecoration(
              hintText: '댓글을 입력하세요',
              border: OutlineInputBorder(),
            ),
          ),
        ),
        SizedBox(width: 8),
        ElevatedButton(
          onPressed: () {
            _submitComment();
          },
          child: Text('댓글 작성'),
        ),
      ],
    );
  }

  Future<void> _submitComment() async {
    final String commentText = _commentController.text.trim();
    final CreateComment comment = CreateComment(content: commentText);
    if (commentText.isNotEmpty) {
      print('댓글 보내기 시작');
      final response = await _repository.createComment(widget.postId, comment);
      if(response.response.statusCode == 200){
        _commentController.clear();
        _postDetailFuture = _repository.getPostDetail(widget.postId);
      }else{
        print(response.response.statusCode);
      }

    } else {
      // 댓글이 비어있는 경우 경고 메시지 또는 예외 처리를 수행할 수 있습니다.
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: Text('댓글 작성 오류'),
          content: Text('댓글을 입력하세요.'),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: Text('확인'),
            ),
          ],
        ),
      );
    }
  }

  void _deletePost(){
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('글 삭제'),
        content: Text('정말로 삭제하시겠습니까?'),
        actions: [
          ElevatedButton(onPressed: (){
            _repository.deletePost(widget.postId);
            Navigator.pop(context);
            Navigator.pop(context);
          },
              child: Text('확인')),
          TextButton(onPressed: () =>
              Navigator.pop(context),
              child: Text('취소')),
        ],
      ),
    );
  }

  void _moveToModify(){
    Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => PostModifyPage(postId: widget.postId,repository: PostRepository.instance)));
  }
/*
  Widget _buildPostDetail(BuildContext context) {
    return Center(
      child: Text(_post.content ?? "None"),
    );
  }*/
}
