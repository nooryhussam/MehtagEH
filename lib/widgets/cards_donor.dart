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
    required this.city,
    required this.village,
    required this.score,
    required this.onTap,
  });

  final String title;
  final String subtitle;
  final String imagepath;
  final String city;
  final String village;
  final String score;
  final VoidCallback onTap;

  Color _getBgColor() {
    switch (score) {
      case 'عاجل':
        return const Color(0xFFFFE2E2);
      case 'متوسط':
        return const Color(0XFFFEF2E7);
      case 'منخفض':
        return const Color(0xFFDCFCE7);
      default:
        return const Color(0xFFF3F4F6);
    }
  }

  Color _getTextColor() {
    switch (score) {
      case 'عاجل':
        return const Color(0xFFDC2626);
      case 'متوسط':
        return const Color(0xFFC1630B);
      case 'منخفض':
        return const Color(0xFF2BA12F);
      default:
        return const Color(0xFF6A7282);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 24.w),
      padding: EdgeInsets.symmetric(horizontal: 20.76.w, vertical: 16.h),
      width: 327.w,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(24.r),
        border: Border.all(color: const Color(0xFFBEF9C4), width: 0.78.w),
      ),
      child: Column(
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
                SizedBox(height: 6.h),
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
          SizedBox(height: 10.h),
          Row(
            textDirection: TextDirection.rtl,
            children: [
              Icon(
                Icons.location_on_outlined,
                color: const Color(0xFF737373),
                size: 18.r,
              ),
              SizedBox(width: 4.w),
              Text(
                "$city، $village",
                style: GoogleFonts.tajawal(
                  fontSize: 13.sp,
                  fontWeight: FontWeight.w400,
                  color: const Color(0xFF737373),
                ),
                overflow: TextOverflow.ellipsis,
              ),
              SizedBox(width: 16.w),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 4.h),
                decoration: BoxDecoration(
                  color: _getBgColor(),
                  borderRadius: BorderRadius.circular(999.r),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      score,
                      style: GoogleFonts.tajawal(
                        color: _getTextColor(),
                        fontSize: 12.sp,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    SizedBox(width: 4.w),
                    Icon(
                      Icons.access_time_outlined,
                      color: _getTextColor(),
                      size: 14.r,
                    ),
                  ],
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
