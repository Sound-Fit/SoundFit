import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:soundfit/common/widgets/button/menu_button.dart';
import 'package:soundfit/common/widgets/text/based_text.dart';
import 'package:soundfit/common/widgets/text/title_text.dart';
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
                        BasedText(
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
                              child: BasedText(
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
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (BuildContext context) =>
                                              Login()),
                                    );
                                  },
                                ),
                                // MenuButton(
                                //   title: 'Logout',
                                //   icon: Icons.logout,
                                //   onPressed: () async {
                                //     // Show a confirmation dialog before logging out
                                //     bool confirmLogout = await showDialog(
                                //           context: context,
                                //           builder: (BuildContext context) {
                                //             return AlertDialog(
                                //               title: Text("Logout"),
                                //               content: Text(
                                //                   "Are you sure you want to logout?"),
                                //               actions: [
                                //                 TextButton(
                                //                   child: Text("Cancel"),
                                //                   onPressed: () =>
                                //                       Navigator.of(context)
                                //                           .pop(false),
                                //                 ),
                                //                 TextButton(
                                //                   child: Text("Logout"),
                                //                   onPressed: () =>
                                //                       Navigator.of(context)
                                //                           .pop(true),
                                //                 ),
                                //               ],
                                //             );
                                //           },
                                //         ) ??
                                //         false;

                                //     if (confirmLogout) {
                                //       // Perform logout logic
                                //       await sl<SignoutUseCase>()
                                //           .call(); // Call the logout use case

                                //       // Navigate to the login page and clear the navigation stack
                                //       Navigator.pushAndRemoveUntil(
                                //         context,
                                //         MaterialPageRoute(
                                //             builder: (BuildContext context) =>
                                //                 Login()),
                                //         (route) => false,
                                //       );
                                //     }
                                //   },
                                // )
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
}
