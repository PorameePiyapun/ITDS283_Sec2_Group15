import 'package:flutter/material.dart';
import '/screens/login/login_1.dart';
import '/screens/login/signup.dart';
// import 'login_2.dart'; // Uncomment when you create login_2.dart

void main() {
  runApp(HelpYouToMUHealthApp());
}

class HelpYouToMUHealthApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Help You to MU Health',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        fontFamily: 'Poppins',
        scaffoldBackgroundColor: Colors.white,
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => Login1Screen(),
        '/signup': (context) => SignUpScreen(),
        // '/login_2': (context) => Login2Screen(), // You can add this later
      },
    );
  }
}
