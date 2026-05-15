import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CustomText extends StatelessWidget {
  const CustomText({
    super.key,
    required this.text1,
    required this.text2,
    required this.onTap,
  });

  final String text1;
  final String text2;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Text.rich(
      TextSpan(
        children: [
          TextSpan(
            text: text1,
            style: GoogleFonts.tajawal(
              fontSize: 14,
              fontWeight: FontWeight.w400,
              color: Color(0xFF828282),
            ),
          ),
          TextSpan(
            text: text2,
            style: GoogleFonts.tajawal(
              fontSize: 14,
              color: Color(0xff000113),
              fontWeight: FontWeight.bold,
            ),
            recognizer: TapGestureRecognizer()..onTap = onTap,
          ),
        ],
      ),
    );
  }
}
