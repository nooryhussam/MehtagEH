import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mahtage_eh/widgets/button_app.dart';

class CardTracking extends StatelessWidget {
  final String title;
  final String subtitle;
  final String location;
  final String priority;
  final String imagePath;
  final VoidCallback onTap;

  const CardTracking({
    super.key,
    required this.title,
    required this.subtitle,
    required this.location,
    required this.priority,
    required this.imagePath,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 24.w),
      padding: EdgeInsets.symmetric(
        horizontal: 20.76.w,
        vertical: 16.h,
      ),
      width: 333.w,
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
            trailing: Image.asset(imagePath, width: 48.w, height: 48.h),
            title: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: 10.w,
                        vertical: 4.h,
                      ),
                      decoration: BoxDecoration(
                        color: const Color(0XFFD7F4D8),
                        borderRadius: BorderRadius.circular(999),
                      ),
                      child: Text(
                        "جاري التنفيذ",
                        style: GoogleFonts.tajawal(
                          fontSize: 12.sp,
                          color: const Color(0xFF2BA12F),
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                    SizedBox(width: 8.w),
                    Expanded(
                      child: Text(
                        title,
                        style: GoogleFonts.tajawal(
                          fontSize: 16.sp,
                          fontWeight: FontWeight.w600,
                        ),
                        textAlign: TextAlign.right,
                        overflow: TextOverflow.ellipsis,
                            maxLines: 2,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 8.h),
                Text(
                  subtitle,
                  style: GoogleFonts.tajawal(
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w400,
                  ),
                  textAlign: TextAlign.right,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),
          SizedBox(height: 10.h),
          AppButton(
            text: 'تتبع الطلب',
            onTap: onTap,
            size: Size(285.47.w, 38.h),
          ),
        ],
      ),
    );
  }
}