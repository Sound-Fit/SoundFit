import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:soundfit/core/configs/theme/app_theme.dart';
import 'package:soundfit/firebase_options.dart';
import 'package:soundfit/presentation/pages/home.dart';
import 'package:soundfit/presentation/pages/library/artist.dart';
import 'package:soundfit/presentation/pages/library/playlist.dart';
import 'package:soundfit/presentation/pages/splashPage.dart';
import 'package:soundfit/presentation/widgets/navBar.dart';
import 'package:soundfit/service_locator.dart';
// import 'package:soundfit/presentation/pages/camera/camera.dart';
// import 'package:soundfit/presentation/pages/welcomePage.dart';
// import 'package:soundfit/presentation/pages/login.dart';
// import 'package:soundfit/presentation/pages/register.dart';
// import 'package:soundfit/presentation/widgets/navBar.dart';
// import 'package:soundfit/presentation/pages/library/artist.dart';
// import 'package:soundfit/presentation/pages/library/playlist.dart';
// import 'package:soundfit/presentation/pages/explore/genre.dart';
// import 'package:soundfit/presentation/pages/explore/search.dart';
// import 'package:soundfit/presentation/pages/profile/editProfile.dart';
// import 'package:soundfit/presentation/pages/playMusic.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  await initializeDependencies();

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({super.key});
  User? user = FirebaseAuth.instance.currentUser;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'SoundFit',
      theme: AppTheme.lightTheme,
      initialRoute: user != null ? '/home' : '/',
      home: SplashPage(),
      routes: {
        '/home': (context) => CustomNavBar(),
        '/library/artist': (context) => Artist(),
        '/library/playlist': (context) => Playlist(),
      },
      // initialRoute: '/',
      // routes: {
      //   '/': (context) => SplashPage(),
      //   // '/welcome': (context) => WelcomePage(),
      //   // '/login': (context) => Login(),
      //   // '/register': (context) => Register(),
      //   '/camera': (context) => CameraScreen(),
      //   '/home': (context) => CustomNavBar(),
      //   '/explore': (context) => CustomNavBar(),
      //   '/explore/genre': (context) => Genre(),
      //   '/explore/search': (context) => Search(),
      //   '/library': (context) => CustomNavBar(),
      //   '/profile': (context) => CustomNavBar(),
      //   '/profile/edit': (context) => EditProfile(),
      //   '/playMusic': (context) => PlayMusic(),
      // },
    );
  }
}
