import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
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
      padding: EdgeInsets.all(24.r),
      width: 343.w,
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
            color: const Color(0x40000000),
            offset: Offset(-4.w, 8.h),
            blurRadius: 8.r,
            spreadRadius: 0,
          ),
          BoxShadow(
            color: const Color(0x40000000),
            offset: Offset(4.w, -8.h),
            blurRadius: 8.r,
            spreadRadius: 0,
          ),
        ],
        color: Colors.white,
        borderRadius: BorderRadius.circular(24.r),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Image.asset(imagepath, width: 159.w, height: 155.h),
          SizedBox(height: 32.h),
          Text(
            text,
            style: GoogleFonts.tajawal(
              color: Colors.black,
              fontSize: 24.sp,
              fontWeight: FontWeight.w700,
            ),
            textAlign: TextAlign.center,
          ),
          SizedBox(height: 33.h),
          ElevatedButton(
            onPressed: onTap,
            style: ElevatedButton.styleFrom(
              elevation: 6,
              shadowColor: const Color(0x40000000),
              backgroundColor: color,
              fixedSize: Size(279.w, 48.h),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(24.r),
              ),
            ),
            child: Text(
              text2,
              style: GoogleFonts.tajawal(
                color: Colors.white,
                fontSize: 16.sp,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
