import 'package:flutter/material.dart';
import 'package:sognora_social_login/sognora_social_login.dart';
import 'package:sognora_social_login/src/provider/google.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Sognora Social Login Test',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: LoginScreen(),
    );
  }
}

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final GoogleLogin googleLogin = Sognora.socialLogin.google();
  String loginMessage = '';

  Future<void> _handleLogin() async {
    final result = await googleLogin.signIn();
    setState(() {
      loginMessage = result != null ? 'Login Successful' : 'Login Failed';
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Social Login')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: _handleLogin,
              child: Text('Sign in with Google'),
            ),
            SizedBox(height: 20),
            Text(loginMessage), // 로그인 메시지 표시
          ],
        ),
      ),
    );
  }
}
