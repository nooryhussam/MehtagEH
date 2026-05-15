import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mahtage_eh/core/routing/routes.dart';
import 'package:mahtage_eh/widgets/app_style.dart';
import 'package:mahtage_eh/widgets/button_app.dart';
import 'package:mahtage_eh/widgets/custom_text.dart';

class ChooseUser extends StatefulWidget {
  const ChooseUser({super.key});

  @override
  State<ChooseUser> createState() => _ChooseUserState();
}

class _ChooseUserState extends State<ChooseUser> {
  final _formKey = GlobalKey<FormState>();
  final List<String> users = ['محتاج', "متبرع/جمعية"];
  String? selectedUser;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.w),
          child: Column(
            mainAxisSize: MainAxisSize.max,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(height: 16.h),

              Image.asset('assets/images/logo.png', height: 65.h, width: 93.w),
              SizedBox(height: 7.h),

              Text(
                "تسجيل حساب",
                style: GoogleFonts.tajawal(
                  color: Colors.black,
                  fontWeight: FontWeight.w700,
                  fontSize: 24.sp,
                ),
              ),
              SizedBox(height: 8.h),

              Text(
                "يرجى استكمال البيانات المطلوبة",
                style: GoogleFonts.tajawal(
                  fontSize: 14.sp,
                  color: const Color(0xFF747476),
                  fontWeight: FontWeight.w400,
                ),
              ),

              const Spacer(flex: 2),

              Align(
                alignment: Alignment.centerRight,
                child: Text(
                  "نوع المستخدم",
                  style: GoogleFonts.tajawal(
                    fontSize: 14.sp,
                    color: Colors.black,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ),
              SizedBox(height: 10.h),

              // Dropdown
              Directionality(
                textDirection: TextDirection.rtl,
                child: Form(
                  key: _formKey,
                  child: DropdownButtonFormField<String>(
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "من فضلك اختر نوع المستخدم";
                      }
                      return null;
                    },
                    decoration: AppStyle.inputDecoration(
                      hint: Text(
                        'محتاج/متبرع',
                        textAlign: TextAlign.right,
                        style: GoogleFonts.tajawal(
                          fontSize: 12.sp,
                          color: const Color(0xFFB3B3B3),
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ),
                    borderRadius: BorderRadius.circular(20.r),
                    initialValue: selectedUser,
                    items: users
                        .map(
                          (item) => DropdownMenuItem<String>(
                            alignment: AlignmentGeometry.centerRight,
                            value: item,
                            child: Text(
                              item,
                              textAlign: TextAlign.right,
                              style: GoogleFonts.tajawal(fontSize: 14.sp),
                            ),
                          ),
                        )
                        .toList(),
                    onChanged: (value) {
                      setState(() => selectedUser = value);
                    },
                  ),
                ),
              ),

              const Spacer(flex: 4),

              AppButton(
                text: 'إستمرار',
                onTap: () {
                  if (_formKey.currentState!.validate()) {
                    if (selectedUser == "محتاج") {
                      Navigator.pushNamed(context, AppRoutes.signUpReq);
                    } else if (selectedUser == "متبرع/جمعية") {
                      Navigator.pushNamed(context, AppRoutes.signUpDonor);
                    }
                  }
                },
                size: Size(279.w, 48.h),
              ),

              const Spacer(flex: 1),

              CustomText(
                text1: "لديك حساب بالفعل؟ ",
                text2: "تسجيل دخول ",
                onTap: () {
                  Navigator.pushNamed(context, AppRoutes.loginScreen);
                },
              ),
              SizedBox(height: 16.h),
            ],
          ),
        ),
      ),
    );
  }
}
