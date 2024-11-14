import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:soundfit/common/widgets/text/based_text.dart';
import 'package:soundfit/common/widgets/text/title_text.dart';

class ChangePassword extends StatelessWidget {
  ChangePassword({Key? key}) : super(key: key);
  final TextEditingController _newPassword = TextEditingController();
  final TextEditingController _newPasswordConfirm = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: TitleText(text: 'Password', textAlign: TextAlign.center),
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
        actions: [
          TextButton(
            onPressed: () {
              // Save logic goes here, e.g., update user profile in database
              Navigator.pushNamed(context, '/profile');
            },
            child: Text(
              'Save',
              style: GoogleFonts.poppins(
                color: Colors.grey,
                fontSize: 16,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ],
      ),
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.all(30.0),
        child: Column(
          children: [
            Expanded(
                child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // New Password field
                  BasedText(
                      text: "New Password",
                      fontWeight: FontWeight.bold,
                      fontSize: 16),
                  SizedBox(height: 8),
                  TextField(
                    controller: _newPassword,
                    decoration: InputDecoration(
                      filled: true,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(16.0),
                      ),
                      // labelText: 'New Password',
                    ),
                  ),
                  Gap(16),

                  // New Password field
                  BasedText(
                      text: "Confirm New Password",
                      fontWeight: FontWeight.bold,
                      fontSize: 16),
                  SizedBox(height: 8),
                  TextField(
                    controller: _newPasswordConfirm,
                    decoration: InputDecoration(
                      filled: true,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(16.0),
                      ),
                      // labelText: 'Confirm New Password',
                    ),
                  ),
                ],
              ),
            ))
          ],
        ),
      ),
    );
  }
}
