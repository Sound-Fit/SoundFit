import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:soundfit/common/widgets/button/basic_button.dart';
import 'package:soundfit/core/configs/theme/app_colors.dart';
import 'package:soundfit/data/models/auth/create_user_req.dart';
import 'package:soundfit/domain/usecases/auth/signup.dart';
import 'package:soundfit/presentation/pages/auth/login.dart';
import 'package:soundfit/service_locator.dart';

class Register extends StatelessWidget {
  Register({super.key});

  final TextEditingController _name = TextEditingController();
  final TextEditingController _email = TextEditingController();
  final TextEditingController _password = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back), // Set the back icon here
          onPressed: () {
            Navigator.pop(context); // Navigates back when pressed
          },
        ),
        backgroundColor:
            Colors.transparent, // Optional: make the app bar transparent
        elevation: 0, // Optional: remove shadow
      ),
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
            Text('Register Now!',
                style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    fontFamily: GoogleFonts.lexendGiga().fontFamily)),
            Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
              Gap(30.0),
              TextField(
                  controller: _name,
                  autofocus: true,
                  decoration: InputDecoration(
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15.0)),
                          
                      labelText: 'Username')),
              Gap(30.0),
              TextField(
                  controller: _email,
                  decoration: InputDecoration(
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15.0)),
                      labelText: 'Email')),
              Gap(30.0),
              TextField(
                  controller: _password,
                  obscureText: true,
                  decoration: InputDecoration(
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15.0)),
                      labelText: 'Password')),
              Gap(30.0),
              BasicButton(
                  onPressed: () async {
                    var result = await sl<SignupUseCase>().call(
                        params: CreateUserReq(
                            name: _name.text.toString(),
                            email: _email.text.toString(),
                            password: _password.text.toString()));
                    result.fold(
                      (l) {
                        var snackBar = SnackBar(
                          content: Text(l),
                          behavior: SnackBarBehavior.floating,
                        );
                        ScaffoldMessenger.of(context).showSnackBar(snackBar);
                      },
                      (r) {
                        Navigator.pushAndRemoveUntil(
                          context,
                          MaterialPageRoute(
                            builder: (BuildContext context) => Login(),
                          ),
                          (route) => false,
                        );
                      },
                    );
                  },
                  title: "REGISTER",
                  bgColor: AppColors.black,
                  textColor: AppColors.white)
            ]),
          ],
        ),
      ),
    );
  }
}