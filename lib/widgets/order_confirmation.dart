// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:google_fonts/google_fonts.dart';
// import 'package:mahtage_eh/core/routing/routes.dart';
// import 'package:mahtage_eh/features/Donor/data/model/recommendation_model.dart';
// import 'package:mahtage_eh/features/Donor/representation/cubit/donor_cubit.dart';

// import 'package:mahtage_eh/widgets/button_orange.dart';

// class OrderConfirmation extends StatelessWidget {
//   final RecommendedRequest request;
//   const OrderConfirmation({
//     super.key,
//     required this.request,
//     required Null Function() onConfirmed,
//   });

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       padding: EdgeInsets.all(24.r),
//       width: 319.w,
//       height: 373.h,
//       decoration: BoxDecoration(
//         boxShadow: [
//           BoxShadow(
//             color: const Color(0x40000000),
//             offset: Offset(-4.w, 8.h),
//             blurRadius: 8.r,
//             spreadRadius: 0,
//           ),
//           BoxShadow(
//             color: const Color(0x40000000),
//             offset: Offset(4.w, -8.h),
//             blurRadius: 8.r,
//             spreadRadius: 0,
//           ),
//         ],
//         color: Colors.white,
//         borderRadius: BorderRadius.circular(24.r),
//       ),
//       child: Column(
//         mainAxisSize: MainAxisSize.min,
//         children: [
//           Image.asset(
//             'assets/images/tracking.png',
//             width: 150.w,
//             height: 150.h,
//             fit: BoxFit.contain,
//           ),
//           SizedBox(height: 9.h),
//           Text(
//             'تأكيد التبرع',
//             style: GoogleFonts.tajawal(
//               color: Colors.black,
//               fontSize: 24.sp,
//               fontWeight: FontWeight.w700,
//             ),
//           ),
//           SizedBox(height: 8.h),
//           Text(
//             'بالضغط على تأكيد سيتم ارسال اشعار لمقدم الطلب ببدء تواصلك معه',
//             style: GoogleFonts.tajawal(
//               color: Colors.black,
//               fontSize: 14.sp,
//               fontWeight: FontWeight.w400,
//             ),
//             textAlign: TextAlign.right,
//             textDirection: TextDirection.rtl,
//           ),
//           const Spacer(),
//           OrangeButton(
//             text: 'تأكيد المساعدة',
//             onTap: () {
//               context.read<DonorCubit>().confirmDonation(request);
//               final navigator = Navigator.of(context, rootNavigator: true);
//               navigator.pop();
//               navigator.pushNamed(
//                 AppRoutes.trackOrderScreenDonor,
//                 arguments: request,
//               );
//             },
//           ),
//           SizedBox(height: 8.h),
//           TextButton(
//             onPressed: () => Navigator.pop(context),
//             child: Text(
//               'تراجع',
//               style: GoogleFonts.tajawal(fontSize: 16.sp, color: Colors.grey),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mahtage_eh/core/routing/routes.dart';
import 'package:mahtage_eh/features/Donor/data/model/recommendation_model.dart';
import 'package:mahtage_eh/features/Donor/representation/cubit/donor_cubit.dart';
import 'package:mahtage_eh/widgets/button_orange.dart';

class OrderConfirmation extends StatelessWidget {
  final RecommendedRequest request;

  const OrderConfirmation({super.key, required this.request});

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.transparent,
      insetPadding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 40.h),
      child: Container(
        width: double.infinity,
        padding: EdgeInsets.all(20.r),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(24.r),
          boxShadow: [
            BoxShadow(
              color: const Color(0x40000000),
              offset: Offset(-4.w, 8.h),
              blurRadius: 8.r,
            ),
            BoxShadow(
              color: const Color(0x40000000),
              offset: Offset(4.w, -8.h),
              blurRadius: 8.r,
            ),
          ],
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Image.asset(
              'assets/images/tracking.png',
              width: 120.w,
              height: 120.w,
              fit: BoxFit.contain,
            ),

            SizedBox(height: 12.h),

            Text(
              'تأكيد التبرع',
              style: GoogleFonts.tajawal(
                color: Colors.black,
                fontSize: 20.sp,
                fontWeight: FontWeight.w700,
              ),
            ),

            SizedBox(height: 8.h),

            Text(
              'بالضغط على تأكيد سيتم ارسال اشعار لمقدم الطلب ببدء تواصلك معه',
              style: GoogleFonts.tajawal(
                color: Colors.black,
                fontSize: 12.sp,
                fontWeight: FontWeight.w400,
              ),
              textAlign: TextAlign.center,
              textDirection: TextDirection.rtl,
            ),

            SizedBox(height: 20.h),

            SizedBox(
              width: double.infinity,
              child: OrangeButton(
                text: 'تأكيد المساعدة',
                onTap: () {
                  context.read<DonorCubit>().confirmDonation(request);
                  final navigator = Navigator.of(context, rootNavigator: true);
                  navigator.pop();
                  navigator.pushNamed(
                    AppRoutes.trackOrderScreenDonor,
                    arguments: request,
                  );
                },
              ),
            ),

            TextButton(
              onPressed: () => Navigator.pop(context),
              child: Text(
                'تراجع',
                style: GoogleFonts.tajawal(fontSize: 14.sp, color: Colors.grey),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
