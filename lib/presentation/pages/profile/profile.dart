import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:soundfit/common/widgets/button/menu_button.dart';
import 'package:soundfit/common/widgets/text/based_text.dart';
import 'package:soundfit/common/widgets/text/title_text.dart';
import 'package:soundfit/core/configs/theme/app_colors.dart';
import 'package:soundfit/core/services/user_service.dart';
import 'package:soundfit/presentation/pages/auth/login.dart';
import 'package:soundfit/presentation/pages/profile/changePassword.dart';
import 'package:soundfit/presentation/pages/profile/editProfile.dart';
import 'package:soundfit/presentation/pages/profile/information.dart';
import 'package:soundfit/presentation/pages/profile/removeAccount.dart';

class Profile extends StatefulWidget {
  const Profile({super.key});

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  final UserService _userService = UserService();
  Future<Map<String, String?>>? _userData;

  @override
  void initState() {
    super.initState();
    _userData = _userService.getUserData();
  }

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
      body: FutureBuilder<Map<String, String?>>(
        future: _userData,
        builder: (context, snapshot) {
          final profilePath = snapshot.data?['profilePath'];
          final username = snapshot.data?['username'];

          return Column(
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
                            Center(
                              child: CircleAvatar(
                                radius: 70,
                                backgroundImage: profilePath != null
                                    ? NetworkImage(
                                        profilePath) // Menggunakan URL dari Firebase Storage
                                    : null,
                                backgroundColor: profilePath == null
                                    ? Colors.grey[300]
                                    : Colors.transparent,
                                child: profilePath == null
                                    ? Icon(Icons.person,
                                        size: 50, color: Colors.grey)
                                    : null,
                              ),
                            ),
                            Gap(8),
                            BasedText(
                                text: '$username', fontWeight: FontWeight.bold),
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
                                  child: BasedText(
                                      text: 'Account',
                                      fontWeight: FontWeight.bold),
                                )),
                            Gap(10),
                            Container(
                              width: double.infinity,
                              decoration: BoxDecoration(
                                color: AppColors.white, // Background color
                                borderRadius: BorderRadius.circular(
                                    15.0), // Border radius
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
                                    MenuButton(
                                      title: 'Edit Profile',
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
                                    MenuButton(
                                      title: 'Change Password',
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
                                    MenuButton(
                                      title: 'Remove Account',
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
                                  child: BasedText(
                                      text: 'Information',
                                      fontWeight: FontWeight.bold),
                                )),
                            Gap(10),
                            Container(
                              width: double.infinity,
                              decoration: BoxDecoration(
                                color: AppColors.white, // Background color
                                borderRadius: BorderRadius.circular(
                                    15.0), // Border radius
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
                                    MenuButton(
                                      title: 'Information',
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
                                    MenuButton(
                                      title: 'Logout',
                                      icon: Icons.logout,
                                      onPressed: () {
                                        showDialog(
                                          context: context,
                                          builder: (BuildContext context) {
                                            return AlertDialog(
                                              title: Text('Logout'),
                                              content: Text(
                                                  'Are you sure you want to logout?'),
                                              actions: [
                                                TextButton(
                                                  onPressed: () {
                                                    Navigator.of(context).pop();
                                                  },
                                                  child: Text('Cancel'),
                                                ),
                                                TextButton(
                                                  onPressed: () {
                                                    FirebaseAuth.instance
                                                        .signOut();
                                                    Navigator
                                                        .pushAndRemoveUntil(
                                                      context,
                                                      MaterialPageRoute(
                                                          builder: (BuildContext
                                                                  context) =>
                                                              Login()),
                                                      (Route<dynamic> route) =>
                                                          false,
                                                    );
                                                  },
                                                  child: Text('Logout'),
                                                ),
                                              ],
                                            );
                                          },
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
          );
        },
      ),
    );
  }
}
