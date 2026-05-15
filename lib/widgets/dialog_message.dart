import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class DialogMessage extends StatelessWidget {
  const DialogMessage({
    super.key,
    required this.text,
    required this.text2,
    required this.imagepath,
    required this.color,
    required this.onTap,
  });

  final String text;
  final String text2;
  final String imagepath;
  final Color color;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(24),
      width: 343,
      height: 373,
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
            color: Color(0x40000000),
            offset: Offset(-4, 8),
            blurRadius: 8,
            spreadRadius: 0,
          ),
          BoxShadow(
            color: Color(0x40000000),
            offset: Offset(4, -8),
            blurRadius: 8,
            spreadRadius: 0,
          ),
        ],

        color: Colors.white,
        borderRadius: BorderRadius.circular(24),
      ),
      child: Column(
        children: [
          Image.asset(imagepath, width: 159, height: 155),
          const SizedBox(height: 32),
          Text(
            text,
            style: GoogleFonts.tajawal(
              color: Colors.black,
              fontSize: 24,
              fontWeight: FontWeight.w700,
            ),
          ),
          const SizedBox(height: 33),
          ElevatedButton(
            onPressed: onTap,
            style: ElevatedButton.styleFrom(
              elevation: 6,
              shadowColor: Color(0x40000000),
              backgroundColor: color,
              fixedSize: Size(279, 48),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(24),
              ),
            ),
            child: Text(
              text2,
              style: GoogleFonts.tajawal(
                color: Colors.white,
                fontSize: 16,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
