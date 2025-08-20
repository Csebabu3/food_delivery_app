import 'package:flutter/material.dart';
import '../services/auth_service.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  String? errorMessage;

  void handleLogin() async {
    String username = usernameController.text.trim();
    String password = passwordController.text.trim();

    String? role = await AuthService.login(username, password);

    if (role == "admin") {
      Navigator.pushReplacementNamed(context, '/admin');
    } else if (role == "user") {
      Navigator.pushReplacementNamed(context, '/user');
    } else {
      setState(() {
        errorMessage = "Invalid credentials!";
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Login")),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              controller: usernameController,
              decoration: InputDecoration(labelText: "Username"),
            ),
            TextField(
              controller: passwordController,
              decoration: InputDecoration(labelText: "Password"),
              obscureText: true,
            ),
            SizedBox(height: 20),
            ElevatedButton(onPressed: handleLogin, child: Text("Login")),
            if (errorMessage != null)
              Padding(
                padding: const EdgeInsets.only(top: 10),
                child: Text(errorMessage!, style: TextStyle(color: Colors.red)),
              ),
          ],
        ),
      ),
    );
  }
}
