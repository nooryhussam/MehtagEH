import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CardsServices extends StatelessWidget {
  final String title;
  final String subtitle;
  final String imagepath;
  const CardsServices({
    super.key,
    required this.title,
    required this.subtitle,
    required this.imagepath,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      shadowColor: Color(0x00000040),
      color: Colors.white,
      margin: EdgeInsets.all(10),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(24),
        side: BorderSide(color: Colors.black, width: 0.1),
      ),
      child: ListTile(
        onTap: () {},
        contentPadding: EdgeInsets.all(10),
        leading: Icon(Icons.arrow_back_ios_new, size: 15, color: Colors.black),
        title: Text(
          title,
          textDirection: TextDirection.rtl,
          style: GoogleFonts.tajawal(
            fontSize: 16,
            fontWeight: FontWeight.w500,
            color: Colors.black,
          ),
        ),
        subtitle: Text(
          subtitle,
          textDirection: TextDirection.rtl,
          style: GoogleFonts.tajawal(
            fontSize: 12,
            fontWeight: FontWeight.w400,
            color: Color(0xFF666666),
          ),
        ),
        trailing: Image.asset(imagepath, width: 38, height: 38),
      ),
    );
  }
}
