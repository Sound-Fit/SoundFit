import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:google_fonts/google_fonts.dart';

class Login extends StatelessWidget {
  const Login({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 50.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Hey!👋',
              textAlign: TextAlign.left,
              style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  fontFamily: GoogleFonts.lexendGiga().fontFamily),
            ),
            Text('Login Now!',
                style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    fontFamily: GoogleFonts.lexendGiga().fontFamily)),
            Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
              Gap(36.0),
              TextField(
                  autofocus: true,
                  decoration: InputDecoration(
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15.0)),
                      labelText: 'Username')),
              Gap(36.0),
              TextField(
                  decoration: InputDecoration(
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15.0)),
                      labelText: 'Password')),
              Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                Text('forgot password?', style: TextStyle(color: Colors.grey)),
                TextButton(
                    onPressed: () {},
                    child: Text(
                      'reset password',
                      style: TextStyle(color: Colors.black),
                    ))
              ]),
              Gap(36.0),
              TextButton(
                  style: ButtonStyle(
                      backgroundColor: WidgetStateProperty.all(Colors.black),
                      shape: WidgetStateProperty.all(RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15.0)))),
                  onPressed: () => Navigator.pushNamed(context, '/home'),
                  child: Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: Text(
                      'LOGIN',
                      style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 14,
                          fontFamily: GoogleFonts.lexendGiga().fontFamily),
                    ),
                  ))
            ]),
          ],
        ),
      ),
    );
  }
}
