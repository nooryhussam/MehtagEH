// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:google_fonts/google_fonts.dart';
// import 'package:mahtage_eh/core/routing/routes.dart';
// import 'package:mahtage_eh/widgets/button_app.dart';

// class CardTracking extends StatelessWidget {
//   const CardTracking({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       margin: EdgeInsets.symmetric(horizontal: 24.w),
//       padding: EdgeInsets.only(
//         top: 20.76.h,
//         bottom: 0.78.h,
//         left: 20.76.w,
//         right: 20.76.w,
//       ),
//       height: 165.h,
//       width: 333.w,
//       decoration: BoxDecoration(
//         color: Colors.white,
//         borderRadius: BorderRadius.circular(24.r),
//         border: Border.all(color: const Color(0xFFBEF9C4), width: 0.78.w),
//       ),
//       child: Column(
//         mainAxisAlignment: MainAxisAlignment.center,
//         mainAxisSize: MainAxisSize.min,
//         textDirection: TextDirection.rtl,
//         children: [
//           ListTile(
//             contentPadding: EdgeInsets.zero,
//             trailing: Image.asset(
//               'assets/images/food.png',
//               width: 48.w,
//               height: 48.h,
//             ),
//             title: Column(
//               crossAxisAlignment: CrossAxisAlignment.end,
//               children: [
//                 Row(
//                   mainAxisAlignment:
//                       MainAxisAlignment.end, // Aligns content to the right
//                   children: [
//                     Container(
//                       width: 76.09.w,
//                       height: 23.98.h,
//                       alignment: Alignment.center,
//                       decoration: BoxDecoration(
//                         color: const Color(0XFFD7F4D8),
//                         borderRadius: BorderRadius.circular(26061700),
//                       ),
//                       child: Text(
//                         "جاري التنفيذ",
//                         style: GoogleFonts.tajawal(
//                           fontSize: 12.sp,
//                           color: const Color(0xFF2BA12F),
//                           fontWeight: FontWeight.w600,
//                         ),
//                       ),
//                     ),
//                     SizedBox(width: 11.99.w),
//                     Text(
//                       'دواء ضغط الدم',
//                       style: GoogleFonts.tajawal(
//                         fontSize: 16.sp,
//                         fontWeight: FontWeight.w600,
//                       ),
//                       textAlign: TextAlign.right,
//                     ),
//                   ],
//                 ),
//                 SizedBox(height: 10.h),
//                 Text(
//                   'دواء شهري لمرضى القلب',
//                   style: GoogleFonts.tajawal(
//                     fontSize: 14.sp,
//                     fontWeight: FontWeight.w400,
//                   ),
//                   textAlign: TextAlign.right,
//                 ),
//               ],
//             ),
//           ),
//           SizedBox(height: 11.99.h),
//           AppButton(
//             text: 'تتبع الطلب',
//             onTap: () {
//               Navigator.pushNamed(context, AppRoutes.trackOrderScreenDonor);
//             },
//             size: Size(285.47.w, 38.h),
//           ),
//         ],
//       ),
//     );
//   }
// }
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
      padding: EdgeInsets.only(
        top: 20.76.h,
        bottom: 0.78.h,
        left: 20.76.w,
        right: 20.76.w,
      ),
      height: 165.h,
      width: 333.w,
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
                    SizedBox(width: 11.99.w),
                    Text(
                      title,
                      style: GoogleFonts.tajawal(
                        fontSize: 16.sp,
                        fontWeight: FontWeight.w600,
                      ),
                      textAlign: TextAlign.right,
                    ),
                  ],
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
          SizedBox(height: 11.99.h),
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
