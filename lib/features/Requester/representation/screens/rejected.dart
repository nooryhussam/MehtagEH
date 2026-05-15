import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Rejected extends StatelessWidget {
  const Rejected({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 343,
      height: 373,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(24),
      ),
      child: Column(
        children: [
          Image.asset(
            'assets/images/rejected.png',
            width: 159.9468231201172,
            height: 155.0000457763672,
          ),
          const SizedBox(height: 32),
          Text(
            'بصمة الوجه غير متطابقة',
            style: GoogleFonts.tajawal(
              color: Colors.black,
              fontSize: 24,
              fontWeight: FontWeight.w700,
            ),
          ),

          const SizedBox(height: 33),
          ElevatedButton(
            onPressed: () {
              // Navigator.push(
              //   context,
              //   MaterialPageRoute(builder: (context) => HomeRequester()),
              // );
            },
            style: ElevatedButton.styleFrom(
              elevation: 6,
              shadowColor: Color(0x40000000),
              backgroundColor: Color(0xFFFF3333),
              fixedSize: Size(279, 48),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadiusGeometry.circular(24),
              ),
            ),
            child: Text(
              'إعادة المحاولة',
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
