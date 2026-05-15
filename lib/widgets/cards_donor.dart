import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mahtage_eh/widgets/button_app.dart';

class CardsDonor extends StatelessWidget {
  const CardsDonor({
    super.key,
    required this.title,
    required this.subtitle,
    required this.imagepath,
    required this.textlocation,
    required this.score,
    required this.onTap,
  });

  final String title;
  final String subtitle;
  final String imagepath;
  final String textlocation;
  final String score;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 24.w),
      padding: EdgeInsets.only(
        top: 20.76.h,
        bottom: 0.78.h,
        left: 20.76.w,
        right: 20.76.w,
      ),
      height: 267.h,
      width: 350.w,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(24.r),
        border: Border.all(color: const Color(0xFFBEF9C4), width: 0.78.w),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        textDirection: TextDirection.rtl,
        children: [
          ListTile(
            contentPadding: EdgeInsets.zero,
            trailing: Image.asset(imagepath, width: 48.w, height: 48.h),
            title: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  title,
                  style: GoogleFonts.tajawal(
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w600,
                  ),
                  textAlign: TextAlign.right,
                ),
                SizedBox(height: 10.h),
                Text(
                  subtitle,
                  style: GoogleFonts.tajawal(
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w400,
                  ),
                  textAlign: TextAlign.right,
                ),
              ],
            ),
          ),

          SizedBox(height: 12.h),

          Row(
            textDirection: TextDirection.rtl,
            children: [
              Icon(
                Icons.location_on_outlined,
                color: const Color(0xFF737373),
                size: 20.r,
              ),
              SizedBox(width: 7.w),
              Text(
                textlocation,
                style: GoogleFonts.tajawal(
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w400,
                  color: const Color(0xFF737373),
                ),
              ),
              const Spacer(),
              ElevatedButton.icon(
                style: ElevatedButton.styleFrom(
                  elevation: 0,
                  padding: EdgeInsets.symmetric(
                    horizontal: 10.w,
                    vertical: 4.h,
                  ),
                  minimumSize: Size(66.w, 25.h),
                  side: BorderSide(
                    color: const Color(0xFFDC2626),
                    width: 0.78.w,
                  ),
                  backgroundColor: const Color(0xFFFEF2E7),
                ),
                iconAlignment: IconAlignment.end,
                icon: Image.asset(
                  'assets/icons/clock.png',
                  width: 13.w,
                  height: 13.h,
                ),
                onPressed: () {},
                label: Text(
                  score,
                  style: GoogleFonts.tajawal(
                    color: const Color(0xFFDC2626),
                    fontSize: 12.sp,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: 12.h),
          AppButton(
            text: 'ساعد الآن',
            onTap: onTap,
            size: Size(285.47.w, 38.h),
          ),
        ],
      ),
    );
  }
}
