import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:soundfit/common/widgets/button/basic_button.dart';
import 'package:soundfit/core/configs/theme/app_colors.dart';

class RemoveAccount extends StatelessWidget {
  const RemoveAccount({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: TitleText(text: 'Remove Account', textAlign: TextAlign.center),
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
      ),
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.all(30.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    // About Soundfit
                    Column(
                      children: [
                        TextStyled(
                            text:
                                "Are you sure you want to delete your account? Deleting your account will permanently remove your profile, playlists, and all saved preferences. This action cannot be undone.",
                            fontSize: 14,
                            fontWeight: FontWeight.normal),
                        pointText(
                            text:
                                "To confirm, please enter your account password and tap Delete Account."),
                        pointText(
                            text:
                                "If you’re not sure, you can go back and keep your account active."),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            // Button
            BasicButton(
              onPressed: () {},
              title: "Delete Account",
              bgColor: AppColors.red,
              textColor: AppColors.white,
            ),
          ],
        ),
      ),
    );
  }

  Widget TitleText({required String text, TextAlign? textAlign}) {
    return Text(
      text,
      textAlign: textAlign,
    );
  }

  Widget TextStyled(
      {required String text,
      required double fontSize,
      FontWeight fontWeight = FontWeight.bold}) {
    return Text(
      text,
      textAlign: TextAlign.justify,
      style: TextStyle(
        fontSize: fontSize,
        fontWeight: fontWeight,
        color: AppColors.black,
        fontFamily: 'Poppins',
      ),
    );
  }

  Widget pointText({required String text}) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text("•"),
        Gap(10),
        Expanded(
          child: TextStyled(
            text: text,
            fontSize: 14,
            fontWeight: FontWeight.normal,
          ),
        ),
      ],
    );
  }
}
