import 'package:camera/camera.dart';
import 'package:firebase_app_check/firebase_app_check.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:soundfit/core/configs/theme/app_theme.dart';
import 'package:soundfit/firebase_options.dart';
import 'package:soundfit/presentation/pages/auth/login.dart';
import 'package:soundfit/presentation/pages/auth/register.dart';
import 'package:soundfit/presentation/pages/auth/welcomePage.dart';
import 'package:soundfit/presentation/pages/camera/camera.dart';
import 'package:soundfit/presentation/pages/profile/profile.dart';
import 'package:soundfit/presentation/pages/splashPage.dart';
import 'package:soundfit/presentation/widgets/navBar.dart';
import 'package:soundfit/service_locator.dart';
import 'package:soundfit/presentation/pages/explore/genre.dart';
import 'package:soundfit/presentation/pages/explore/search.dart';
import 'package:soundfit/presentation/pages/profile/editProfile.dart';
import 'package:soundfit/presentation/pages/playMusic.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Obtain a list of the available cameras on the device.
  final cameras = await availableCameras();
  final firstCamera = cameras.first;

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  await initializeDependencies();

  await FirebaseAppCheck.instance.activate(
    webProvider: ReCaptchaV3Provider('recaptcha-v3-site-key'),
    androidProvider: AndroidProvider.debug,
    appleProvider: AppleProvider.appAttest,
  );

  runApp(MyApp(firstCamera: firstCamera));
}

class MyApp extends StatelessWidget {
  final CameraDescription firstCamera;

  MyApp({Key? key, required this.firstCamera}) : super(key: key);
  User? user = FirebaseAuth.instance.currentUser;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'SoundFit',
      theme: AppTheme.lightTheme,
      home: SplashPage(),
      initialRoute: user != null ? '/home' : '/',
      routes: {
        // '/': (context) => SplashPage(),
        '/welcome': (context) => WelcomePage(),
        '/login': (context) => Login(),
        '/register': (context) => Register(),
        '/home': (context) => CustomNavBar(camera: firstCamera),
        '/explore/genre': (context) => Genre(),
        '/explore/search': (context) => Search(),
        '/profile': (context) =>
            CustomNavBar(camera: firstCamera, selectedIndex: 3),
        '/profile/edit': (context) => EditProfile(),
        '/playMusic': (context) => PlayMusic(),
        '/camera': (context) => CameraScreen(camera: firstCamera),
        '/recommendation': (context) =>
            CustomNavBar(camera: firstCamera, selectedIndex: 4),
      },
    );
  }
}
