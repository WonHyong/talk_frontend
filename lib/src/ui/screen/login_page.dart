import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:lotalk_frontend/src/model/login.dart';
import 'package:lotalk_frontend/src/ui/screen/home_page.dart';
import 'package:lotalk_frontend/src/model/token.dart';

import 'package:lotalk_frontend/src/network/token_interceptor.dart';
import '../../repository/user_repository.dart';
import 'join_page.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({required this.repository, Key? key}) : super(key: key);

  final UserRepository repository;

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  UserRepository get _repository => widget.repository;

  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('로그인'),
      ),
      body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              TextField(
                controller: _usernameController,
                decoration: InputDecoration(
                  labelText: '아이디',
                ),
              ),
              SizedBox(height: 16.0),
              TextField(
                controller: _passwordController,
                decoration: InputDecoration(
                  labelText: '비밀번호',
                ),
                obscureText: true,
              ),
              SizedBox(height: 32.0),
              ElevatedButton(
                onPressed: () async {
                  login();
                },
                child: Text('로그인'),
              ),
              SizedBox(height: 32.0),
              ElevatedButton(
                onPressed: _moveToJoin,
                child: Text('회원가입'),
              ),
            ],
          )),
    );
  }

  Future<void> login() async {
    print('login 시작');
    try {
      print('login 본격적인 시작');
      Token response = await (_repository.login(Login(
          name: _usernameController.text, password: _passwordController.text)));
      print('accessToken: $response');

      TokenInterceptor.token = response;

      _moveToPostList();
    } catch (e) {
      if (e is DioException) {
        // DioError 객체에서 에러 정보를 얻을 수 있습니다.
        if (e.response != null) {
          // 서버로부터의 응답이 있는 경우
          print('DioError - Response data: ${e.response!.data}');
        } else {
          // 서버로의 요청이 실패한 경우
          print('DioError - No response');
        }
      } else {
        // DioError가 아닌 다른 예외인 경우
        print('Error: $e');
      }
    }
  }

  void _moveToPostList() {
    Navigator.pushReplacement(
        context, MaterialPageRoute(builder: (context) => HomePage()));
  }

  void _moveToJoin() {
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) =>
                JoinPage(repository: UserRepository.instance)));
  }
}
