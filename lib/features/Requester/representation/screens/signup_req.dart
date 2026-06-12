import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:iconamoon/iconamoon.dart';
import 'package:mahtage_eh/core/model/validators.dart';
import 'package:mahtage_eh/core/routing/routes.dart';
import 'package:mahtage_eh/features/Requester/data/model/requester_model.dart';
import 'package:mahtage_eh/features/Requester/representation/cubit/requester_cubit.dart';
import 'package:mahtage_eh/features/Requester/representation/cubit/requester_state.dart';
import 'package:mahtage_eh/features/Requester/representation/cubit/id_state.dart';

import 'package:mahtage_eh/features/Requester/representation/cubit/id_cubit.dart';
import 'package:mahtage_eh/features/Requester/representation/screens/selected_image.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mahtage_eh/widgets/button_app.dart';
import 'package:mahtage_eh/widgets/custom_text.dart';
import 'package:mahtage_eh/widgets/custom_textfield.dart';

class SignUpReq extends StatefulWidget {
  const SignUpReq({super.key});

  @override
  State<SignUpReq> createState() => _SignUpReqstate();
}

class _SignUpReqstate extends State<SignUpReq> {
  final TextEditingController _namecontroller = TextEditingController();
  final TextEditingController _phonecontroller = TextEditingController();
  final TextEditingController _natinalcontroller = TextEditingController();
  final TextEditingController _passcontroller = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  String? _selectedImagePath;
  String? _imageErrorText;

  bool _isIdVerified = false;

  @override
  void initState() {
    super.initState();
    _natinalcontroller.addListener(() {
      if (_isIdVerified) {
        setState(() => _isIdVerified = false);
      }
    });
  }

  @override
  void dispose() {
    _namecontroller.dispose();
    _phonecontroller.dispose();
    _natinalcontroller.dispose();
    _passcontroller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => IdCubit(),
      child: MultiBlocListener(
        listeners: [
          BlocListener<IdCubit, IdState>(
            listener: (context, state) {
              if (state is IdSuccess) {
                setState(() => _isIdVerified = true);
                context.read<RequesterCubit>().signup(
                  RequesterModel(
                    name: _namecontroller.text.trim(),
                    password: _passcontroller.text,
                    phone: _phonecontroller.text.trim(),
                    nationalIdText: _natinalcontroller.text.trim(),
                    nationalIdImage: _selectedImagePath,
                  ),
                );
              } else if (state is IdError) {
                setState(() => _isIdVerified = false);
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(
                      state.message,
                      style: TextStyle(color: Color(0xFFFF3333)),
                      textAlign: TextAlign.right,
                    ),
                    backgroundColor: Colors.white,
                  ),
                );
              }
            },
          ),
          BlocListener<RequesterCubit, RequesterState>(
            listener: (context, state) {
              if (state is SignupSuccess) {
                Navigator.pushNamedAndRemoveUntil(
                  context,
                  AppRoutes.homeScreenRequester,
                  (route) => false,
                );
              } else if (state is RequesterError) {
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
          ),
        ],
        child: Scaffold(
          backgroundColor: Colors.white,
          body: SafeArea(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.w),
              child: BlocBuilder<RequesterCubit, RequesterState>(
                builder: (context, requesterState) {
                  return BlocBuilder<IdCubit, IdState>(
                    builder: (context, idState) {
                      return Stack(
                        children: [
                          SingleChildScrollView(
                            child: Column(
                              children: [
                                SizedBox(height: 6.h),
                                Image.asset(
                                  'assets/images/logo.png',
                                  height: 65.h,
                                  width: 93.w,
                                ),
                                SizedBox(height: 7.h),
                                Text(
                                  "تسجيل حساب",
                                  style: GoogleFonts.tajawal(
                                    fontWeight: FontWeight.w700,
                                    fontSize: 24.sp,
                                    color: Colors.black,
                                  ),
                                ),
                                SizedBox(height: 8.h),
                                Text(
                                  "يرجى استكمال البيانات المطلوبة",
                                  style: GoogleFonts.tajawal(
                                    fontWeight: FontWeight.w400,
                                    fontSize: 14.sp,
                                    color: const Color(0xFF747476),
                                  ),
                                ),
                                SizedBox(height: 32.h),
                                Form(
                                  key: _formKey,
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.end,
                                    children: [
                                      CustomTextField(
                                        width: double.infinity,
                                        suffixIcon: Icon(
                                          IconaMoon.profile,
                                          size: 24.r,
                                          color: const Color(0xFF666666),
                                        ),
                                        hint: "اسم المستخدم",
                                        controller: _namecontroller,
                                        validator: Validators.name,
                                        keyboardType: TextInputType.name,
                                      ),
                                      SizedBox(height: 16.h),
                                      CustomTextField(
                                        width: double.infinity,
                                        suffixIcon: Image.asset(
                                          'assets/icons/bx_lock.png',
                                          color: const Color(0xFF666666),
                                          width: 24.r,
                                          height: 24.r,
                                        ),
                                        hint: "كلمة السر",
                                        controller: _passcontroller,
                                        validator: Validators.password,
                                        keyboardType: TextInputType.text,
                                      ),
                                      SizedBox(height: 16.h),
                                      CustomTextField(
                                        width: double.infinity,
                                        suffixIcon: Image.asset(
                                          'assets/icons/phone.png',
                                          color: const Color(0xFF666666),
                                          width: 24.r,
                                          height: 24.r,
                                        ),
                                        hint: "رقم الهاتف",
                                        controller: _phonecontroller,
                                        keyboardType: TextInputType.number,
                                        validator: Validators.phone,
                                      ),
                                      SizedBox(height: 16.h),
                                      CustomTextField(
                                        width: double.infinity,
                                        suffixIcon: Image.asset(
                                          'assets/icons/icon-park-outline_id-card.png',
                                          color: const Color(0xFF666666),
                                          width: 24.r,
                                          height: 24.r,
                                        ),
                                        hint: "الرقم القومي",
                                        controller: _natinalcontroller,
                                        validator: Validators.nationalId,
                                        keyboardType: TextInputType.number,
                                      ),
                                      SizedBox(height: 24.h),
                                      Text(
                                        "إرفق صورة البطاقة الشخصية",
                                        style: GoogleFonts.tajawal(
                                          color: const Color(0xff666666),
                                          fontSize: 14.sp,
                                          fontWeight: FontWeight.w400,
                                        ),
                                      ),
                                      SizedBox(height: 14.h),
                                      SelectedImage(
                                        errorText: _imageErrorText,
                                        onImageSelected: (path) {
                                          setState(() {
                                            _selectedImagePath = path;
                                            _imageErrorText = null;
                                            _isIdVerified = false;
                                          });
                                        },
                                      ),
                                    ],
                                  ),
                                ),
                                SizedBox(height: 14.h),
                                Row(
                                  textDirection: TextDirection.rtl,
                                  children: [
                                    Image.asset(
                                      'assets/icons/warning.png',
                                      width: 18.r,
                                      height: 18.r,
                                    ),
                                    SizedBox(width: 8.w),
                                    Expanded(
                                      child: Text(
                                        "يرجى التأكد من إدخال صورة للبطاقة الأصلية وليست صورة ورقية أو مطبوعة",
                                        style: GoogleFonts.tajawal(
                                          fontSize: 12.sp,
                                          color: const Color(0xFF666666),
                                        ),
                                        textAlign: TextAlign.right,
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(height: 32.h),
                                AppButton(
                                  text: 'تأكيد',
                                  onTap: () {
                                    final isFormValid = _formKey.currentState!
                                        .validate();
                                    final isImageValid =
                                        _selectedImagePath != null;

                                    if (!isImageValid) {
                                      setState(
                                        () => _imageErrorText =
                                            "يرجى اختيار صورة البطاقة الشخصية",
                                      );
                                      return;
                                    }

                                    if (!isFormValid) return;

                                    context.read<IdCubit>().verifyIdData(
                                      imagePath: _selectedImagePath!,
                                      enteredNationalId: _natinalcontroller.text
                                          .trim(),
                                    );
                                  },
                                  size: Size(279.w, 48.h),
                                ),
                                SizedBox(height: 24.h),
                                CustomText(
                                  text1: 'لديك حساب بالفعل؟ ',
                                  text2: 'تسجيل الدخول',
                                  onTap: () => Navigator.pushNamed(
                                    context,
                                    AppRoutes.loginScreen,
                                  ),
                                ),
                                SizedBox(height: 16.h),
                              ],
                            ),
                          ),

                          if (requesterState is RequesterLoading ||
                              idState is IdLoading)
                            // Container(
                            //   color: Colors.black.withOpacity(0.3),
                            //   child: const
                            Center(
                              child: CircularProgressIndicator(
                                color: Color(0xFF1B5E20),
                              ),
                            ),
                          // ),
                        ],
                      );
                    },
                  );
                },
              ),
            ),
          ),
        ),
      ),
    );
  }
}
