import 'package:flutter/material.dart';
import 'auth_service.dart';

class LoginScreenTest extends StatefulWidget {
  static String id = "LoginScreenTest";
  @override
  _LoginScreenTestState createState() => _LoginScreenTestState();
}

class _LoginScreenTestState extends State<LoginScreenTest> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool _isLoading = false;

  void _handleLogin() async {
    setState(() {
      _isLoading = true;
    });

    final authService = AuthService();
    final response = await authService.login(
      _emailController.text.trim(),
      _passwordController.text.trim(),
    );

    setState(() {
      _isLoading = false;
    });

    if (response.containsKey("token")) {
      print("Login Successful: ${response['token']}");
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text('success'),
      ));
      // Navigate to Home/Dashboard
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(response["error"] ?? "Login failed")),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Login")),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              controller: _emailController,
              keyboardType: TextInputType.emailAddress,
              decoration: InputDecoration(labelText: "Email"),
            ),
            TextField(
              controller: _passwordController,
              obscureText: true,
              decoration: InputDecoration(labelText: "Password"),
            ),
            SizedBox(height: 20),
            _isLoading
                ? CircularProgressIndicator()
                : ElevatedButton(
                    onPressed: _handleLogin,
                    child: Text("Login"),
                  ),
          ],
        ),
      ),
    );
  }
}
