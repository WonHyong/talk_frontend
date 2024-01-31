import 'package:flutter/material.dart';

import '../../model/create_post.dart';
import '../../model/post.dart';
import '../../repository/post_repository.dart';

class PostModifyPage extends StatefulWidget{
  const PostModifyPage({required this.postId ,required this.repository, Key? key}) : super(key: key);

  final PostRepository repository;
  final int postId;

  @override
  _PostModifyState createState() => _PostModifyState();
}

class _PostModifyState extends State<PostModifyPage>{
  PostRepository get _repository => widget.repository;
  final TextEditingController titleController = TextEditingController();
  final TextEditingController bodyController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('글 수정'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TextField(
              controller: titleController,
              decoration: InputDecoration(labelText: '제목'),
            ),
            SizedBox(height: 16.0),
            TextField(
              controller: bodyController,
              maxLines: 5,
              decoration: InputDecoration(labelText: '내용'),
            ),
            SizedBox(height: 16.0),
            ElevatedButton(
              onPressed: (){
                _submitPost(context);
              },
              child: Text('저장하기'),
            )
          ],
        ),
      ),
    );
  }

  Future<void> _submitPost(BuildContext context) async {
    final String title = titleController.text;
    final String body = bodyController.text;

    final CreatePost CP = CreatePost(
      title: title,
      content: body,
    );

    final response = await _repository.updatePost(widget.postId, CP);

    if(response.response.statusCode == 200){
      print('${response.response.statusCode}');
      Navigator.pop(context);
    }else{
      print('${response.response.statusCode}');
    }
  }
}