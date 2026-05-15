import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ProfileButton extends StatelessWidget {
  ProfileButton({super.key, required this.title, required this.icon});

  final String title;
  final IconData icon;

  Color primaryGreen = Color(0xFF4CAF50);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      contentPadding: EdgeInsets.all(10),
      shape: RoundedRectangleBorder(
        side: BorderSide(color: primaryGreen),
        borderRadius: BorderRadius.circular(24),
      ),
      leading: Icon(Icons.arrow_back_ios, color: Color(0XFF1A1A1A)),
      title: Text(
        title,
        style: GoogleFonts.tajawal(
          fontSize: 18,
          color: Color(0xFF07212C),
          fontWeight: FontWeight.w500,
        ),
        textAlign: TextAlign.center,
      ),
      trailing: Icon(icon, color: Color(0xFF07212C)),
    );
  }
}
