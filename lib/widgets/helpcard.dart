import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

class HelpCard extends StatelessWidget {
  const HelpCard({
    super.key,
    required this.onTap,
    required this.text1,
    required this.text2,
    required this.textButton,
  });

  final String text1;
  final String text2;
  final String textButton;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 343.w,
      height: 220.h,
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [Color(0xFF2BA12F), Color(0xFF165017)],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
        ),
        borderRadius: BorderRadius.circular(24.r),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 8.r,
            offset: Offset(0, 4.h),
          ),
        ],
      ),
      child: Stack(
        children: [
          // Background Image (Left Side)
          Positioned(
            left: -15.w,
            top: 0,
            bottom: 0,
            child: ClipRRect(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(16.r),
                bottomLeft: Radius.circular(16.r),
              ),
              child: Image.asset(
                'assets/images/hand (1).png',
                width: 176.w,
                height: 126.h,
                fit: BoxFit.cover,
              ),
            ),
          ),

          // Content (Right Side)
          Positioned(
            right: 16.w,
            top: 16.h,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  text1,
                  style: GoogleFonts.tajawal(
                    fontSize: 20.sp,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                SizedBox(height: 12.h),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    _buildChip('علاج'),
                    SizedBox(width: 8.w),
                    _buildChip('لبس'),
                    SizedBox(width: 8.w),
                    _buildChip('طعام'),
                  ],
                ),
                SizedBox(height: 16.h),
                Text(
                  text2,
                  style: GoogleFonts.tajawal(
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w400,
                    color: Colors.white,
                  ),
                ),
                SizedBox(height: 12.h),
                Align(
                  alignment: Alignment.bottomCenter,
                  child: Container(
                    decoration: BoxDecoration(
                      gradient: const LinearGradient(
                        colors: [Color(0xFFF38C2B), Color(0xffC1630B)],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      ),
                      borderRadius: BorderRadius.circular(20.r),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.2),
                          blurRadius: 4.r,
                          offset: Offset(0, 2.h),
                        ),
                      ],
                    ),
                    child: ElevatedButton(
                      onPressed: onTap,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.transparent,
                        shadowColor: Colors.transparent,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20.r),
                        ),
                        padding: EdgeInsets.symmetric(
                          horizontal: 32.w,
                          vertical: 10.h,
                        ),
                      ),
                      child: Text(
                        textButton,
                        style: GoogleFonts.tajawal(
                          fontSize: 16.sp,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildChip(String label) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 6.h),
      decoration: BoxDecoration(
        border: Border.all(color: const Color(0xFFF38C2B), width: 1.w),
        borderRadius: BorderRadius.circular(20.r),
      ),
      child: Text(
        label,
        style: GoogleFonts.tajawal(
          fontSize: 12.sp,
          fontWeight: FontWeight.w500,
          color: Colors.white,
        ),
      ),
    );
  }
}
