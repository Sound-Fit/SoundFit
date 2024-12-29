import 'package:flutter/material.dart';
import 'package:soundfit/common/widgets/text/based_text.dart';

class RecognitionResult extends StatelessWidget {
  const RecognitionResult({
    super.key,
    required this.recognitionPath,
    required this.ageRange,
  });

  final String? recognitionPath;
  final String ageRange;

  /// Method to determine age range based on the age value
  String getAgeRange(String age) {
    switch (age) {
      case "0":
        return 'Children (0-12 years)';
      case "1":
        return 'Teenagers (13-20 years)';
      case "2":
        return 'Young Adults (21-30 years)';
      case "3":
        return 'Adults (31-40 years)';
      case "4":
        return 'Middle-Aged Adults (41-50 years)';
      case "5":
        return 'Elderly Adults (51+ years)';
      default:
        return 'Unknown Age Range';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        // Display the image from recognitionPath
        Container(
          height: 150,
          width: 150,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(5),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.5), // Shadow color
                spreadRadius: 2,
                blurRadius: 10,
                offset: const Offset(0, 5), // Position of shadow
              ),
            ],
            image: recognitionPath != null
                ? DecorationImage(
                    image: NetworkImage(recognitionPath!),
                    fit: BoxFit.cover,
                  )
                : const DecorationImage(
                    image: AssetImage('assets/images/default_image.jpg'),
                    fit: BoxFit.cover,
                  ),
          ),
        ),
        // Display the age range as text
        SizedBox(
          width: 150,
          child: BasedText(
            text: getAgeRange(ageRange),
            fontSize: 16,
            fontWeight: FontWeight.bold,
            textAlign: TextAlign.center,
            profile: true,
          ),
        )
      ],
    );
  }
}
