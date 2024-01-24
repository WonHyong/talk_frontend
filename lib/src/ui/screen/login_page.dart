import 'package:flutter/material.dart';
import 'package:lotalk_frontend/src/model/login.dart';
import 'package:lotalk_frontend/src/ui/screen/home_page.dart';

import '../../repository/user_repository.dart';

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
        title: const Text('로그인'),
      ),
      body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              TextField(
                controller: _usernameController,
                decoration: const InputDecoration(
                  labelText: '아이디',
                ),
              ),
              const SizedBox(height: 16.0),
              TextField(
                controller: _passwordController,
                decoration: const InputDecoration(
                  labelText: '비밀번호',
                ),
                obscureText: true,
              ),
              const SizedBox(height: 32.0),
              ElevatedButton(
                onPressed: _login,
                child: const Text('로그인'),
              ),
              const SizedBox(height: 32.0),
              ElevatedButton(
                onPressed: _moveToJoin,
                child: const Text('회원가입'),
              ),
            ],
          )),
    );
  }

  void _login() async {
    print('login 시작');
    _repository
        .login(Login(
            name: _usernameController.text, password: _passwordController.text))
        .then((token) => {_moveToHome()})
        .catchError((err) {
      print("ERROR_LOGIN: $err");
    });
  }

  void _moveToHome() {
    Navigator.pushReplacement(
        context, MaterialPageRoute(builder: (context) => const HomePage()));
  }

  void _moveToJoin() {
    print('moveToJoin');
    /*
    Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => JoinPage())
    );*/
  }
}
