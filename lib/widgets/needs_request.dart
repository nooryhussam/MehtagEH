import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class NeedsRequest extends StatelessWidget {
  final String text;
  const NeedsRequest({super.key, required this.text});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(5),
      padding: EdgeInsets.only(left: 10, top: 2, bottom: 2, right: 10),
      height: 26,
      width: 52,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: Color(0xFFF38C2B), width: 1),
      ),
      child: Text(
        text,
        style: GoogleFonts.tajawal(
          fontSize: 12,
          color: Colors.white,
          fontWeight: FontWeight.w400,
        ),
      ),
    );
  }
}
