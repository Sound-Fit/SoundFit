import 'package:flutter/material.dart';
import 'package:soundfit/pages/camera.dart';
import 'package:soundfit/pages/splashPage.dart';
import 'package:soundfit/pages/welcomePage.dart';
import 'package:soundfit/pages/login.dart';
import 'package:soundfit/pages/register.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'SoundFit',
      initialRoute: '/',
      routes: {
        '/': (context) => SplashPage(),
        '/welcome': (context) => WelcomePage(),
        '/login': (context) => Login(),
        '/register': (context) => Register(),
        '/camera': (context) => CameraScreen(),
      },
    );
  }
}
