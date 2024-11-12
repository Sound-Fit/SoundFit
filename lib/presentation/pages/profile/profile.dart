import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:soundfit/core/configs/theme/app_colors.dart';
import 'package:soundfit/presentation/pages/auth/login.dart';
import 'package:soundfit/presentation/pages/profile/changePassword.dart';
import 'package:soundfit/presentation/pages/profile/editProfile.dart';
import 'package:soundfit/presentation/pages/profile/information.dart';
import 'package:soundfit/presentation/pages/profile/removeAccount.dart';

class Profile extends StatelessWidget {
  const Profile({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(
          child: TitleText(text: 'Profile', textAlign: TextAlign.center),
        ),
        backgroundColor: AppColors.white,
        automaticallyImplyLeading: false,
      ),
      backgroundColor: AppColors.white,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Expanded(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  children: [
                    // Profile Picture and Username
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        CircleAvatar(
                          radius: 70,
                          backgroundColor: Colors.grey[300],
                          child:
                              Icon(Icons.person, size: 50, color: Colors.grey),
                        ),
                        Gap(8),
                        TextStyled(
                            text: '[Username] ', fontWeight: FontWeight.bold),
                      ],
                    ),
                    Gap(30.0),

                    // Account Fields
                    Column(
                      children: [
                        Align(
                            alignment: Alignment.centerLeft,
                            child: Padding(
                              padding: const EdgeInsets.only(left: 15.0),
                              child: TextStyled(
                                  text: 'Account', fontWeight: FontWeight.bold),
                            )),
                        Gap(10),
                        Container(
                          width: double.infinity,
                          decoration: BoxDecoration(
                            color: AppColors.white, // Background color
                            borderRadius:
                                BorderRadius.circular(15.0), // Border radius
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey
                                    .withOpacity(0.5), // Shadow color
                                spreadRadius: 2,
                                blurRadius: 10,
                                offset: Offset(0, 5), // Position of shadow
                              ),
                            ],
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: Column(
                              children: [
                                menuButton(
                                  text: 'Edit Profile',
                                  icon: Icons.person,
                                  onPressed: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (BuildContext context) =>
                                              EditProfile()),
                                    );
                                  },
                                ),
                                Gap(10),
                                menuButton(
                                  text: 'Change Password',
                                  icon: Icons.lock,
                                  onPressed: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (BuildContext context) =>
                                              ChangePassword()),
                                    );
                                  },
                                ),
                                Gap(10),
                                menuButton(
                                  text: 'Remove Account',
                                  icon: Icons.delete,
                                  onPressed: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (BuildContext context) =>
                                              RemoveAccount()),
                                    );
                                  },
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                    Gap(30),

                    // Information Fields
                    Column(
                      children: [
                        Align(
                            alignment: Alignment.centerLeft,
                            child: Padding(
                              padding: const EdgeInsets.only(left: 15.0),
                              child: TextStyled(
                                  text: 'Information',
                                  fontWeight: FontWeight.bold),
                            )),
                        Gap(10),
                        Container(
                          width: double.infinity,
                          decoration: BoxDecoration(
                            color: AppColors.white, // Background color
                            borderRadius:
                                BorderRadius.circular(15.0), // Border radius
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey
                                    .withOpacity(0.5), // Shadow color
                                spreadRadius: 2,
                                blurRadius: 10,
                                offset: Offset(0, 5), // Position of shadow
                              ),
                            ],
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: Column(
                              children: [
                                menuButton(
                                  text: 'Information',
                                  icon: Icons.info,
                                  onPressed: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (BuildContext context) =>
                                              Information()),
                                    );
                                  },
                                ),
                                Gap(10),
                                menuButton(
                                  text: 'Logout',
                                  icon: Icons.logout,
                                  onPressed: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (BuildContext context) =>
                                              Login()),
                                    );
                                  },
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget TextStyled(
      {required String text, FontWeight? fontWeight = FontWeight.normal}) {
    return Text(
      text,
      style: TextStyle(
        fontSize: 18,
        fontWeight: fontWeight,
        fontFamily: GoogleFonts.poppins().fontFamily,
        color: Colors.black,
      ),
    );
  }

  Widget TitleText({required String text, TextAlign? textAlign}) {
    return Text(
      text,
      textAlign: textAlign,
      style: GoogleFonts.lexendDeca(fontSize: 24, fontWeight: FontWeight.w900),
    );
  }

  Widget menuButton(
      {required String text,
      required IconData icon,
      required VoidCallback onPressed}) {
    Color color = text == 'Logout' || text == 'Remove Account'
        ? AppColors.red
        : Colors.black;
    return TextButton(
      onPressed: onPressed,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Icon(
                icon,
                color: color,
              ),
              Gap(10),
              Text(
                text,
                style: TextStyle(
                  color: color,
                ),
              ),
            ],
          ),
          if (text != 'Logout')
            Icon(
              Icons.arrow_forward_ios,
              color: color,
              size: 16,
            ),
        ],
      ),
    );
  }
}
