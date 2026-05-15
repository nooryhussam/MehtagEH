import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mahtage_eh/core/routing/routes.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: [
        
          Expanded(
            flex: 5,
            child: Image.asset(
              'assets/images/Rectangle 1.png',
              width: double.infinity,
              fit: BoxFit.cover,
            ),
          ),

      
          Expanded(
            flex: 5,
            child: Container(
              width: double.infinity,
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  colors: [Colors.white, Color(0xFF207923)],
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                ),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
            
                  Container(
                    width: 243.w,
                    height: 48.h,
                    decoration: BoxDecoration(
                      gradient: const LinearGradient(
                        colors: [Color(0xFFF38C2B), Color(0xFFC1630B)],
                      ),
                      borderRadius: BorderRadius.circular(24.r),
                      boxShadow: [
                        BoxShadow(
                          color: const Color(0x40000000),
                          offset: Offset(0, 4.h),
                          blurRadius: 8.r,
                        ),
                      ],
                    ),
                    child: TextButton(
                      onPressed: () {
                        Navigator.pushNamed(context, AppRoutes.loginScreen);
                      },
                      child: Text(
                        "تسجيل الدخول",
                        style: GoogleFonts.tajawal(
                          fontSize: 18.sp,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),

                  SizedBox(height: 20.h),

                  SizedBox(
                    width: 243.w,
                    height: 48.h,
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.pushNamed(context, AppRoutes.onboarding);
                      },
                      style: ElevatedButton.styleFrom(
                        elevation: 6,
                        shadowColor: const Color(0x40000000),
                        backgroundColor: Colors.transparent,
                        side: BorderSide(
                          color: const Color(0xFFC1630B),
                          width: 2.w,
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(24.r),
                        ),
                      ),
                      child: Text(
                        "تسجيل حساب",
                        style: GoogleFonts.tajawal(
                          fontSize: 18.sp,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}