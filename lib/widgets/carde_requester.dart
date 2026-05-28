import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mahtage_eh/widgets/button_app.dart';
import '../features/Requester/data/model/order_model.dart';

class CardsRequester extends StatelessWidget {
  final OrderModel model;
  final String imagepath;
  final String textbutton;
  final Color color;
  final Color colorbutton;
  final VoidCallback onTap;

  const CardsRequester({
    super.key,
    required this.model,
    required this.imagepath,
    required this.textbutton,
    required this.color,
    required this.colorbutton,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 24.w),
      padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 16.h),
      width: double.infinity,
      // ← لا height ثابتة
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(24.r),
        border: Border.all(color: const Color(0xFFBEF9C4), width: 0.78.w),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        textDirection: TextDirection.rtl,
        children: [
          Row(
            textDirection: TextDirection.rtl,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // ── الصورة على اليمين ─────────────────────────────────
              Image.asset(imagepath, width: 48.w, height: 48.h),
              SizedBox(width: 12.w),
              // ── النص ─────────────────────────────────────────────
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Row(
                      textDirection: TextDirection.rtl,
                      children: [
                        Expanded(
                          child: Text(
                            model.title,
                            style: GoogleFonts.tajawal(
                              fontSize: 16.sp,
                              fontWeight: FontWeight.w600,
                            ),
                            textAlign: TextAlign.right,
                            maxLines: 2,
                          ),
                        ),
                        SizedBox(width: 8.w),
                        // Status badge
                        Container(
                          padding: EdgeInsets.symmetric(
                            horizontal: 10.w,
                            vertical: 4.h,
                          ),
                          decoration: BoxDecoration(
                            color: colorbutton,
                            borderRadius: BorderRadius.circular(999.r),
                          ),
                          child: Text(
                            model.statusLabel,
                            style: GoogleFonts.tajawal(
                              color: color,
                              fontSize: 12.sp,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 6.h),
                    Text(
                      model.description,
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
            ],
          ),
          SizedBox(height: 12.h),
          AppButton(text: textbutton, onTap: onTap, size: Size(285.47.w, 43.h)),
        ],
      ),
    );
  }
}
