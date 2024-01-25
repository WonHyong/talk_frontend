
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:lotalk_frontend/src/model/join.dart';

import '../../repository/user_repository.dart';

class JoinPage extends StatefulWidget{
  const JoinPage({required this.repository, Key? key}) : super(key: key);

  final UserRepository repository;

  @override
  _JoinPageState createState() => _JoinPageState();
}

class _JoinPageState extends State<JoinPage>{
  UserRepository get _repository => widget.repository;

  final TextEditingController _idController = TextEditingController();
  final TextEditingController _pwController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('회원 가입'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              controller: _idController,
              decoration: const InputDecoration(labelText: 'ID'),
            ),
            const SizedBox(height: 16.0),
            TextField(
              controller: _emailController,
              decoration: const InputDecoration(labelText: 'e-mail'),
            ),
            const SizedBox(height: 16.0),
            TextField(
              controller: _pwController,
              obscureText: true,
              decoration: const InputDecoration(labelText: 'Password'),
            ),
            const SizedBox(height: 32.0),
            ElevatedButton(onPressed: _signUp, child: const Text('회원 가입'))
          ],
        ),
      ),
    );
  }

  Future<void> _signUp() async {
    print('join 시작');
    try{
      print('_signUp try 문 실행');
      final Join joinInfo = Join(
        name: _idController.text,
        email: _emailController.text,
        password: _pwController.text,
      );
      final response = await _repository.join(joinInfo);
      print('_signUp try 문 실행 중: ${response.response.statusCode}');
      if(response.response.statusCode == 200){
        Navigator.pop(context);
      }
    }catch(e){
      if (e is DioException) {
        if (e.response != null) {
          print('DioError - Response data: ${e.response!.data}, ${e.response!.statusCode}');

        } else {
          print('DioError - No response');
        }
      } else {
        // DioError가 아닌 다른 예외인 경우
        print('Error: $e');
      }
    }
  }

}