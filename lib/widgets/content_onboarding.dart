import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart'; // 1. Import ScreenUtil
import 'package:google_fonts/google_fonts.dart';
import 'package:mahtage_eh/core/routing/routes.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class ContentOnboarding extends StatelessWidget {
  final String image;
  final String title;
  final String subTitle;
  final PageController controller;
  final int index;
  final int totalPages;

  const ContentOnboarding({
    super.key,
    required this.image,
    required this.title,
    required this.subTitle,
    required this.controller,
    required this.index,
    required this.totalPages,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(16.0.w), // Responsive padding
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          if (index != totalPages - 1)
            Align(
              alignment: Alignment.topRight,
              child: TextButton.icon(
                onPressed: () {
                  Navigator.pushNamed(context, AppRoutes.loginScreen);
                },
                icon: Icon(Icons.arrow_forward, size: 20.w),
                label: Text(
                  "تخطي",
                  style: GoogleFonts.openSans(
                    fontSize: 17.sp, // Responsive font
                    fontWeight: FontWeight.bold,
                  ),
                ),
                iconAlignment: IconAlignment.end,
                style: TextButton.styleFrom(
                  foregroundColor: const Color(0xFFF38C2B),
                ),
              ),
            ),

          Image.asset(image, width: 296.w, height: 296.h),

          SizedBox(height: 40.h),

          Text(
            title,
            style: GoogleFonts.tajawal(
              fontSize: 24.sp, // Responsive font
              fontWeight: FontWeight.bold,
            ),
          ),

          SizedBox(height: 20.h),

          Text(
            subTitle,
            style: GoogleFonts.openSans(fontSize: 16.sp),
            textAlign: TextAlign.center,
          ),

          SizedBox(height: 60.h),

          SmoothPageIndicator(
            controller: controller,
            count: totalPages,
            effect: WormEffect(
              activeDotColor: const Color(0xFF00812F),
              dotHeight: 8.h,
              dotWidth: 8.w,
              spacing: 10.w,
            ),
          ),

          SizedBox(height: 30.h),

          // Navigation Buttons
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              index != 0
                  ? ElevatedButton(
                      onPressed: () {
                        controller.previousPage(
                          duration: const Duration(milliseconds: 500),
                          curve: Curves.easeInOut,
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(
                            57.r,
                          ), // Responsive radius
                        ),
                        side: const BorderSide(
                          color: Color(0xFF00C247),
                          width: 2,
                        ),
                        padding: EdgeInsets.symmetric(
                          horizontal: 16.w,
                          vertical: 10.h,
                        ),
                        backgroundColor: Colors.white,
                        foregroundColor: const Color(0xFF00C247),
                      ),
                      child: Icon(Icons.arrow_back, size: 24.w),
                    )
                  : const SizedBox.shrink(),
              // Next/Start Button
              OutlinedButton.icon(
                onPressed: () {
                  if (index == totalPages - 1) {
                    Navigator.pushNamed(context, AppRoutes.chooseUser);
                  } else {
                    controller.nextPage(
                      duration: const Duration(milliseconds: 500),
                      curve: Curves.easeInOut,
                    );
                  }
                },
                icon: Icon(Icons.arrow_forward, size: 20.w),
                iconAlignment: IconAlignment.end,
                label: Text(
                  index == totalPages - 1 ? "ابدأ الآن" : "التالي",
                  style: GoogleFonts.openSans(
                    fontSize: 17.sp,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                style: OutlinedButton.styleFrom(
                  padding: EdgeInsets.symmetric(
                    horizontal: 16.w,
                    vertical: 10.h,
                  ),
                  backgroundColor: const Color(0xFF2BA12F),
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(56.r),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
