
// import 'package:anoop/Screens/new.dart';

import 'package:flutter/material.dart';
import 'Screen/SplashScreen.dart';
import 'Screen/login.dart';
import 'Screen/register.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: 'splash',
      routes: {
       // 'new' : (context) => New(),
        'splash' : (context) => const SplashScreen(),
        'login' : (context) => const LoginPage(),
        'register' : (context) => const RegisterPage(),
       // 'detail' : (context) => DetailPage(),
      },
    );
  }
}
