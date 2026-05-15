import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AppButton extends StatelessWidget {
  final String text;
  final VoidCallback onTap;
  final Widget? icon; // Flexible for Icons or Image.asset
  final Size? size;
  final double? textSize;
  final double? borderRadius;

  const AppButton({
    super.key,
    required this.text,
    required this.onTap,
    this.icon,
    this.size,
    this.textSize,
    this.borderRadius,
  });

  @override
  Widget build(BuildContext context) {
    // Default values using ScreenUtil if not provided via constructor
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
          backgroundColor: const Color(0xFF2BA12F),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(finalRadius),
          ),
          padding: EdgeInsets.zero,
          elevation: 0,
          shadowColor: Colors.transparent,
        ),
        child: icon != null
            ? Row(
                mainAxisAlignment: MainAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                textDirection: TextDirection.rtl,
                children: [
                  Text(
                    text,
                    style: GoogleFonts.tajawal(
                      color: const Color(0XffF6F9FA),
                      fontSize: finalFontSize,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(width: 10.w),
                  icon!,
                ],
              )
            : Text(
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
