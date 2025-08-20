import 'package:flutter/material.dart';
import 'screens/login_screen.dart';
import 'screens/admin_dashboard.dart';
import 'screens/user_dashboard.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Role Based Auth',
      theme: ThemeData(primarySwatch: Colors.blue),
      debugShowCheckedModeBanner: false,
      initialRoute: '/',
      routes: {
        '/': (context) => LoginScreen(),
        '/admin': (context) => AdminDashboard(),
        '/user': (context) => UserDashboard(),
      },
    );
  }
}
