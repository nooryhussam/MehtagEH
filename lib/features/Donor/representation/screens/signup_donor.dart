import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:iconamoon/iconamoon.dart';
import 'package:mahtage_eh/core/model/validators.dart';
import 'package:mahtage_eh/core/routing/routes.dart';
import 'package:mahtage_eh/features/Donor/data/model/donor_model.dart';
import 'package:mahtage_eh/features/Donor/representation/cubit/donor_cubit.dart';
import 'package:mahtage_eh/features/Donor/representation/cubit/donor_state.dart';
import 'package:mahtage_eh/widgets/app_style.dart';
import 'package:mahtage_eh/widgets/button_app.dart';
import 'package:mahtage_eh/widgets/custom_text.dart';
import 'package:mahtage_eh/widgets/custom_textfield.dart';

class SignUpDonor extends StatefulWidget {
  const SignUpDonor({super.key});

  @override
  State<SignUpDonor> createState() => _SignUpDonorState();
}

class _SignUpDonorState extends State<SignUpDonor> {
  final _namecontroller = TextEditingController();
  final _phonecontroller = TextEditingController();
  final _emailcontroller = TextEditingController();
  final _passcontroller = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  final List<String> users = ["متبرع", "جمعية"];
  String? selectedUser;

  @override
  void dispose() {
    _namecontroller.dispose();
    _phonecontroller.dispose();
    _emailcontroller.dispose();
    _passcontroller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: BlocConsumer<DonorCubit, DonorState>(
          listener: (context, state) {
            if (state is DonorSignupSuccess) {
              Navigator.pushNamedAndRemoveUntil(
                context,
                AppRoutes.homeScreenDonor,
                (route) => false,
              );
            } else if (state is DonorError) {
              ScaffoldMessenger.of(context).removeCurrentSnackBar();
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(
                    state.message,
                    style: const TextStyle(
                      color: Color(0xFFFF3333),
                      fontWeight: FontWeight.bold,
                    ),
                    textAlign: TextAlign.right,
                  ),
                  backgroundColor: const Color.fromARGB(255, 237, 237, 237),
                ),
              );
            }
          },
          builder: (context, state) {
            return Stack(
              children: [
                SingleChildScrollView(
                  padding: EdgeInsets.symmetric(horizontal: 20.w),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SizedBox(height: 8.h),
                      Image.asset(
                        'assets/images/logo.png',
                        height: 65.h,
                        width: 93.w,
                      ),
                      SizedBox(height: 7.h),
                      Text(
                        "تسجيل حساب",
                        style: GoogleFonts.tajawal(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                          fontSize: 24.sp,
                        ),
                      ),
                      SizedBox(height: 8.h),
                      Text(
                        "يرجى استكمال البيانات المطلوبة",
                        style: GoogleFonts.tajawal(
                          color: const Color(0xFF747476),
                          fontWeight: FontWeight.w400,
                          fontSize: 14.sp,
                        ),
                      ),
                      SizedBox(height: 72.h),
                      Form(
                        key: _formKey,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Directionality(
                              textDirection: TextDirection.rtl,
                              child: DropdownButtonFormField<String>(
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return "من فضلك اختر نوع المستخدم";
                                  }
                                  return null;
                                },
                                decoration: AppStyle.inputDecoration(
                                  hint: Text(
                                    'نوع المستخدم',
                                    textAlign: TextAlign.right,
                                    style: GoogleFonts.tajawal(
                                      fontSize: 14.sp,
                                      color: const Color(0xff999999),
                                    ),
                                  ),
                                ),
                                borderRadius: BorderRadius.circular(20.r),
                                initialValue: selectedUser,
                                items: users
                                    .map(
                                      (item) => DropdownMenuItem<String>(
                                        alignment:
                                            AlignmentGeometry.centerRight,
                                        value: item,
                                        child: Text(
                                          item,
                                          textAlign: TextAlign.right,
                                          style: TextStyle(fontSize: 14.sp),
                                        ),
                                      ),
                                    )
                                    .toList(),
                                onChanged: (value) =>
                                    setState(() => selectedUser = value),
                              ),
                            ),
                            SizedBox(height: 20.h),
                            CustomTextField(
                              suffixIcon: Icon(
                                IconaMoon.profile,
                                size: 24.r,
                                color: const Color(0xff666666),
                              ),
                              hint: "اسم المستخدم",
                              controller: _namecontroller,
                              keyboardType: TextInputType.text,
                              validator: Validators.name,
                              width: double.infinity,
                            ),
                            SizedBox(height: 16.h),
                            CustomTextField(
                              width: double.infinity,
                              suffixIcon: Icon(
                                Icons.email_outlined,
                                color: const Color(0xff666666),
                              ),
                              hint: "البريد الالكتروني",
                              controller: _emailcontroller,
                              keyboardType: TextInputType.emailAddress,
                              validator: Validators.email,
                            ),
                            SizedBox(height: 16.h),
                            CustomTextField(
                              width: double.infinity,
                              suffixIcon: Image.asset(
                                'assets/icons/bx_lock.png',
                                width: 24.r,
                                height: 24.r,
                                color: const Color(0xff666666),
                              ),
                              hint: "كلمة السر",
                              controller: _passcontroller,
                              keyboardType: TextInputType.text,
                              validator: Validators.password,
                            ),
                            SizedBox(height: 16.h),
                            CustomTextField(
                              width: double.infinity,
                              suffixIcon: Image.asset(
                                'assets/icons/phone.png',
                                width: 24.r,
                                height: 24.r,
                                color: const Color(0xff666666),
                              ),
                              hint: "رقم الهاتف",
                              controller: _phonecontroller,
                              keyboardType: TextInputType.number,
                              validator: Validators.phone,
                              inputFormatters: [
                                LengthLimitingTextInputFormatter(11),
                                FilteringTextInputFormatter.digitsOnly,
                              ],
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: 57.h),
                      AppButton(
                        text: 'التأكيد',
                        onTap: () {
                          if (_formKey.currentState!.validate()) {
                            context.read<DonorCubit>().signup(
                              DonorModel(
                                name: _namecontroller.text,
                                email: _emailcontroller.text,
                                password: _passcontroller.text,
                                phone: _phonecontroller.text,
                                donorType: selectedUser!,
                              ),
                            );
                          }
                        },
                        size: Size(279.w, 48.h),
                      ),
                      SizedBox(height: 36.h),
                      CustomText(
                        text1: 'لديك حساب بالفعل؟ ',
                        text2: 'تسجيل الدخول',
                        onTap: () =>
                            Navigator.pushNamed(context, AppRoutes.loginScreen),
                      ),
                      SizedBox(height: 16.h),
                    ],
                  ),
                ),

                // ← Loading overlay
                if (state is DonorLoading)
                  Container(
                    color: Colors.black.withOpacity(0.3),
                    child: const Center(
                      child: CircularProgressIndicator(
                        color: Color(0xFF1B5E20),
                      ),
                    ),
                  ),
              ],
            );
          },
        ),
      ),
    );
  }
}
