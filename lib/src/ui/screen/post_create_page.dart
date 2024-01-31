import 'package:flutter/material.dart';

import '../../model/create_post.dart';
import '../../model/post.dart';
import '../../repository/post_repository.dart';

class PostCreatePage extends StatefulWidget{
  const PostCreatePage({required this.repository, Key? key}) : super(key: key);

  final PostRepository repository;

  @override
  _PostCreateState createState() => _PostCreateState();
}

class _PostCreateState extends State<PostCreatePage>{
  PostRepository get _repository => widget.repository;
  final TextEditingController titleController = TextEditingController();
  final TextEditingController bodyController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('글 작성'),
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

    final response = await _repository.createPost(CP);

    if(response.response.statusCode == 200){
      Navigator.pop(context);
    }else{
      print('${response.response.statusCode}');
    }
  }
}