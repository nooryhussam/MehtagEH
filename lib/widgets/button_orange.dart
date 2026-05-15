import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class OrangeButton extends StatelessWidget {
  final String text;
  final VoidCallback onTap;
  final Size? size;
  final double? textSize;
  final double? borderRadius;

  const OrangeButton({
    super.key,
    required this.text,
    required this.onTap,
    this.size,
    this.textSize,
    this.borderRadius,
  });

  @override
  Widget build(BuildContext context) {
    final double finalWidth = size?.width.w ?? 279.w;
    final double finalHeight = size?.height.h ?? 48.h;
    final double finalFontSize = textSize?.sp ?? 16.sp;
    final double finalRadius = borderRadius?.r ?? 24.r;

    return Container(
      width: finalWidth,
      height: finalHeight,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(finalRadius),
        boxShadow: [
          BoxShadow(
            color: const Color(0x40000000),
            offset: Offset(0, 5.h),
            blurRadius: 6.r,
            spreadRadius: 0,
          ),
        ],
      ),
      child: ElevatedButton(
        onPressed: onTap,
        style: ElevatedButton.styleFrom(
          backgroundColor: const Color(0xFFF38C2B),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(finalRadius),
          ),
          padding: EdgeInsets.zero,
          elevation: 0,
          shadowColor: Colors.transparent,
          fixedSize: Size(259.4781494140625.w, 48.h),
        ),
        child: Text(
          text,
          style: GoogleFonts.tajawal(
            color: const Color(0XffF6F9FA),
            fontSize: finalFontSize,
            fontWeight: FontWeight.bold,
          ),
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}
