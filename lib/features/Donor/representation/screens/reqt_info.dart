import 'package:flutter/material.dart';
import 'package:flutter_lucide/flutter_lucide.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mahtage_eh/features/Donor/data/model/recommendation_model.dart';
import 'package:mahtage_eh/features/Donor/representation/screens/tracking_donor.dart';
import 'package:mahtage_eh/widgets/button_orange.dart';
import 'package:mahtage_eh/widgets/detail_row.dart';
import 'package:mahtage_eh/widgets/order_confirmation.dart';

class ReqInfo extends StatelessWidget {
  final RecommendedRequest request;
  const ReqInfo({super.key, required this.request});

  @override
  Widget build(BuildContext context) {
    // Logic for Priority Badge
    final bool isUrgent = request.priority == 'عاجل';
    final Color badgeBg = isUrgent
        ? const Color(0xFFFFE2E2)
        : const Color(0xFFFFF3CD);
    final Color badgeText = isUrgent
        ? const Color(0xFFC10007)
        : const Color(0xFF856404);

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        scrolledUnderElevation: 0,
        elevation: 0,
        backgroundColor: Colors.white,
        leading: const SizedBox(),
        actions: [
          IconButton(
            onPressed: () => Navigator.pop(context),
            icon: Icon(
              Icons.arrow_forward,
              color: Colors.black,
              size: 22.sp, // Responsive icon size
            ),
          ),
        ],
        title: Text(
          'بيانات الطلب',
          style: GoogleFonts.tajawal(
            fontSize: 20.sp, // Scalable text
            fontWeight: FontWeight.w700,
            color: Colors.black,
          ),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Padding(
          // Added horizontal padding to prevent edge-touching on ultra-thin screens
          padding: EdgeInsets.symmetric(horizontal: 20.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(height: 30.h),

              // ── Request details card ────────────────────────────────────────
              Container(
                width: double.infinity, // Fill available responsive space
                constraints: BoxConstraints(
                  maxWidth: 340.w,
                ), // Prevent over-stretching on tablets
                padding: EdgeInsets.all(20.w),
                decoration: BoxDecoration(
                  color: Colors.white,
                  border: Border.all(
                    width: 1.5,
                    color: const Color(0xFFDCFCE7),
                  ),
                  borderRadius: BorderRadius.circular(
                    16.r,
                  ), // Responsive radius
                ),
                child: Column(
                  children: [
                    ListTile(
                      contentPadding: EdgeInsets.zero,
                      trailing: Image.asset(
                        _getImage(request.requestType),
                        width: 48.w,
                        height: 48.h,
                      ),
                      title: Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Text(
                            'نوع الطلب',
                            style: GoogleFonts.tajawal(
                              fontSize: 16.sp,
                              fontWeight: FontWeight.w600,
                              color: const Color(0xFF6A7282),
                            ),
                            textAlign: TextAlign.right,
                          ),
                          SizedBox(height: 8.h),
                          Text(
                            request.requestType,
                            style: GoogleFonts.tajawal(
                              fontSize: 14.sp,
                              fontWeight: FontWeight.w400,
                            ),
                            textAlign: TextAlign.right,
                          ),
                        ],
                      ),
                      leading: Container(
                        padding: EdgeInsets.symmetric(
                          horizontal: 12.w,
                          vertical: 4.h,
                        ),
                        decoration: BoxDecoration(
                          color: badgeBg,
                          borderRadius: BorderRadius.circular(20.r),
                        ),
                        child: Text(
                          request.priority,
                          style: GoogleFonts.tajawal(
                            color: badgeText,
                            fontSize: 12.sp,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: 20.h),

                    DetailRow(
                      icon: LucideIcons.box,
                      label: 'الوصف',
                      value: request.description,
                    ),
                    SizedBox(height: 12.h),

                    if (request.isFamily) ...[
                      DetailRow(
                        icon: Icons.person_outline,
                        label: 'عدد المستفيدين',
                        value: '${request.familyMembers} أشخاص',
                      ),
                      SizedBox(height: 12.h),
                    ],

                    DetailRow(
                      icon: Icons.location_on_outlined,
                      label: 'مكان التوصيل',
                      value: request.fullLocation,
                    ),

                    if (request.hasDisability) ...[
                      SizedBox(height: 12.h),
                      DetailRow(
                        icon: Icons.accessible_outlined,
                        label: 'ملاحظة',
                        value: 'صاحب الطلب لديه إعاقة',
                      ),
                    ],
                  ],
                ),
              ),

              SizedBox(height: 24.h),

              // ── Contact card ────────────────────────────────────────────────
              Container(
                width: double.infinity,
                constraints: BoxConstraints(maxWidth: 340.w),
                padding: EdgeInsets.all(20.w),
                decoration: BoxDecoration(
                  color: Colors.white,
                  border: Border.all(
                    width: 1.5,
                    color: const Color(0xFFDCFCE7),
                  ),
                  borderRadius: BorderRadius.circular(16.r),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  textDirection: TextDirection.rtl,
                  children: [
                    Text(
                      "وسيلة التواصل",
                      style: GoogleFonts.tajawal(
                        fontWeight: FontWeight.bold,
                        fontSize: 18.sp,
                      ),
                    ),
                    SizedBox(height: 16.h),
                    Text(
                      "رقم الهاتف",
                      style: GoogleFonts.tajawal(
                        fontWeight: FontWeight.w400,
                        color: const Color(0xFF6A7282),
                        fontSize: 12.sp,
                      ),
                    ),
                    SizedBox(height: 8.h),
                    Row(
                      textDirection: TextDirection.rtl,
                      children: [
                        Image.asset(
                          'assets/icons/telephone.png',
                          width: 20.w,
                          height: 20.h,
                        ),
                        SizedBox(width: 12.w),
                        Text(
                          request.needyPhone,
                          style: GoogleFonts.tajawal(
                            fontWeight: FontWeight.w500,
                            color: const Color(0xFF2BA12F),
                            fontSize: 16.sp,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),

              SizedBox(height: 40.h),

              // ── Confirm button ──────────────────────────────────────────────
              SizedBox(
                width: 311.w,
                child: OrangeButton(
                  text: 'ساعد الآن',
                  onTap: () {
                    // showDialog(
                    //   context: context,
                    //   builder: (context) => Dialog(
                    //     shape: RoundedRectangleBorder(
                    //       borderRadius: BorderRadius.circular(24.r),
                    //     ),
                    //     child: OrderConfirmation(
                    //       request: request,

                    //       onConfirmed: () {
                    //         Navigator.pop(context);
                    //         Navigator.push(
                    //           context,
                    //           MaterialPageRoute(
                    //             builder: (_) =>
                    //                 OrderTrackingDonorScreen(request: request),
                    //           ),
                    //         );
                    //       },
                    //     ),
                    //   ),
                    // );
                    showDialog(
                      context: context,
                      builder: (context) => OrderConfirmation(request: request),
                    );
                  },
                ),
              ),

              SizedBox(height: 40.h),
            ],
          ),
        ),
      ),
    );
  }

  String _getImage(String type) {
    switch (type) {
      case 'دواء':
      case 'علاج':
        return 'assets/images/firstaid.png';
      case 'ملابس':
      case 'لبس':
        return 'assets/images/cl2.png';
      default:
        return 'assets/images/food.png';
    }
  }
}
