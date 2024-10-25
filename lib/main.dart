import 'package:flutter/material.dart';
import 'package:soundfit/pages/Camera/camera.dart';
import 'package:soundfit/pages/splashPage.dart';
import 'package:soundfit/pages/welcomePage.dart';
import 'package:soundfit/pages/login.dart';
import 'package:soundfit/pages/register.dart';
import 'package:soundfit/widgets/navBar.dart';
import 'package:soundfit/pages/Library/artist.dart';
import 'package:soundfit/pages/Library/playlist.dart';
import 'package:soundfit/pages/Explore/genre.dart';
import 'package:soundfit/pages/Explore/search.dart';
import 'package:soundfit/pages/Profile/editProfile.dart';
import 'package:soundfit/pages/playMusic.dart';

void main() {
  runApp(MyApp());
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
        '/home': (context) => CustomNavBar(),
        '/explore': (context) => CustomNavBar(),
        '/explore/genre': (context) => Genre(),
        '/explore/search': (context) => Search(),
        '/library': (context) => CustomNavBar(),
        '/library/artist': (context) => Artist(),
        '/library/playlist': (context) => Playlist(),
        '/profile': (context) => CustomNavBar(),
        '/profile/edit': (context) => EditProfile(),
        '/playMusic': (context) => PlayMusic(),
      },
    );
  }
}
